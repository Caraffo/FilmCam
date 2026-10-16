import 'dart:typed_data';

import '../../film/data/film_preset.dart';
import '../../gallery/data/gallery_photo.dart';

/// Lo necesario para editar una foto de la galería.
class PhotoEditRequest {
  const PhotoEditRequest({
    required this.source,
    required this.look,
    required this.photo,
    required this.takenAt,
    this.originalKey,
    this.dateStamp,
  });

  /// Imagen sobre la que se aplica el look: el original si existe, si no la
  /// foto tal como está en la galería.
  final Uint8List source;

  /// Clave del original guardado en privado, si [source] es ese original.
  final String? originalKey;

  /// Look con el que se reveló la foto (o uno neutro si no hay registro).
  final FilmPreset look;
  final DateTime? dateStamp;

  /// Fecha de la foto, para estampar si se activa la fecha al editar.
  final DateTime takenAt;
  final GalleryPhoto photo;
}
