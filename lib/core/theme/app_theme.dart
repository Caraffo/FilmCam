import 'package:flutter/material.dart';

// Ámbar de película; la app es solo oscura, como un visor.
const Color _seedColor = Color(0xFFFFB300);

ThemeData buildAppTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: _seedColor,
    brightness: Brightness.dark,
    surface: Colors.black,
  );
  return ThemeData(
    colorScheme: scheme,
    scaffoldBackgroundColor: scheme.surface,
    useMaterial3: true,
  );
}
