import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_filter.dart';

/// Ancho de referencia del preview antes de escalarlo al recorte; solo fija
/// la proporción, el tamaño final lo da el padre.
const double _referenceWidth = 1000;

/// Preview de la cámara con el look aplicado, recortado al centro con la
/// relación de aspecto [aspectRatio] (ancho / alto).
class CroppedCameraPreview extends StatelessWidget {
  const CroppedCameraPreview({
    super.key,
    required this.controller,
    required this.look,
    required this.aspectRatio,
  });

  final CameraController controller;
  final FilmPreset look;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: ClipRect(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _referenceWidth,
            // El aspect ratio de la cámara viene en horizontal.
            height: _referenceWidth * controller.value.aspectRatio,
            child: FilmFilter(
              look: look,
              animateChanges: true,
              child: CameraPreview(controller),
            ),
          ),
        ),
      ),
    );
  }
}
