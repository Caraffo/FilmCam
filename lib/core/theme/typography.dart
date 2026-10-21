import 'package:flutter/painting.dart';

const String _monoFontFamily = 'IBM Plex Mono';

/// Variante monoespaciada para valores y metadatos (zoom, exposición,
/// temperatura, contadores), como el display de una cámara.
TextStyle? mono(TextStyle? base) => base?.copyWith(
  fontFamily: _monoFontFamily,
  letterSpacing: 0,
  fontFeatures: const [FontFeature.tabularFigures()],
);
