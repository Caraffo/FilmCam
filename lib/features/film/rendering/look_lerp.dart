import 'dart:ui' show Color, lerpDouble;

import '../data/film_preset.dart';

/// Look intermedio entre [a] y [b] (t de 0 a 1), para animar el cambio de
/// filtro. Si cambian de LUT, el de [a] se apaga en la primera mitad y el de
/// [b] se enciende en la segunda.
FilmPreset lerpLook(FilmPreset a, FilmPreset b, double t) {
  double lerp(double x, double y) => lerpDouble(x, y, t)!;
  int lerpColor(int x, int y) => Color.lerp(Color(x), Color(y), t)!.toARGB32();

  final sameLut = a.lutAsset == b.lutAsset;
  final String? lutAsset;
  final double lutIntensity;
  if (sameLut) {
    lutAsset = b.lutAsset;
    lutIntensity = lerp(a.lutIntensity, b.lutIntensity);
  } else if (t < 0.5) {
    lutAsset = a.lutAsset;
    lutIntensity = a.lutIntensity * (1 - t * 2);
  } else {
    lutAsset = b.lutAsset;
    lutIntensity = b.lutIntensity * (t * 2 - 1);
  }

  return b.copyWith(
    exposure: lerp(a.exposure, b.exposure),
    temperatureK: lerp(a.temperatureK, b.temperatureK),
    tint: lerp(a.tint, b.tint),
    contrast: lerp(a.contrast, b.contrast),
    saturation: lerp(a.saturation, b.saturation),
    fade: lerp(a.fade, b.fade),
    shadowTintColor: lerpColor(a.shadowTintColor, b.shadowTintColor),
    shadowTintStrength: lerp(a.shadowTintStrength, b.shadowTintStrength),
    highlightTintColor: lerpColor(a.highlightTintColor, b.highlightTintColor),
    highlightTintStrength: lerp(
      a.highlightTintStrength,
      b.highlightTintStrength,
    ),
    lutAsset: lutAsset,
    lutIntensity: lutIntensity,
    grain: lerp(a.grain, b.grain),
    grainSize: lerp(a.grainSize, b.grainSize),
    vignette: lerp(a.vignette, b.vignette),
    halation: lerp(a.halation, b.halation),
  );
}
