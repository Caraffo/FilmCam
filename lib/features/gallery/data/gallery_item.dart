import '../../camera/data/captured_photo.dart';
import 'gallery_photo.dart';

/// Un elemento de la galería: una foto del álbum o la recién sacada que
/// todavía se está revelando.
sealed class GalleryItem {
  const GalleryItem();
}

class PendingCaptureItem extends GalleryItem {
  const PendingCaptureItem(this.capture);

  final CapturedPhoto capture;
}

class AlbumPhotoItem extends GalleryItem {
  const AlbumPhotoItem(this.photo);

  final GalleryPhoto photo;
}

/// Arma la lista de la galería: la foto recién sacada va primera mientras
/// no aparezca en el álbum.
List<GalleryItem> buildGalleryItems(
  CapturedPhoto? capture,
  List<GalleryPhoto> photos,
) {
  final key = capture?.galleryKey;
  final pending =
      capture != null && (key == null || !photos.any((p) => p.key == key));
  return [
    if (pending) PendingCaptureItem(capture),
    for (final photo in photos) AlbumPhotoItem(photo),
  ];
}
