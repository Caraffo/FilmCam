import 'dart:math' as math;

import '../data/film_preset.dart';

const _lumaWeights = (0.2126, 0.7152, 0.0722);

/// Cuánto verde saca (tint positivo, magenta) o agrega (negativo) cada punto.
const double _tintGreenPerUnit = 0.0025;

/// Multiplicadores RGB del balance de blancos, con la misma semántica que
/// Lightroom: indicar una temperatura mayor que la neutra calienta la imagen.
(double, double, double) whiteBalanceMultipliers(
  double temperatureK,
  double tint,
) {
  final neutral = _kelvinToRgb(kNeutralTemperatureK);
  final target = _kelvinToRgb(temperatureK);
  final r = neutral.$1 / target.$1;
  final g = neutral.$2 / target.$2 * (1 - tint * _tintGreenPerUnit);
  final b = neutral.$3 / target.$3;
  final luma = r * _lumaWeights.$1 + g * _lumaWeights.$2 + b * _lumaWeights.$3;
  return (r / luma, g / luma, b / luma);
}

/// Color aproximado de un cuerpo negro (algoritmo de Tanner Helland).
(double, double, double) _kelvinToRgb(double kelvin) {
  final t = kelvin / 100;
  final double r;
  final double g;
  final double b;
  if (t <= 66) {
    r = 255;
    g = 99.4708025861 * math.log(t) - 161.1195681661;
  } else {
    r = 329.698727446 * math.pow(t - 60, -0.1332047592);
    g = 288.1221695283 * math.pow(t - 60, -0.0755148492);
  }
  if (t >= 66) {
    b = 255;
  } else if (t <= 19) {
    b = 0;
  } else {
    b = 138.5177312231 * math.log(t - 10) - 305.0447927307;
  }
  // El mínimo evita dividir por cero con temperaturas muy bajas.
  double normalize(double v) => (v.clamp(1, 255)) / 255;
  return (normalize(r), normalize(g), normalize(b));
}
