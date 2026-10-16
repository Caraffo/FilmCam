import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'camera_state.freezed.dart';

@freezed
abstract class CameraState with _$CameraState {
  const factory CameraState({
    required CameraController controller,
    required List<CameraDescription> cameras,
    required int cameraIndex,
    @Default(FlashMode.off) FlashMode flashMode,
    @Default(0) double exposureOffset,
    required double minExposureOffset,
    required double maxExposureOffset,
    @Default(1) double zoom,
    required double minZoom,
    required double maxZoom,
  }) = _CameraState;
}
