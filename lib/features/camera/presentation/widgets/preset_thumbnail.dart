import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_filter.dart';
import '../camera_layout.dart';

/// Miniatura de un filtro: el visor en vivo con ese look aplicado.
class PresetThumbnail extends StatelessWidget {
  const PresetThumbnail({
    super.key,
    required this.name,
    required this.look,
    required this.controller,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
  });

  final String name;
  final FilmPreset look;
  final CameraController? controller;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;
    final scheme = Theme.of(context).colorScheme;
    return PresetTileFrame(
      label: name,
      selected: selected,
      onTap: onTap,
      onLongPress: onLongPress,
      child: controller == null || !controller.value.isInitialized
          ? ColoredBox(color: scheme.surfaceContainerHighest)
          : FittedBox(
              fit: BoxFit.cover,
              clipBehavior: Clip.hardEdge,
              child: SizedBox(
                width: CameraLayout.thumbnailSize,
                // El aspect ratio de la cámara viene en horizontal.
                height:
                    CameraLayout.thumbnailSize * controller.value.aspectRatio,
                child: FilmFilter(look: look, child: CameraPreview(controller)),
              ),
            ),
    );
  }
}

/// Marco común de los tiles del carrusel: imagen redondeada y nombre debajo.
class PresetTileFrame extends StatelessWidget {
  const PresetTileFrame({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.child,
    this.onLongPress,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(CameraLayout.thumbnailRadius);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
        child: Column(
          children: [
            Container(
              width: CameraLayout.thumbnailSize,
              height: CameraLayout.thumbnailSize,
              foregroundDecoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(
                  color: selected ? scheme.primary : Colors.transparent,
                  width: CameraLayout.selectedBorderWidth,
                ),
              ),
              child: ClipRRect(borderRadius: radius, child: child),
            ),
            const SizedBox(height: Spacing.s),
            SizedBox(
              width: CameraLayout.thumbnailSize + Spacing.m,
              child: Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: textTheme.labelSmall?.copyWith(
                  color: selected ? scheme.primary : scheme.onSurfaceVariant,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
