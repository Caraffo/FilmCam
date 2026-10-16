import 'package:flutter/material.dart';

import '../../../core/theme/spacing.dart';

const double kPresetTileSize = 56;
const double _tileRadius = 12;
const double _selectedBorderWidth = 2;

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
    final radius = BorderRadius.circular(_tileRadius);
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
        child: Column(
          children: [
            Container(
              width: kPresetTileSize,
              height: kPresetTileSize,
              foregroundDecoration: BoxDecoration(
                borderRadius: radius,
                border: Border.all(
                  color: selected ? scheme.primary : Colors.transparent,
                  width: _selectedBorderWidth,
                ),
              ),
              child: ClipRRect(borderRadius: radius, child: child),
            ),
            const SizedBox(height: Spacing.s),
            SizedBox(
              width: kPresetTileSize + Spacing.m,
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
