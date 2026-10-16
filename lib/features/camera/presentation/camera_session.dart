import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/camera_lenses.dart';
import '../data/camera_state.dart';

part 'camera_session.g.dart';

const _flashCycle = [FlashMode.off, FlashMode.auto, FlashMode.always];

/// Cámara abierta y sus ajustes. Se cierra con [close] cuando la app pasa a
/// segundo plano y se reabre invalidando el provider.
@Riverpod(keepAlive: true)
class CameraSession extends _$CameraSession {
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
    await controller.setFlashMode(FlashMode.off);
    return CameraState(
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
    await current.controller.setZoomLevel(stop);
    state = AsyncData(current.copyWith(zoom: stop));
  }

  Future<void> cycleFlash() async {
    final current = _current;
    final next =
        _flashCycle[(_flashCycle.indexOf(current.flashMode) + 1) %
            _flashCycle.length];
    await current.controller.setFlashMode(next);
    state = AsyncData(current.copyWith(flashMode: next));
  }

  Future<void> setExposureOffset(double offset) async {
    final current = _current;
    final applied = await current.controller.setExposureOffset(offset);
    state = AsyncData(current.copyWith(exposureOffset: applied));
  }

  Future<XFile> takePicture() => _current.controller.takePicture();

  Future<void> close() async {
    final controller = state.value?.controller;
    state = const AsyncLoading();
    await controller?.dispose();
  }
}
