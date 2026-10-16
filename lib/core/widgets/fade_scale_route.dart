import 'package:flutter/material.dart';

const Duration _duration = Duration(milliseconds: 220);
const double _startScale = 0.94;

/// Transición que aparece con un leve zoom, como al abrir una foto.
Route<T> fadeScaleRoute<T>(WidgetBuilder builder) => PageRouteBuilder<T>(
  transitionDuration: _duration,
  reverseTransitionDuration: _duration,
  pageBuilder: (context, _, _) => builder(context),
  transitionsBuilder: (_, animation, _, child) {
    final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
    return FadeTransition(
      opacity: curved,
      child: ScaleTransition(
        scale: Tween(begin: _startScale, end: 1.0).animate(curved),
        child: child,
      ),
    );
  },
);
