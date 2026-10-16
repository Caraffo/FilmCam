import 'package:camera/camera.dart';

/// Zoom con el que se presenta el gran angular (como en la cámara de
/// Samsung y iPhone).
const double kUltraWideStop = 0.6;

/// Zooms digitales ofrecidos sobre la cámara principal.
const List<double> kMainZoomStops = [1, 2, 3];

/// Qué cámara del dispositivo cumple cada rol.
///
/// Android no informa el tipo de lente: se toma la primera cámara trasera
/// como principal y la siguiente trasera como gran angular (así las expone
/// Samsung).
class CameraLenses {
  const CameraLenses({required this.main, this.ultraWide, this.front});

  factory CameraLenses.from(List<CameraDescription> cameras) {
    final back = [
      for (var i = 0; i < cameras.length; i++)
        if (cameras[i].lensDirection == CameraLensDirection.back) i,
    ];
    final front = cameras.indexWhere(
      (c) => c.lensDirection == CameraLensDirection.front,
    );
    return CameraLenses(
      main: back.isEmpty ? 0 : back.first,
      ultraWide: back.length > 1 ? back[1] : null,
      front: front == -1 ? null : front,
    );
  }

  final int main;
  final int? ultraWide;
  final int? front;
}
