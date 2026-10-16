import 'dart:typed_data';

import 'package:gal/gal.dart';
import 'package:photo_manager/photo_manager.dart';

import 'photo_naming.dart';

/// Acceso al álbum de FilmCam en la galería del teléfono.
class PhotoLibrary {
  Future<void> save(Uint8List jpeg, {required String name}) async {
    if (!await Gal.hasAccess(toAlbum: true) &&
        !await Gal.requestAccess(toAlbum: true)) {
      throw StateError('Sin permiso para guardar en la galería.');
    }
    await Gal.putImageBytes(jpeg, album: kGalleryAlbum, name: name);
  }

  /// Pide permiso para leer la galería; true si se puede leer (aunque sea
  /// con acceso limitado).
  Future<bool> requestReadAccess() async =>
      (await PhotoManager.requestPermissionExtend()).hasAccess;

  Future<void> openPermissionSettings() => PhotoManager.openSetting();

  /// Fotos del álbum, de la más nueva a la más vieja.
  Future<List<AssetEntity>> listAlbum() async {
    final albums = await PhotoManager.getAssetPathList(
      type: RequestType.image,
      hasAll: false,
      filterOption: FilterOptionGroup(orders: [const OrderOption()]),
    );
    final album = albums.where((a) => a.name == kGalleryAlbum).firstOrNull;
    if (album == null) return [];
    final count = await album.assetCountAsync;
    return album.getAssetListRange(start: 0, end: count);
  }

  Future<Uint8List> readBytes(AssetEntity asset) async {
    final bytes = await asset.originBytes;
    if (bytes == null) {
      throw StateError('No se pudo leer la foto ${asset.id}.');
    }
    return bytes;
  }

  Future<Uint8List> readThumbnail(AssetEntity asset, int size) async {
    final bytes = await asset.thumbnailDataWithSize(ThumbnailSize.square(size));
    if (bytes == null) {
      throw StateError('No se pudo leer la miniatura ${asset.id}.');
    }
    return bytes;
  }

  /// Borra las fotos. En Android el sistema pide una confirmación para
  /// todas juntas: devuelve los ids que efectivamente se borraron.
  Future<Set<String>> deleteAll(List<AssetEntity> assets) async {
    if (assets.isEmpty) return {};
    final ids = [for (final asset in assets) asset.id];
    return (await PhotoManager.editor.deleteWithIds(ids)).toSet();
  }
}
