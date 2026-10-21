import 'package:camera/camera.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'camera_lenses.dart';

part 'camera_state.freezed.dart';

/// Margen para considerar que el zoom está "en" una lente del selector.
const double _stopTolerance = 0.05;

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

    /// Rango de zoom de la cámara abierta.
    required double minZoom,
    required double maxZoom,
  }) = _CameraState;

  bool get isFront => cameraIndex == lenses.front;

  bool get isUltraWide => cameraIndex == lenses.ultraWide;

  /// Zoom tal como se muestra: el gran angular a 1× de su cámara es 0.6×.
  double get displayZoom => isUltraWide ? kUltraWideStop * zoom : zoom;

  /// "Lente" del selector a resaltar: la mayor que no supera el zoom actual.
  double? get selectedStop {
    final reached = zoomStops.where((s) => s <= displayZoom + _stopTolerance);
    return reached.isEmpty ? zoomStops.firstOrNull : reached.last;
  }
}
