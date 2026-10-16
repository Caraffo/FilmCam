import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Paleta minimal estilo cámara de iPhone: negro, grises y un único acento.
const Color _accent = Color(0xFFFFD60A);
const Color _background = Color(0xFF000000);
const Color _foreground = Color(0xFFFFFFFF);
const Color _surfaceRaised = Color(0xFF1C1C1E);
const Color _surfaceHighest = Color(0xFF2C2C2E);
const Color _outline = Color(0xFF3A3A3C);
const Color _secondaryText = Color(0xFF8E8E93);
const Color _error = Color(0xFFFF453A);

const String _fontFamily = 'Inter';
const double _sliderTrackHeight = 2;
const double _sliderThumbRadius = 8;

ThemeData buildAppTheme() {
  const scheme = ColorScheme(
    brightness: Brightness.dark,
    primary: _accent,
    onPrimary: _background,
    secondary: _foreground,
    onSecondary: _background,
    error: _error,
    onError: _foreground,
    surface: _background,
    onSurface: _foreground,
    onSurfaceVariant: _secondaryText,
    surfaceContainer: _surfaceRaised,
    surfaceContainerHigh: _surfaceRaised,
    surfaceContainerHighest: _surfaceHighest,
    outline: _outline,
    outlineVariant: _outline,
  );

  final base = ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    fontFamily: _fontFamily,
  );

  return base.copyWith(
    scaffoldBackgroundColor: _background,
    splashFactory: NoSplash.splashFactory,
    highlightColor: Colors.transparent,
    textTheme: base.textTheme.apply(
      bodyColor: _foreground,
      displayColor: _foreground,
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: _background,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontFamily: _fontFamily,
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: _foreground,
      ),
    ),
    sliderTheme: const SliderThemeData(
      trackHeight: _sliderTrackHeight,
      activeTrackColor: _foreground,
      inactiveTrackColor: _outline,
      thumbColor: _foreground,
      overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
      thumbShape: RoundSliderThumbShape(enabledThumbRadius: _sliderThumbRadius),
      showValueIndicator: ShowValueIndicator.never,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: _secondaryText),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _outline),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: _foreground),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: _surfaceHighest,
      contentTextStyle: TextStyle(fontFamily: _fontFamily, color: _foreground),
      behavior: SnackBarBehavior.floating,
    ),
    dividerColor: _outline,
  );
}
