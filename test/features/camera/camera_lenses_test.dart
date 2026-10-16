import 'package:camera/camera.dart';
import 'package:filmcam/features/camera/data/camera_lenses.dart';
import 'package:flutter_test/flutter_test.dart';

CameraDescription _camera(String name, CameraLensDirection direction) =>
    CameraDescription(
      name: name,
      lensDirection: direction,
      sensorOrientation: 90,
    );

void main() {
  test('como en el S25+: trasera, frontal, gran angular y otra frontal', () {
    final lenses = CameraLenses.from([
      _camera('0', CameraLensDirection.back),
      _camera('1', CameraLensDirection.front),
      _camera('2', CameraLensDirection.back),
      _camera('3', CameraLensDirection.front),
    ]);
    expect(lenses.main, 0);
    expect(lenses.ultraWide, 2);
    expect(lenses.front, 1);
  });

  test('con una sola cámara trasera no hay gran angular', () {
    final lenses = CameraLenses.from([
      _camera('0', CameraLensDirection.back),
      _camera('1', CameraLensDirection.front),
    ]);
    expect(lenses.ultraWide, isNull);
  });
}
