import 'dart:ui' show Offset;

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../settings/data/app_setting.dart';
import '../../settings/presentation/settings_providers.dart';
import '../data/camera_lenses.dart';
import '../data/latest_value_applier.dart';
import '../data/camera_state.dart';

part 'camera_session.g.dart';

const _flashCycle = [FlashMode.off, FlashMode.auto, FlashMode.always];

/// Pellizcando la principal por debajo de este zoom se pasa al gran angular.
const double _switchToUltraWideBelow = 0.9;

/// Cámara abierta y sus ajustes. Se cierra con [close] cuando la app pasa a
/// segundo plano y se reabre invalidando el provider.
@Riverpod(keepAlive: true)
class CameraSession extends _$CameraSession {
  late final _zoomApplier = LatestValueApplier<double>(
    (zoom) => _current.controller.setZoomLevel(zoom),
    description: 'el zoom',
  );
  late final _exposureApplier = LatestValueApplier<double>(
    (offset) => _current.controller.setExposureOffset(offset),
    description: 'la exposición',
  );

  @override
  Future<CameraState> build() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      throw CameraException('no_camera', 'El dispositivo no tiene cámaras.');
    }
    final lenses = CameraLenses.from(cameras);
    return _open(cameras, lenses, lenses.main);
  }

  Future<CameraState> _open(
    List<CameraDescription> cameras,
    CameraLenses lenses,
    int index, {
    List<double> knownZoomStops = const [],
  }) async {
    final controller = CameraController(
      cameras[index],
      ResolutionPreset.max,
      enableAudio: false,
    );
    ref.onDispose(controller.dispose);
    await controller.initialize();
    // La frontal no tiene flash; en las traseras se usa el último elegido.
    final flashMode = index == lenses.front ? FlashMode.off : _savedFlashMode();
    await controller.setFlashMode(flashMode);
    return CameraState(
      flashMode: flashMode,
      minZoom: await controller.getMinZoomLevel(),
      maxZoom: await controller.getMaxZoomLevel(),
      controller: controller,
      cameras: cameras,
      lenses: lenses,
      cameraIndex: index,
      zoomStops: index == lenses.front
          ? const []
          : knownZoomStops.isNotEmpty
          ? knownZoomStops
          : await _zoomStops(controller, lenses),
      minExposureOffset: await controller.getMinExposureOffset(),
      maxExposureOffset: await controller.getMaxExposureOffset(),
    );
  }

  /// Los zooms que soporta [controller], más el gran angular. Se calculan
  /// con la cámara principal y se reutilizan al cambiar de lente.
  Future<List<double>> _zoomStops(
    CameraController controller,
    CameraLenses lenses,
  ) async {
    final maxZoom = await controller.getMaxZoomLevel();
    return [
      if (lenses.ultraWide != null) kUltraWideStop,
      for (final stop in kMainZoomStops)
        if (stop <= maxZoom) stop,
    ];
  }

  CameraState get _current => state.requireValue;

  Future<void> _reopen(int index) async {
    final current = _current;
    if (current.cameraIndex == index) return;
    state = const AsyncLoading();
    await current.controller.dispose();
    state = await AsyncValue.guard(
      () => _open(
        current.cameras,
        current.lenses,
        index,
        knownZoomStops: current.zoomStops,
      ),
    );
  }

  /// Alterna entre la cámara trasera principal y la frontal.
  Future<void> switchCamera() async {
    final current = _current;
    final front = current.lenses.front;
    await _reopen(
      current.isFront || front == null ? current.lenses.main : front,
    );
  }

  /// Elige una "lente" del selector: el gran angular cambia de cámara; el
  /// resto es zoom sobre la principal.
  Future<void> selectZoomStop(double stop) async {
    final lenses = _current.lenses;
    final ultraWide = lenses.ultraWide;
    if (stop < 1 && ultraWide != null) {
      await _reopen(ultraWide);
      return;
    }
    await _reopen(lenses.main);
    final current = _current;
    final zoom = stop.clamp(current.minZoom, current.maxZoom);
    await current.controller.setZoomLevel(zoom);
    state = AsyncData(current.copyWith(zoom: zoom));
  }

  /// Zoom continuo mientras se pellizca el visor ([displayZoom] es el que
  /// se muestra, 0.6 en el gran angular). Se queda dentro del rango de la
  /// cámara abierta; el cambio de cámara se decide en [endPinch].
  void pinchZoomTo(double displayZoom) {
    final current = state.value;
    if (current == null) return;
    final factor = current.isUltraWide ? kUltraWideStop : 1.0;
    final zoom = (displayZoom / factor).clamp(current.minZoom, current.maxZoom);
    if (zoom == current.zoom) return;
    state = AsyncData(current.copyWith(zoom: zoom));
    _zoomApplier.push(zoom);
  }

  /// Al soltar el pellizco: si se pidió menos que la principal se pasa al
  /// gran angular, y si en el gran angular se llegó a 1× se vuelve a la
  /// principal con ese zoom.
  Future<void> endPinch(double requestedDisplayZoom) async {
    final current = state.value;
    if (current == null) return;
    final onMain = current.cameraIndex == current.lenses.main;
    if (onMain &&
        current.lenses.ultraWide != null &&
        requestedDisplayZoom < _switchToUltraWideBelow) {
      await selectZoomStop(kUltraWideStop);
    } else if (current.isUltraWide && requestedDisplayZoom >= 1) {
      await selectZoomStop(requestedDisplayZoom);
    }
  }

  Future<void> cycleFlash() async {
    final current = _current;
    final next =
        _flashCycle[(_flashCycle.indexOf(current.flashMode) + 1) %
            _flashCycle.length];
    await current.controller.setFlashMode(next);
    state = AsyncData(current.copyWith(flashMode: next));
    await ref
        .read(settingsRepositoryProvider)
        .setChoice(StoredChoice.flashMode, next.name);
  }

  FlashMode _savedFlashMode() {
    final saved = ref
        .read(settingsRepositoryProvider)
        .getChoice(StoredChoice.flashMode);
    final mode = FlashMode.values.asNameMap()[saved];
    return _flashCycle.contains(mode) ? mode! : FlashMode.off;
  }

  /// Brillo de la cámara; se puede llamar seguido mientras se arrastra.
  void setExposureOffset(double offset) {
    final current = state.value;
    if (current == null) return;
    final clamped = offset.clamp(
      current.minExposureOffset,
      current.maxExposureOffset,
    );
    state = AsyncData(current.copyWith(exposureOffset: clamped));
    _exposureApplier.push(clamped);
  }

  /// Enfoca y mide la luz en [point] (coordenadas 0 a 1 del preview).
  Future<void> focusAt(Offset point) async {
    final controller = state.value?.controller;
    if (controller == null) return;
    try {
      await controller.setFocusPoint(point);
      await controller.setExposurePoint(point);
    } on CameraException catch (error) {
      // Algunas cámaras (como ciertas frontales) no enfocan por punto.
      debugPrint('No se pudo enfocar en $point: $error');
    }
  }

  Future<XFile> takePicture() => _current.controller.takePicture();

  Future<void> close() async {
    final controller = state.value?.controller;
    state = const AsyncLoading();
    await controller?.dispose();
  }
}
