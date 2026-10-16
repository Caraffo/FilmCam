import 'package:freezed_annotation/freezed_annotation.dart';

part 'film_preset.freezed.dart';
part 'film_preset.g.dart';

/// Temperatura neutra: con este valor el balance de blancos no cambia nada.
const double kNeutralTemperatureK = 6500;
const double kMinTemperatureK = 2000;
const double kMaxTemperatureK = 12000;
const double kMaxTint = 50;
const int kNeutralTintColor = 0xFF808080;

/// Un "look" de película: todos los parámetros que usa el shader.
@freezed
abstract class FilmPreset with _$FilmPreset {
  const factory FilmPreset({
    required String id,
    required String name,
    @Default(false) bool isBuiltIn,
    @Default(0) double exposure,
    @Default(kNeutralTemperatureK) double temperatureK,
    @Default(0) double tint,
    @Default(0) double contrast,
    @Default(0) double saturation,
    @Default(0) double fade,
    @Default(kNeutralTintColor) int shadowTintColor,
    @Default(0) double shadowTintStrength,
    @Default(kNeutralTintColor) int highlightTintColor,
    @Default(0) double highlightTintStrength,
    String? lutAsset,
    @Default(1) double lutIntensity,
    @Default(0) double grain,
    @Default(1.5) double grainSize,
    @Default(0) double vignette,
    @Default(0) double halation,
  }) = _FilmPreset;

  factory FilmPreset.fromJson(Map<String, dynamic> json) =>
      _$FilmPresetFromJson(json);
}
