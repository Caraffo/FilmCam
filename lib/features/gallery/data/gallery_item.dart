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

/// Arma la lista de la galería: las fotos recién sacadas que todavía no
/// aparecen en el álbum van primero.
List<GalleryItem> buildGalleryItems(
  List<CapturedPhoto> captures,
  List<GalleryPhoto> photos,
) {
  final albumKeys = {for (final photo in photos) photo.key};
  return [
    for (final capture in captures)
      if (capture.galleryKey == null || !albumKeys.contains(capture.galleryKey))
        PendingCaptureItem(capture),
    for (final photo in photos) AlbumPhotoItem(photo),
  ];
}
