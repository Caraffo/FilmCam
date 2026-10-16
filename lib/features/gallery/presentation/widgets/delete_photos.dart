import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/gallery_photo.dart';
import '../gallery_providers.dart';

/// Pide confirmación y borra las fotos. Avisa el resultado con un snackbar
/// y devuelve cuántas se borraron.
Future<int> confirmAndDeletePhotos(
  BuildContext context,
  WidgetRef ref,
  List<GalleryPhoto> photos,
) async {
  final count = photos.length;
  final confirmed = await showCupertinoDialog<bool>(
    context: context,
    builder: (dialogContext) => CupertinoAlertDialog(
      title: Text(count == 1 ? '¿Borrar la foto?' : '¿Borrar $count fotos?'),
      content: const Text('También se borran de la galería del teléfono.'),
      actions: [
        CupertinoDialogAction(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: const Text('Cancelar'),
        ),
        CupertinoDialogAction(
          isDestructiveAction: true,
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: const Text('Borrar'),
        ),
      ],
    ),
  );
  if (!(confirmed ?? false) || !context.mounted) return 0;

  final messenger = ScaffoldMessenger.of(context);
  try {
    final deleted = await ref
        .read(galleryPhotosProvider.notifier)
        .deletePhotos(photos);
    if (deleted == 0) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No se borró ninguna foto')),
      );
    }
    return deleted;
  } catch (error) {
    messenger.showSnackBar(
      SnackBar(content: Text('No se pudieron borrar las fotos: $error')),
    );
    return 0;
  }
}
