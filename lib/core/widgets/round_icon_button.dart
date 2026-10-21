import 'package:flutter/material.dart';

import '../theme/motion.dart';

const double _defaultSize = 40;
const double _iconSize = 20;
const double _backgroundAlpha = 0.55;
const double _pressedScale = 0.92;

/// Botón circular translúcido, como los controles de la cámara de iOS.
/// Cuando está activo, el ícono toma el color de acento; al cambiar de ícono
/// o de estado lo hace con una animación.
class RoundIconButton extends StatefulWidget {
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
  State<RoundIconButton> createState() => _RoundIconButtonState();
}

class _RoundIconButtonState extends State<RoundIconButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = widget.onPressed != null;
    final color = !enabled
        ? scheme.onSurfaceVariant
        : widget.active
        ? scheme.primary
        : scheme.onSurface;
    final button = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: widget.onPressed,
      onTapDown: enabled ? (_) => _setPressed(true) : null,
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: AnimatedScale(
        scale: _pressed ? _pressedScale : 1,
        duration: Motion.fast,
        curve: Motion.emphasized,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: scheme.surfaceContainerHighest.withValues(
              alpha: _backgroundAlpha,
            ),
          ),
          child: AnimatedSwitcher(
            duration: Motion.medium,
            switchInCurve: Motion.emphasized,
            transitionBuilder: (child, animation) => ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            ),
            child: Icon(
              widget.icon,
              key: ValueKey((widget.icon, color)),
              size: _iconSize,
              color: color,
            ),
          ),
        ),
      ),
    );
    final tooltip = widget.tooltip;
    return tooltip == null ? button : Tooltip(message: tooltip, child: button);
  }
}
