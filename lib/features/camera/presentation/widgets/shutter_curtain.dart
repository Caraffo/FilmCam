import 'package:flutter/material.dart';

/// Cortina negra que se cierra y se abre sobre el visor al disparar, como el
/// obturador de una cámara real.
class ShutterCurtain extends StatelessWidget {
  const ShutterCurtain({super.key, required this.animation});

  static const Duration duration = Duration(milliseconds: 200);

  /// Fracción de la animación en la que la cortina queda cerrada del todo.
  static const double _closedAt = 0.35;

  final Animation<double> animation;

  static final _opacity = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween(
        begin: 0.0,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeIn)),
      weight: _closedAt,
    ),
    TweenSequenceItem(
      tween: Tween(
        begin: 1.0,
        end: 0.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
      weight: 1 - _closedAt,
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.surface;
    return IgnorePointer(
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final opacity = animation.isAnimating
              ? _opacity.transform(animation.value)
              : 0.0;
          return Opacity(
            opacity: opacity,
            child: ColoredBox(color: color),
          );
        },
      ),
    );
  }
}
