// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PhotoRecord _$PhotoRecordFromJson(Map<String, dynamic> json) => _PhotoRecord(
  key: json['key'] as String,
  originalKey: json['originalKey'] as String,
  look: FilmPreset.fromJson(json['look'] as Map<String, dynamic>),
  dateStamp: json['dateStamp'] == null
      ? null
      : DateTime.parse(json['dateStamp'] as String),
  originalExported: json['originalExported'] as bool? ?? false,
);

Map<String, dynamic> _$PhotoRecordToJson(_PhotoRecord instance) =>
    <String, dynamic>{
      'key': instance.key,
      'originalKey': instance.originalKey,
      'look': instance.look.toJson(),
      'dateStamp': instance.dateStamp?.toIso8601String(),
      'originalExported': instance.originalExported,
    };
