/// Álbum de la galería donde se guardan las fotos.
const String kGalleryAlbum = 'FilmCam';

const String _namePrefix = 'FilmCam_';
const String _originalSuffix = '_original';

/// Clave nueva para una foto; también da nombre al archivo en la galería.
String newPhotoKey() => DateTime.now().millisecondsSinceEpoch.toString();

String galleryNameFor(String key) => '$_namePrefix$key';

String galleryNameForOriginal(String key) => '$_namePrefix$key$_originalSuffix';

/// Clave de una foto revelada por la app a partir del nombre del archivo en
/// la galería, o null si no es una (por ejemplo, un original exportado).
String? photoKeyFromTitle(String title) {
  final dot = title.lastIndexOf('.');
  final name = dot == -1 ? title : title.substring(0, dot);
  if (!name.startsWith(_namePrefix) || name.endsWith(_originalSuffix)) {
    return null;
  }
  return name.substring(_namePrefix.length);
}
