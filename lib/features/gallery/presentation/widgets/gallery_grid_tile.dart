import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/widgets/fade_in_memory_image.dart';
import '../../data/gallery_item.dart';
import '../gallery_providers.dart';

/// Retraso entre la entrada de una miniatura y la siguiente.
const Duration _staggerStep = Duration(milliseconds: 25);

/// Solo las primeras entran escalonadas; las que aparecen al scrollear
/// entran enseguida.
const int _maxStaggered = 18;
const double _entryScale = 0.92;
const double _spinnerSize = 20;
const double _spinnerStroke = 2;

/// Miniatura de la grilla. Las primeras entran escalonadas con un fundido.
class GalleryGridTile extends ConsumerWidget {
  const GalleryGridTile({
    super.key,
    required this.item,
    required this.index,
    required this.onTap,
  });

  final GalleryItem item;
  final int index;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheme = Theme.of(context).colorScheme;
    final decodeWidth = (MediaQuery.sizeOf(context).width / 2).round();
    final Widget image = switch (item) {
      PendingCaptureItem(:final capture) => Stack(
        fit: StackFit.expand,
        children: [
          FadeInMemoryImage(
            capture.filtered ?? capture.original,
            fit: BoxFit.cover,
            cacheWidth: decodeWidth,
          ),
          if (capture.isProcessing)
            const Center(
              child: SizedBox.square(
                dimension: _spinnerSize,
                child: CircularProgressIndicator(strokeWidth: _spinnerStroke),
              ),
            ),
        ],
      ),
      AlbumPhotoItem(:final photo) =>
        ref
                .watch(galleryThumbnailProvider(photo))
                .whenData(
                  (bytes) => FadeInMemoryImage(bytes, fit: BoxFit.cover),
                )
                .value ??
            const SizedBox.shrink(),
    };

    final delay = index < _maxStaggered ? _staggerStep * index : Duration.zero;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Motion.medium + delay,
      builder: (context, value, child) {
        // Mientras dura el retraso, la miniatura queda invisible.
        final total = (Motion.medium + delay).inMilliseconds;
        final start = delay.inMilliseconds / total;
        final t = Motion.standard.transform(
          ((value - start) / (1 - start)).clamp(0.0, 1.0),
        );
        return Opacity(
          opacity: t,
          child: Transform.scale(
            scale: _entryScale + (1 - _entryScale) * t,
            child: child,
          ),
        );
      },
      child: GestureDetector(
        onTap: onTap,
        child: ColoredBox(color: scheme.surfaceContainerHighest, child: image),
      ),
    );
  }
}
