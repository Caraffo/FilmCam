import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/fade_in_memory_image.dart';
import '../../../editor/data/photo_edit_request.dart';
import '../../../editor/presentation/screens/photo_editor_screen.dart';
import '../../../film/data/builtin_presets.dart';
import '../../data/gallery_photo.dart';
import '../../data/photo_record.dart';
import '../gallery_providers.dart';
import 'before_after_view.dart';

/// Una foto de la galería, con el comparador si la app guardó su original,
/// y las acciones de editar y guardar el original.
class GalleryPhotoPage extends ConsumerWidget {
  const GalleryPhotoPage({
    super.key,
    required this.photo,
    required this.onEdited,
  });

  final GalleryPhoto photo;

  /// Se llama cuando se guardó una edición de esta foto.
  final VoidCallback onEdited;

  Future<void> _edit(
    BuildContext context,
    Uint8List bytes,
    PhotoRecord? record,
    Uint8List? original,
  ) async {
    final hasOriginal = record != null && original != null;
    final saved = await Navigator.of(context).push(
      PhotoEditorScreen.route(
        PhotoEditRequest(
          source: hasOriginal ? original : bytes,
          originalKey: hasOriginal ? record.originalKey : null,
          // Sin original, la foto ya tiene el look: se edita desde neutro.
          look: hasOriginal ? record.look : kOriginalPreset,
          dateStamp: hasOriginal ? record.dateStamp : null,
          takenAt: photo.asset.createDateTime,
          photo: photo,
        ),
      ),
    );
    if (saved ?? false) onEdited();
  }

  Future<void> _exportOriginal(
    BuildContext context,
    WidgetRef ref,
    PhotoRecord record,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(galleryPhotosProvider.notifier).exportOriginal(record);
      messenger.showSnackBar(
        const SnackBar(content: Text('Original guardado en la galería')),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo guardar el original: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final media = MediaQuery.of(context);
    final decodeWidth = (media.size.width * media.devicePixelRatio).round();
    final bytesAsync = ref.watch(galleryPhotoBytesProvider(photo));
    final key = photo.key;
    final record = key == null
        ? null
        : ref.watch(photoRecordProvider(key)).value;
    final original = record == null
        ? null
        : ref.watch(originalBytesProvider(record.originalKey)).value;

    return bytesAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) =>
          Center(child: Text('No se pudo abrir la foto: $error')),
      data: (bytes) => Column(
        children: [
          Expanded(
            child: original != null
                ? BeforeAfterView(
                    original: original,
                    filtered: bytes,
                    decodeWidth: decodeWidth,
                  )
                : FadeInMemoryImage(bytes, cacheWidth: decodeWidth),
          ),
          const SizedBox(height: Spacing.m),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () => _edit(context, bytes, record, original),
                icon: const Icon(CupertinoIcons.slider_horizontal_3),
                label: const Text('Editar'),
              ),
              if (record != null && original != null) ...[
                const SizedBox(width: Spacing.m),
                TextButton.icon(
                  onPressed: record.originalExported
                      ? null
                      : () => _exportOriginal(context, ref, record),
                  icon: Icon(
                    record.originalExported
                        ? CupertinoIcons.checkmark_alt
                        : CupertinoIcons.arrow_down_to_line,
                  ),
                  label: Text(
                    record.originalExported
                        ? 'Original guardado'
                        : 'Guardar original',
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: Spacing.l),
        ],
      ),
    );
  }
}
