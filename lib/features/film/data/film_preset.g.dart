// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_preset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FilmPreset _$FilmPresetFromJson(Map<String, dynamic> json) => _FilmPreset(
  id: json['id'] as String,
  name: json['name'] as String,
  isBuiltIn: json['isBuiltIn'] as bool? ?? false,
  exposure: (json['exposure'] as num?)?.toDouble() ?? 0,
  temperatureK:
      (json['temperatureK'] as num?)?.toDouble() ?? kNeutralTemperatureK,
  tint: (json['tint'] as num?)?.toDouble() ?? 0,
  contrast: (json['contrast'] as num?)?.toDouble() ?? 0,
  saturation: (json['saturation'] as num?)?.toDouble() ?? 0,
  fade: (json['fade'] as num?)?.toDouble() ?? 0,
  shadowTintColor:
      (json['shadowTintColor'] as num?)?.toInt() ?? kNeutralTintColor,
  shadowTintStrength: (json['shadowTintStrength'] as num?)?.toDouble() ?? 0,
  highlightTintColor:
      (json['highlightTintColor'] as num?)?.toInt() ?? kNeutralTintColor,
  highlightTintStrength:
      (json['highlightTintStrength'] as num?)?.toDouble() ?? 0,
  lutAsset: json['lutAsset'] as String?,
  lutIntensity: (json['lutIntensity'] as num?)?.toDouble() ?? 1,
  grain: (json['grain'] as num?)?.toDouble() ?? 0,
  grainSize: (json['grainSize'] as num?)?.toDouble() ?? 1.5,
  vignette: (json['vignette'] as num?)?.toDouble() ?? 0,
  halation: (json['halation'] as num?)?.toDouble() ?? 0,
);

Map<String, dynamic> _$FilmPresetToJson(_FilmPreset instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'isBuiltIn': instance.isBuiltIn,
      'exposure': instance.exposure,
      'temperatureK': instance.temperatureK,
      'tint': instance.tint,
      'contrast': instance.contrast,
      'saturation': instance.saturation,
      'fade': instance.fade,
      'shadowTintColor': instance.shadowTintColor,
      'shadowTintStrength': instance.shadowTintStrength,
      'highlightTintColor': instance.highlightTintColor,
      'highlightTintStrength': instance.highlightTintStrength,
      'lutAsset': instance.lutAsset,
      'lutIntensity': instance.lutIntensity,
      'grain': instance.grain,
      'grainSize': instance.grainSize,
      'vignette': instance.vignette,
      'halation': instance.halation,
    };
