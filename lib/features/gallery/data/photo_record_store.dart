import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';

import 'photo_naming.dart';
import 'photo_record.dart';

/// Guarda en el almacenamiento privado de la app los originales y el
/// registro de cómo se reveló cada foto.
class PhotoRecordStore {
  static const _originalsDir = 'originals';
  static const _recordsDir = 'records';

  Future<Directory> _dir(String name) async {
    final base = await getApplicationDocumentsDirectory();
    return Directory('${base.path}/$name').create(recursive: true);
  }

  Future<File> _originalFile(String key) async =>
      File('${(await _dir(_originalsDir)).path}/$key.jpg');

  Future<File> _recordFile(String key) async =>
      File('${(await _dir(_recordsDir)).path}/$key.json');

  /// Guarda un original y devuelve su clave.
  Future<String> storeOriginal(Uint8List bytes) async {
    final key = newPhotoKey();
    await (await _originalFile(key)).writeAsBytes(bytes, flush: true);
    return key;
  }

  Future<Uint8List?> readOriginal(String key) async {
    final file = await _originalFile(key);
    return await file.exists() ? file.readAsBytes() : null;
  }

  Future<void> saveRecord(PhotoRecord record) async {
    final file = await _recordFile(record.key);
    await file.writeAsString(jsonEncode(record.toJson()), flush: true);
  }

  Future<PhotoRecord?> readRecord(String key) async {
    final file = await _recordFile(key);
    if (!await file.exists()) return null;
    final json = jsonDecode(await file.readAsString()) as Map<String, dynamic>;
    return PhotoRecord.fromJson(json);
  }

  Future<void> deleteRecord(String key) async {
    final file = await _recordFile(key);
    if (await file.exists()) await file.delete();
  }
}
