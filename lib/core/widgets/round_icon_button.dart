import 'package:flutter/material.dart';

const double _defaultSize = 40;
const double _iconSize = 20;
const double _backgroundAlpha = 0.55;

/// Botón circular translúcido, como los controles de la cámara de iOS.
/// Cuando está activo, el ícono toma el color de acento.
class RoundIconButton extends StatelessWidget {
  const RoundIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.active = false,
    this.tooltip,
    this.size = _defaultSize,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final bool active;
  final String? tooltip;
  final double size;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = onPressed == null
        ? scheme.onSurfaceVariant
        : active
        ? scheme.primary
        : scheme.onSurface;
    final button = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: scheme.surfaceContainerHighest.withValues(
            alpha: _backgroundAlpha,
          ),
        ),
        child: Icon(icon, size: _iconSize, color: color),
      ),
    );
    return tooltip == null ? button : Tooltip(message: tooltip, child: button);
  }
}
