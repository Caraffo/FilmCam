import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../camera/data/photo_processor.dart';
import '../../film/data/film_preset.dart';
import '../../film/presentation/film_providers.dart';
import '../data/gallery_photo.dart';
import '../data/photo_developer.dart';
import '../data/photo_library.dart';
import '../data/photo_naming.dart';
import '../data/photo_record.dart';
import '../data/photo_record_store.dart';

part 'gallery_providers.g.dart';

@Riverpod(keepAlive: true)
PhotoProcessor photoProcessor(Ref ref) => const PhotoProcessor();

@Riverpod(keepAlive: true)
PhotoLibrary photoLibrary(Ref ref) => PhotoLibrary();

@Riverpod(keepAlive: true)
PhotoRecordStore photoRecordStore(Ref ref) => PhotoRecordStore();

@Riverpod(keepAlive: true)
PhotoDeveloper photoDeveloper(Ref ref) => PhotoDeveloper(
  processor: ref.read(photoProcessorProvider),
  library: ref.read(photoLibraryProvider),
  store: ref.read(photoRecordStoreProvider),
);

/// Revela [original] con [look] usando el shader y el LUT cargados.
Future<DevelopedPhoto> developPhoto(
  Ref ref, {
  required Uint8List original,
  required String originalKey,
  required FilmPreset look,
  DateTime? dateStamp,
}) async {
  final program = await ref.read(filmProgramProvider.future);
  final lut = await ref.read(lutImageProvider(look.lutAsset).future);
  return ref
      .read(photoDeveloperProvider)
      .develop(
        original: original,
        originalKey: originalKey,
        look: look,
        program: program,
        lut: lut,
        dateStamp: dateStamp,
      );
}

@riverpod
Future<PhotoRecord?> photoRecord(Ref ref, String key) =>
    ref.read(photoRecordStoreProvider).readRecord(key);

@riverpod
Future<Uint8List?> originalBytes(Ref ref, String originalKey) =>
    ref.read(photoRecordStoreProvider).readOriginal(originalKey);

@riverpod
Future<Uint8List> galleryPhotoBytes(Ref ref, GalleryPhoto photo) =>
    ref.read(photoLibraryProvider).readBytes(photo.asset);

/// Lado, en píxeles, de las miniaturas de la grilla.
const int _thumbnailSize = 360;

@riverpod
Future<Uint8List> galleryThumbnail(Ref ref, GalleryPhoto photo) =>
    ref.read(photoLibraryProvider).readThumbnail(photo.asset, _thumbnailSize);

/// Fotos del álbum de FilmCam, de la más nueva a la más vieja.
@riverpod
class GalleryPhotos extends _$GalleryPhotos {
  @override
  Future<List<GalleryPhoto>> build() async {
    final library = ref.read(photoLibraryProvider);
    if (!await library.requestReadAccess()) throw const GalleryAccessDenied();
    final assets = await library.listAlbum();
    return [
      for (final asset in assets)
        GalleryPhoto(
          asset: asset,
          key: photoKeyFromTitle(asset.title ?? await asset.titleAsync),
        ),
    ];
  }

  Future<void> openPermissionSettings() =>
      ref.read(photoLibraryProvider).openPermissionSettings();

  /// Guarda en la galería el original sin filtro de una foto.
  Future<void> exportOriginal(PhotoRecord record) async {
    final store = ref.read(photoRecordStoreProvider);
    final original = await store.readOriginal(record.originalKey);
    if (original == null) {
      throw StateError('No se encontró el original de esta foto.');
    }
    await ref
        .read(photoLibraryProvider)
        .save(original, name: galleryNameForOriginal(record.key));
    await store.saveRecord(record.copyWith(originalExported: true));
    ref.invalidate(photoRecordProvider(record.key));
    ref.invalidateSelf();
  }

  /// Revela una edición y la guarda como foto nueva. Con [replacing] borra
  /// además la anterior; devuelve false si no se pudo borrar (el usuario
  /// rechazó la confirmación del sistema) y quedó como copia.
  Future<bool> saveEdit({
    required Uint8List source,
    required FilmPreset look,
    String? originalKey,
    DateTime? dateStamp,
    GalleryPhoto? replacing,
  }) async {
    final store = ref.read(photoRecordStoreProvider);
    await developPhoto(
      ref,
      original: source,
      originalKey: originalKey ?? await store.storeOriginal(source),
      look: look,
      dateStamp: dateStamp,
    );
    if (replacing == null) {
      ref.invalidateSelf();
      return true;
    }
    return await deletePhotos([replacing]) == 1;
  }

  /// Borra fotos del álbum junto con sus registros y los originales que
  /// queden sin usar. Devuelve cuántas se borraron (el usuario puede
  /// rechazar la confirmación del sistema).
  Future<int> deletePhotos(List<GalleryPhoto> photos) async {
    final deletedIds = await ref.read(photoLibraryProvider).deleteAll([
      for (final photo in photos) photo.asset,
    ]);
    final store = ref.read(photoRecordStoreProvider);
    await store.deleteRecords([
      for (final photo in photos)
        if (deletedIds.contains(photo.asset.id) && photo.key != null)
          photo.key!,
    ]);
    await store.pruneOriginals();
    ref.invalidateSelf();
    return deletedIds.length;
  }
}
