import 'dart:typed_data';
import 'dart:ui' as ui;

import '../../camera/data/photo_processor.dart';
import '../../film/data/film_preset.dart';
import 'photo_library.dart';
import 'photo_naming.dart';
import 'photo_record.dart';
import 'photo_record_store.dart';

typedef DevelopedPhoto = ({PhotoRecord record, Uint8List jpeg});

/// "Revela" una foto: aplica el look al original, la guarda en la galería y
/// registra cómo se hizo para poder re-editarla.
class PhotoDeveloper {
  const PhotoDeveloper({
    required this.processor,
    required this.library,
    required this.store,
  });

  final PhotoProcessor processor;
  final PhotoLibrary library;
  final PhotoRecordStore store;

  Future<DevelopedPhoto> develop({
    required Uint8List original,
    required String originalKey,
    required FilmPreset look,
    required ui.FragmentProgram program,
    required ui.Image lut,
    DateTime? dateStamp,
  }) async {
    final jpeg = await processor.process(
      original,
      look: look,
      program: program,
      lut: lut,
      dateStamp: dateStamp,
    );
    final key = newPhotoKey();
    await library.save(jpeg, name: galleryNameFor(key));
    final record = PhotoRecord(
      key: key,
      originalKey: originalKey,
      look: look,
      dateStamp: dateStamp,
    );
    await store.saveRecord(record);
    return (record: record, jpeg: jpeg);
  }
}
