import 'dart:ui' as ui;

import '../data/film_preset.dart';
import 'white_balance.dart';

/// Índices de los samplers de `shaders/film.frag`.
const int kInputSamplerIndex = 0;
const int kLutSamplerIndex = 1;

/// Carga los uniforms del preset en el shader, en el mismo orden que se
/// declaran en `film.frag`.
void applyFilmUniforms(
  ui.FragmentShader shader,
  FilmPreset preset, {
  required ui.Size size,
  required ui.Image lut,
  required bool isFilter,
  double seed = 0,
}) {
  final whiteBalance = whiteBalanceMultipliers(
    preset.temperatureK,
    preset.tint,
  );
  final shadow = ui.Color(preset.shadowTintColor);
  final highlight = ui.Color(preset.highlightTintColor);
  final hasLut = preset.lutAsset != null;

  final values = <double>[
    size.width,
    size.height,
    preset.exposure,
    preset.contrast,
    preset.saturation,
    preset.fade,
    hasLut ? preset.lutIntensity : 0,
    preset.grain,
    preset.grainSize,
    preset.vignette,
    preset.halation,
    seed,
    isFilter ? 1 : 0,
    whiteBalance.$1,
    whiteBalance.$2,
    whiteBalance.$3,
    shadow.r,
    shadow.g,
    shadow.b,
    preset.shadowTintStrength,
    highlight.r,
    highlight.g,
    highlight.b,
    preset.highlightTintStrength,
  ];
  for (var i = 0; i < values.length; i++) {
    shader.setFloat(i, values[i]);
  }
  shader.setImageSampler(
    kLutSamplerIndex,
    lut,
    filterQuality: ui.FilterQuality.low,
  );
}
