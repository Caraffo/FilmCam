import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_filter.dart';

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
        // El preview se arma al ancho real del recorte: si se armara más
        // grande y se achicara, el filtro trabajaría sobre muchos más píxeles.
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            // El aspect ratio de la cámara viene en horizontal.
            final height = width * controller.value.aspectRatio;
            return OverflowBox(
              maxWidth: width,
              maxHeight: height < constraints.maxHeight
                  ? constraints.maxHeight
                  : height,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: width,
                  height: height,
                  child: FilmFilter(
                    look: look,
                    animateChanges: true,
                    child: CameraPreview(controller),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
