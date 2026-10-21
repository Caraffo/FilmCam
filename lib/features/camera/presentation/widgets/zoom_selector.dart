import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/typography.dart';
import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../camera_session.dart';

const double _pillSize = 36;
const double _selectedPillSize = 42;
const double _backgroundAlpha = 0.45;

/// Selector de zoom flotante sobre el visor, al estilo de iOS.
class ZoomSelector extends ConsumerWidget {
  const ZoomSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraSessionProvider).value;
    if (camera == null) return const SizedBox.shrink();
    final stops = camera.zoomStops;
    if (stops.length < 2) return const SizedBox.shrink();
    final scheme = Theme.of(context).colorScheme;

    return Center(
      child: Container(
        padding: const EdgeInsets.all(Spacing.xs),
        decoration: BoxDecoration(
          color: scheme.surface.withValues(alpha: _backgroundAlpha),
          borderRadius: BorderRadius.circular(_selectedPillSize),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final zoom in stops)
              _ZoomPill(
                zoom: zoom,
                selected: camera.selectedStop == zoom,
                displayZoom: camera.displayZoom,
                onTap: () => ref
                    .read(cameraSessionProvider.notifier)
                    .selectZoomStop(zoom),
              ),
          ],
        ),
      ),
    );
  }
}

class _ZoomPill extends StatelessWidget {
  const _ZoomPill({
    required this.zoom,
    required this.selected,
    required this.displayZoom,
    required this.onTap,
  });

  final double zoom;
  final bool selected;

  /// Zoom actual: la lente resaltada lo muestra (por ejemplo, 1.7×).
  final double displayZoom;
  final VoidCallback onTap;

  static String _format(double value) {
    final rounded = (value * 10).round() / 10;
    return rounded == rounded.roundToDouble()
        ? rounded.toInt().toString()
        : rounded.toStringAsFixed(1);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final size = selected ? _selectedPillSize : _pillSize;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Motion.medium,
        curve: Motion.emphasized,
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheme.surfaceContainerHighest.withValues(
            alpha: _backgroundAlpha,
          ),
        ),
        child: AnimatedDefaultTextStyle(
          duration: Motion.medium,
          style: mono(Theme.of(context).textTheme.labelSmall)!.copyWith(
            color: selected ? scheme.primary : scheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
          child: Text(selected ? '${_format(displayZoom)}×' : _format(zoom)),
        ),
      ),
    );
  }
}
