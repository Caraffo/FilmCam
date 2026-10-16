import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'camera_lenses.dart';

part 'camera_state.freezed.dart';

@freezed
abstract class CameraState with _$CameraState {
  const CameraState._();

  const factory CameraState({
    required CameraController controller,
    required List<CameraDescription> cameras,
    required CameraLenses lenses,
    required int cameraIndex,

    /// "Lentes" que ofrece el selector (0.6 es el gran angular). Vacío con
    /// la cámara frontal.
    required List<double> zoomStops,
    @Default(FlashMode.off) FlashMode flashMode,
    @Default(0) double exposureOffset,
    required double minExposureOffset,
    required double maxExposureOffset,
    @Default(1) double zoom,
  }) = _CameraState;

  bool get isFront => cameraIndex == lenses.front;

  /// Zoom elegido en el selector.
  double get selectedStop =>
      cameraIndex == lenses.ultraWide ? kUltraWideStop : zoom;
}
