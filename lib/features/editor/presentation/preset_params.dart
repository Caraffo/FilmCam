import 'package:flutter/cupertino.dart';

import '../../film/data/film_preset.dart';

/// Cómo se dibuja la barra de un parámetro.
enum ParamTrack {
  /// Barra lisa, rellena desde el valor neutro.
  plain,

  /// De frío (azul) a cálido (ámbar).
  temperature,

  /// De verde a magenta.
  tint,

  /// Arcoíris, para elegir un tono.
  hue,
}

/// Un parámetro numérico del look, editable con una barra.
class PresetParam {
  const PresetParam({
    required this.label,
    required this.min,
    required this.max,
    required this.neutral,
    required this.read,
    required this.write,
    required this.format,
    this.track = ParamTrack.plain,
  });

  final String label;
  final double min;
  final double max;

  /// Valor que no cambia la foto; la barra se rellena desde acá.
  final double neutral;
  final double Function(FilmPreset preset) read;
  final FilmPreset Function(FilmPreset preset, double value) write;

  /// Valor tal como se muestra (por ejemplo "+0.3 EV" o "6500K").
  final String Function(double value) format;
  final ParamTrack track;
}

/// Una herramienta del editor: un ícono que agrupa uno o dos parámetros.
class AdjustmentTool {
  const AdjustmentTool({
    required this.label,
    required this.icon,
    required this.params,
  });

  final String label;
  final IconData icon;
  final List<PresetParam> params;

  /// Si alguno de sus parámetros difiere de [base].
  bool isModified(FilmPreset look, FilmPreset base) =>
      params.any((p) => p.read(look) != p.read(base));
}

// El color de los virados se elige por tono con saturación y brillo fijos.
const double _tintColorSaturation = 0.6;
const double _tintColorValue = 0.8;
const double _maxHue = 360;
const double _percent = 100;
const double _maxGrain = 0.3;

int tintColorFromHue(double hue) => HSVColor.fromAHSV(
  1,
  hue,
  _tintColorSaturation,
  _tintColorValue,
).toColor().toARGB32();

double hueFromTintColor(int color) => HSVColor.fromColor(Color(color)).hue;

String _signed(String value, double raw) => raw > 0 ? '+$value' : value;

/// Porcentaje con signo, para parámetros que van de -1 a 1 o similares.
String _signedPercent(double v) =>
    _signed((v * _percent).round().toString(), v);

String _percentOf(double v) => (v * _percent).round().toString();

String _degrees(double v) => '${v.round()}°';

PresetParam _hue({
  required String label,
  required int Function(FilmPreset) color,
  required FilmPreset Function(FilmPreset, int) write,
}) => PresetParam(
  label: label,
  min: 0,
  max: _maxHue,
  neutral: 0,
  track: ParamTrack.hue,
  format: _degrees,
  read: (p) => hueFromTintColor(color(p)),
  write: (p, v) => write(p, tintColorFromHue(v)),
);

final List<AdjustmentTool> kAdjustmentTools = [
  AdjustmentTool(
    label: 'Exposición',
    icon: CupertinoIcons.sun_max,
    params: [
      PresetParam(
        label: 'Exposición',
        min: -2,
        max: 2,
        neutral: 0,
        format: (v) => '${_signed(v.toStringAsFixed(1), v)} EV',
        read: (p) => p.exposure,
        write: (p, v) => p.copyWith(exposure: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Contraste',
    icon: CupertinoIcons.circle_lefthalf_fill,
    params: [
      PresetParam(
        label: 'Contraste',
        min: -0.5,
        max: 0.5,
        neutral: 0,
        format: _signedPercent,
        read: (p) => p.contrast,
        write: (p, v) => p.copyWith(contrast: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Saturación',
    icon: CupertinoIcons.drop,
    params: [
      PresetParam(
        label: 'Saturación',
        min: -1,
        max: 1,
        neutral: 0,
        format: _signedPercent,
        read: (p) => p.saturation,
        write: (p, v) => p.copyWith(saturation: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Temperatura',
    icon: CupertinoIcons.thermometer,
    params: [
      PresetParam(
        label: 'Temperatura',
        min: kMinTemperatureK,
        max: kMaxTemperatureK,
        neutral: kNeutralTemperatureK,
        track: ParamTrack.temperature,
        format: (v) => '${v.round()}K',
        read: (p) => p.temperatureK,
        write: (p, v) => p.copyWith(temperatureK: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Tinte',
    icon: CupertinoIcons.color_filter,
    params: [
      PresetParam(
        label: 'Tinte',
        min: -kMaxTint,
        max: kMaxTint,
        neutral: 0,
        track: ParamTrack.tint,
        format: (v) => _signed(v.round().toString(), v),
        read: (p) => p.tint,
        write: (p, v) => p.copyWith(tint: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Desvanecido',
    icon: CupertinoIcons.cloud_fog,
    params: [
      PresetParam(
        label: 'Desvanecido',
        min: 0,
        max: 1,
        neutral: 0,
        format: _percentOf,
        read: (p) => p.fade,
        write: (p, v) => p.copyWith(fade: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Sombras',
    icon: CupertinoIcons.moon,
    params: [
      _hue(
        label: 'Tono de sombras',
        color: (p) => p.shadowTintColor,
        write: (p, c) => p.copyWith(shadowTintColor: c),
      ),
      PresetParam(
        label: 'Intensidad',
        min: 0,
        max: 0.5,
        neutral: 0,
        format: (v) => _percentOf(v * 2),
        read: (p) => p.shadowTintStrength,
        write: (p, v) => p.copyWith(shadowTintStrength: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Luces',
    icon: CupertinoIcons.sun_haze,
    params: [
      _hue(
        label: 'Tono de luces',
        color: (p) => p.highlightTintColor,
        write: (p, c) => p.copyWith(highlightTintColor: c),
      ),
      PresetParam(
        label: 'Intensidad',
        min: 0,
        max: 0.5,
        neutral: 0,
        format: (v) => _percentOf(v * 2),
        read: (p) => p.highlightTintStrength,
        write: (p, v) => p.copyWith(highlightTintStrength: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Grano',
    icon: CupertinoIcons.circle_grid_hex,
    params: [
      PresetParam(
        label: 'Grano',
        min: 0,
        max: _maxGrain,
        neutral: 0,
        format: (v) => _percentOf(v / _maxGrain),
        read: (p) => p.grain,
        write: (p, v) => p.copyWith(grain: v),
      ),
      PresetParam(
        label: 'Tamaño',
        min: 1,
        max: 4,
        neutral: 1,
        format: (v) => v.toStringAsFixed(1),
        read: (p) => p.grainSize,
        write: (p, v) => p.copyWith(grainSize: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Viñeta',
    icon: CupertinoIcons.viewfinder_circle,
    params: [
      PresetParam(
        label: 'Viñeta',
        min: 0,
        max: 1,
        neutral: 0,
        format: _percentOf,
        read: (p) => p.vignette,
        write: (p, v) => p.copyWith(vignette: v),
      ),
    ],
  ),
  AdjustmentTool(
    label: 'Resplandor',
    icon: CupertinoIcons.sparkles,
    params: [
      PresetParam(
        label: 'Resplandor en las luces',
        min: 0,
        max: 1,
        neutral: 0,
        format: _percentOf,
        read: (p) => p.halation,
        write: (p, v) => p.copyWith(halation: v),
      ),
    ],
  ),
];

/// Intensidad del LUT; se muestra dentro de la herramienta "Color".
final PresetParam kLutIntensityParam = PresetParam(
  label: 'Intensidad',
  min: 0,
  max: 1,
  neutral: 0,
  format: _percentOf,
  read: (p) => p.lutIntensity,
  write: (p, v) => p.copyWith(lutIntensity: v),
);
