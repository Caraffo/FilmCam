import 'package:flutter/material.dart';

import '../theme/motion.dart';

const double _startScale = 0.97;

/// Transición que aparece con un leve zoom, como al abrir una foto.
Route<T> fadeScaleRoute<T>(WidgetBuilder builder) => PageRouteBuilder<T>(
  transitionDuration: Motion.medium,
  reverseTransitionDuration: Motion.medium,
  pageBuilder: (context, _, _) => builder(context),
  transitionsBuilder: (_, animation, _, child) {
    final curved = CurvedAnimation(parent: animation, curve: Motion.emphasized);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween(begin: _startScale, end: 1.0).animate(curved),
        child: child,
      ),
    );
  },
);
