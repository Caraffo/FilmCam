import 'dart:ui';

import 'package:filmcam/features/camera/data/viewfinder_geometry.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  // Preview vertical 3:4: alto = ancho × 4/3.
  const cameraAspect = 4 / 3;

  test('el visor 3:4 ocupa el ancho y queda centrado', () {
    final rect = viewfinderRect(const Size(300, 600), 3 / 4);
    expect(rect, const Rect.fromLTWH(0, 100, 300, 400));
  });

  test('en 3:4 el punto tocado es el mismo del preview', () {
    final point = previewPointFor(
      const Offset(75, 100),
      const Size(300, 400),
      cameraAspect,
    );
    expect(point.dx, closeTo(0.25, 1e-9));
    expect(point.dy, closeTo(0.25, 1e-9));
  });

  test('en 1:1 se compensa el recorte de arriba y abajo', () {
    // El preview de 300×400 se recorta a 300×300: sobran 50 arriba.
    final top = previewPointFor(
      Offset.zero,
      const Size(300, 300),
      cameraAspect,
    );
    expect(top.dy, closeTo(50 / 400, 1e-9));
    final center = previewPointFor(
      const Offset(150, 150),
      const Size(300, 300),
      cameraAspect,
    );
    expect(center, const Offset(0.5, 0.5));
  });
}
