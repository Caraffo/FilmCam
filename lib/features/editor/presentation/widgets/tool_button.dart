import 'package:flutter/material.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';

const double _size = 48;
const double _iconSize = 22;
const double _borderWidth = 1.5;
const double _dotSize = 5;
const double _labelWidth = 72;

/// Botón de una herramienta del editor: ícono en un círculo y el nombre
/// abajo. La elegida se resalta; un punto marca las que cambiaron.
class ToolButton extends StatelessWidget {
  const ToolButton({
    super.key,
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
    this.modified = false,
  });

  final IconData icon;
  final String label;
  final bool selected;
  final bool modified;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: SizedBox(
        width: _labelWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: Motion.fast,
              curve: Motion.standard,
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: scheme.surfaceContainerHigh,
                border: Border.all(
                  color: selected ? scheme.primary : scheme.outline,
                  width: _borderWidth,
                ),
              ),
              child: Icon(
                icon,
                size: _iconSize,
                color: selected ? scheme.primary : scheme.onSurface,
              ),
            ),
            const SizedBox(height: Spacing.xs),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: selected ? scheme.onSurface : scheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: Spacing.xs),
            AnimatedOpacity(
              opacity: modified ? 1 : 0,
              duration: Motion.fast,
              child: Container(
                width: _dotSize,
                height: _dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: scheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
