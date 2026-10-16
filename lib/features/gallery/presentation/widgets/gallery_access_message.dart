import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../data/gallery_photo.dart';
import '../gallery_providers.dart';

/// Error al leer la galería, con la salida según el caso.
class GalleryAccessMessage extends ConsumerWidget {
  const GalleryAccessMessage({super.key, required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final denied = error is GalleryAccessDenied;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              denied
                  ? 'Para ver tus fotos, FilmCam necesita permiso para leer la galería.'
                  : 'No se pudieron cargar las fotos: $error',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.m),
            TextButton(
              onPressed: denied
                  ? ref
                        .read(galleryPhotosProvider.notifier)
                        .openPermissionSettings
                  : () => ref.invalidate(galleryPhotosProvider),
              child: Text(denied ? 'Abrir ajustes' : 'Reintentar'),
            ),
            if (denied)
              TextButton(
                onPressed: () => ref.invalidate(galleryPhotosProvider),
                child: const Text('Ya le di permiso'),
              ),
          ],
        ),
      ),
    );
  }
}
