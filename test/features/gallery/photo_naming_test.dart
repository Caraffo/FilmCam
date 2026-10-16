import 'package:filmcam/features/gallery/data/photo_naming.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('reconoce la clave de una foto revelada por la app', () {
    expect(photoKeyFromTitle('${galleryNameFor('123')}.jpg'), '123');
  });

  test('los originales exportados y otras fotos no tienen clave', () {
    expect(photoKeyFromTitle('${galleryNameForOriginal('123')}.jpg'), isNull);
    expect(photoKeyFromTitle('IMG_2024.jpg'), isNull);
  });
}
