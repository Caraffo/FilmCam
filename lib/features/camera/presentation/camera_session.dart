import 'package:camera/camera.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
    final backIndex = cameras.indexWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
    );
    return _open(cameras, backIndex == -1 ? 0 : backIndex);
  }

  Future<CameraState> _open(List<CameraDescription> cameras, int index) async {
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
      cameraIndex: index,
      minExposureOffset: await controller.getMinExposureOffset(),
      maxExposureOffset: await controller.getMaxExposureOffset(),
      minZoom: await controller.getMinZoomLevel(),
      maxZoom: await controller.getMaxZoomLevel(),
    );
  }

  CameraState get _current => state.requireValue;

  Future<void> switchCamera() async {
    final current = _current;
    final nextIndex = (current.cameraIndex + 1) % current.cameras.length;
    state = const AsyncLoading();
    await current.controller.dispose();
    state = await AsyncValue.guard(() => _open(current.cameras, nextIndex));
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

  Future<void> setZoom(double zoom) async {
    final current = _current;
    await current.controller.setZoomLevel(zoom);
    state = AsyncData(current.copyWith(zoom: zoom));
  }

  Future<XFile> takePicture() => _current.controller.takePicture();

  Future<void> close() async {
    final controller = state.value?.controller;
    state = const AsyncLoading();
    await controller?.dispose();
  }
}
