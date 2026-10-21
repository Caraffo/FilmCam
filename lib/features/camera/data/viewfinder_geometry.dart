import 'dart:math' as math;
import 'dart:ui';

/// Rectángulo que ocupa el visor (con la relación de aspecto [aspectRatio],
/// ancho / alto) centrado dentro de un área de [area].
Rect viewfinderRect(Size area, double aspectRatio) {
  final width = math.min(area.width, area.height * aspectRatio);
  final height = width / aspectRatio;
  return Rect.fromCenter(
    center: area.center(Offset.zero),
    width: width,
    height: height,
  );
}

/// Pasa un punto tocado dentro del visor recortado ([box]) a coordenadas de
/// 0 a 1 del preview completo de la cámara, que se muestra recortado al
/// centro. [cameraAspectRatio] es el de la cámara (ancho / alto en
/// horizontal, o sea alto / ancho en vertical).
Offset previewPointFor(Offset point, Size box, double cameraAspectRatio) {
  final scale = math.max(box.width, box.height / cameraAspectRatio);
  final previewWidth = scale;
  final previewHeight = scale * cameraAspectRatio;
  final left = (box.width - previewWidth) / 2;
  final top = (box.height - previewHeight) / 2;
  return Offset(
    ((point.dx - left) / previewWidth).clamp(0.0, 1.0),
    ((point.dy - top) / previewHeight).clamp(0.0, 1.0),
  );
}
