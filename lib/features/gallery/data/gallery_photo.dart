import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:photo_manager/photo_manager.dart';

part 'gallery_photo.freezed.dart';

/// Una foto del álbum. [key] existe si la reveló la app (tiene registro).
@freezed
abstract class GalleryPhoto with _$GalleryPhoto {
  const factory GalleryPhoto({required AssetEntity asset, String? key}) =
      _GalleryPhoto;
}

class GalleryAccessDenied implements Exception {
  const GalleryAccessDenied();

  @override
  String toString() => 'Sin permiso para ver las fotos de la galería.';
}
