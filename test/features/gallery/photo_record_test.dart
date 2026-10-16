import 'package:filmcam/features/film/data/builtin_presets.dart';
import 'package:filmcam/features/gallery/data/photo_record.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('el registro sobrevive a JSON ida y vuelta, con el look completo', () {
    final record = PhotoRecord(
      key: '2',
      originalKey: '1',
      look: kBuiltInPresets.firstWhere((p) => p.lutAsset != null),
      dateStamp: DateTime(2026, 10, 16),
    );
    expect(PhotoRecord.fromJson(record.toJson()), record);
  });
}
