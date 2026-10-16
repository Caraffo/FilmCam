import 'package:flutter/material.dart';

import '../theme/motion.dart';

/// AnimatedSwitcher con fundido y un leve desplazamiento vertical, para
/// contenidos que se reemplazan (paneles, textos, estados).
class MotionSwitcher extends StatelessWidget {
  const MotionSwitcher({
    super.key,
    required this.child,
    this.offset = 0.15,
    this.duration = Motion.medium,
  });

  final Widget child;

  /// Desplazamiento inicial, en fracción del alto del hijo.
  final double offset;
  final Duration duration;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: duration,
      switchInCurve: Motion.standard,
      switchOutCurve: Motion.standard,
      transitionBuilder: (child, animation) => FadeTransition(
        opacity: animation,
        child: SlideTransition(
          position: Tween(
            begin: Offset(0, offset),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        ),
      ),
      child: child,
    );
  }
}
