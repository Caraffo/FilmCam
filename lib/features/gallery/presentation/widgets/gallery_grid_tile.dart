import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
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
const double _selectedScale = 0.86;
const double _checkSize = 22;
const double _checkBorderWidth = 1.5;
const double _dimAlpha = 0.25;

/// Miniatura de la grilla. Las primeras entran escalonadas con un fundido.
/// En modo selección muestra un círculo para marcarla; la elegida se achica.
class GalleryGridTile extends ConsumerWidget {
  const GalleryGridTile({
    super.key,
    required this.item,
    required this.index,
    required this.onTap,
    this.onLongPress,
    this.selecting = false,
    this.selected = false,
  });

  final GalleryItem item;
  final int index;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final bool selecting;
  final bool selected;

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
        onLongPress: onLongPress,
        child: Stack(
          fit: StackFit.expand,
          children: [
            AnimatedScale(
              scale: selected ? _selectedScale : 1,
              duration: Motion.fast,
              curve: Motion.standard,
              child: ColoredBox(
                color: scheme.surfaceContainerHighest,
                child: image,
              ),
            ),
            if (item is AlbumPhotoItem)
              Positioned(
                top: Spacing.xs,
                right: Spacing.xs,
                child: AnimatedScale(
                  scale: selecting ? 1 : 0,
                  duration: Motion.medium,
                  curve: Motion.spring,
                  child: _SelectionCheck(selected: selected),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SelectionCheck extends StatelessWidget {
  const _SelectionCheck({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: Motion.fast,
      width: _checkSize,
      height: _checkSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? scheme.primary
            : scheme.surface.withValues(alpha: _dimAlpha),
        border: Border.all(color: scheme.onSurface, width: _checkBorderWidth),
      ),
      child: selected
          ? Icon(Icons.check, size: Spacing.m, color: scheme.onPrimary)
          : null,
    );
  }
}
