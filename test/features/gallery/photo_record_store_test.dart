import 'dart:io';
import 'dart:typed_data';

import 'package:filmcam/features/film/data/builtin_presets.dart';
import 'package:filmcam/features/gallery/data/photo_record.dart';
import 'package:filmcam/features/gallery/data/photo_record_store.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late Directory base;
  late PhotoRecordStore store;

  setUp(() async {
    base = await Directory.systemTemp.createTemp('filmcam_test');
    store = PhotoRecordStore(baseDirectory: () async => base);
  });

  tearDown(() => base.delete(recursive: true));

  Future<void> age(String originalKey) => File(
    '${base.path}/originals/$originalKey.jpg',
  ).setLastModified(DateTime.now().subtract(const Duration(hours: 1)));

  test('borrar un registro libera su original, pero no uno en uso', () async {
    final usedKey = await store.storeOriginal(Uint8List.fromList([1]));
    final orphanKey = await store.storeOriginal(Uint8List.fromList([2]));
    await store.saveRecord(
      PhotoRecord(key: 'a', originalKey: usedKey, look: kOriginalPreset),
    );
    await store.saveRecord(
      PhotoRecord(key: 'b', originalKey: orphanKey, look: kOriginalPreset),
    );
    await age(usedKey);
    await age(orphanKey);

    await store.deleteRecords(['b']);
    await store.pruneOriginals();

    expect(await store.readRecord('b'), isNull);
    expect(await store.readOriginal(orphanKey), isNull);
    expect(await store.readOriginal(usedKey), isNotNull);
  });

  test('un original recién guardado sin registro no se borra', () async {
    final key = await store.storeOriginal(Uint8List.fromList([1]));
    await store.pruneOriginals();
    expect(await store.readOriginal(key), isNotNull);
  });
}
