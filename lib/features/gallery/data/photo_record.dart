// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../film/data/film_preset.dart';

part 'photo_record.freezed.dart';
part 'photo_record.g.dart';

/// Cómo se reveló una foto de la galería: con qué original y qué look.
/// Permite re-editarla partiendo del original con el mismo filtro.
@freezed
abstract class PhotoRecord with _$PhotoRecord {
  @JsonSerializable(explicitToJson: true)
  const factory PhotoRecord({
    /// Clave de la foto revelada (su nombre en la galería).
    required String key,

    /// Clave del original guardado en privado. Varias ediciones pueden
    /// compartir el mismo original.
    required String originalKey,
    required FilmPreset look,
    DateTime? dateStamp,
    @Default(false) bool originalExported,
  }) = _PhotoRecord;

  factory PhotoRecord.fromJson(Map<String, dynamic> json) =>
      _$PhotoRecordFromJson(json);
}
