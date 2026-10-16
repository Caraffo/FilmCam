import 'package:flutter/painting.dart';

import '../../film/data/film_preset.dart';

/// Un parámetro numérico del preset editable con un slider.
class PresetParam {
  const PresetParam({
    required this.label,
    required this.min,
    required this.max,
    required this.read,
    required this.write,
    this.decimals = 2,
  });

  final String label;
  final double min;
  final double max;
  final int decimals;
  final double Function(FilmPreset preset) read;
  final FilmPreset Function(FilmPreset preset, double value) write;
}

class ParamGroup {
  const ParamGroup(this.title, this.params);

  final String title;
  final List<PresetParam> params;
}

// El color de los virados se elige por tono con saturación y brillo fijos.
const double _tintColorSaturation = 0.6;
const double _tintColorValue = 0.8;
const double _maxHue = 360;

int tintColorFromHue(double hue) => HSVColor.fromAHSV(
  1,
  hue,
  _tintColorSaturation,
  _tintColorValue,
).toColor().toARGB32();

double hueFromTintColor(int color) => HSVColor.fromColor(Color(color)).hue;

final List<ParamGroup> kPresetParamGroups = [
  ParamGroup('Luz y color', [
    PresetParam(
      label: 'Exposición',
      min: -2,
      max: 2,
      read: (p) => p.exposure,
      write: (p, v) => p.copyWith(exposure: v),
    ),
    PresetParam(
      label: 'Temperatura (K)',
      min: kMinTemperatureK,
      max: kMaxTemperatureK,
      decimals: 0,
      read: (p) => p.temperatureK,
      write: (p, v) => p.copyWith(temperatureK: v),
    ),
    PresetParam(
      label: 'Tint',
      min: -kMaxTint,
      max: kMaxTint,
      decimals: 0,
      read: (p) => p.tint,
      write: (p, v) => p.copyWith(tint: v),
    ),
    PresetParam(
      label: 'Contraste',
      min: -0.5,
      max: 0.5,
      read: (p) => p.contrast,
      write: (p, v) => p.copyWith(contrast: v),
    ),
    PresetParam(
      label: 'Saturación',
      min: -1,
      max: 1,
      read: (p) => p.saturation,
      write: (p, v) => p.copyWith(saturation: v),
    ),
    PresetParam(
      label: 'Desvanecido',
      min: 0,
      max: 1,
      read: (p) => p.fade,
      write: (p, v) => p.copyWith(fade: v),
    ),
  ]),
  ParamGroup('Virados', [
    PresetParam(
      label: 'Tono sombras',
      min: 0,
      max: _maxHue,
      decimals: 0,
      read: (p) => hueFromTintColor(p.shadowTintColor),
      write: (p, v) => p.copyWith(shadowTintColor: tintColorFromHue(v)),
    ),
    PresetParam(
      label: 'Intensidad sombras',
      min: 0,
      max: 0.5,
      read: (p) => p.shadowTintStrength,
      write: (p, v) => p.copyWith(shadowTintStrength: v),
    ),
    PresetParam(
      label: 'Tono luces',
      min: 0,
      max: _maxHue,
      decimals: 0,
      read: (p) => hueFromTintColor(p.highlightTintColor),
      write: (p, v) => p.copyWith(highlightTintColor: tintColorFromHue(v)),
    ),
    PresetParam(
      label: 'Intensidad luces',
      min: 0,
      max: 0.5,
      read: (p) => p.highlightTintStrength,
      write: (p, v) => p.copyWith(highlightTintStrength: v),
    ),
  ]),
  ParamGroup('Película', [
    PresetParam(
      label: 'Intensidad del LUT',
      min: 0,
      max: 1,
      read: (p) => p.lutIntensity,
      write: (p, v) => p.copyWith(lutIntensity: v),
    ),
    PresetParam(
      label: 'Grano',
      min: 0,
      max: 0.3,
      read: (p) => p.grain,
      write: (p, v) => p.copyWith(grain: v),
    ),
    PresetParam(
      label: 'Tamaño del grano',
      min: 1,
      max: 4,
      read: (p) => p.grainSize,
      write: (p, v) => p.copyWith(grainSize: v),
    ),
    PresetParam(
      label: 'Viñeta',
      min: 0,
      max: 1,
      read: (p) => p.vignette,
      write: (p, v) => p.copyWith(vignette: v),
    ),
    PresetParam(
      label: 'Halation',
      min: 0,
      max: 1,
      read: (p) => p.halation,
      write: (p, v) => p.copyWith(halation: v),
    ),
  ]),
];
