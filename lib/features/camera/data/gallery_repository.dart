import 'dart:typed_data';

import 'package:gal/gal.dart';

class GalleryRepository {
  static const _album = 'FilmCam';

  Future<void> saveJpeg(Uint8List bytes) async {
    if (!await Gal.hasAccess(toAlbum: true) &&
        !await Gal.requestAccess(toAlbum: true)) {
      throw StateError('Sin permiso para guardar en la galería.');
    }
    final name = 'FilmCam_${DateTime.now().millisecondsSinceEpoch}';
    await Gal.putImageBytes(bytes, album: _album, name: name);
  }
}
