import 'package:flutter/material.dart';

import '../../../../core/widgets/fade_in_memory_image.dart';

import '../../../camera/data/captured_photo.dart';
import 'status_pill.dart';

/// La foto recién sacada mientras se revela. El original todavía no está
/// recortado, así que se muestra encuadrado con la relación de aspecto.
class PendingCapturePage extends StatelessWidget {
  const PendingCapturePage({super.key, required this.photo});

  final CapturedPhoto photo;

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final decodeWidth = (media.size.width * media.devicePixelRatio).round();
    final filtered = photo.filtered;
    final error = photo.processingError;
    return Stack(
      fit: StackFit.expand,
      children: [
        Center(
          child: filtered != null
              ? FadeInMemoryImage(filtered, cacheWidth: decodeWidth)
              : AspectRatio(
                  aspectRatio: photo.aspect.ratio,
                  child: ClipRect(
                    child: Image.memory(
                      photo.original,
                      fit: BoxFit.cover,
                      cacheWidth: decodeWidth,
                    ),
                  ),
                ),
        ),
        if (filtered == null)
          Center(
            child: error == null
                ? const StatusPill(text: 'Revelando…', loading: true)
                : StatusPill(text: 'No se pudo revelar la foto: $error'),
          ),
      ],
    );
  }
}
