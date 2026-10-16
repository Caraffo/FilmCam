import 'dart:typed_data';

import 'package:filmcam/features/camera/data/capture_aspect.dart';
import 'package:filmcam/features/camera/data/captured_photo.dart';
import 'package:filmcam/features/gallery/data/gallery_item.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final capture = CapturedPhoto(
    id: 0,
    original: Uint8List(1),
    aspect: CaptureAspect.native,
  );

  test('sin foto recién sacada, la lista son solo las del álbum', () {
    expect(buildGalleryItems(const [], const []), isEmpty);
  });

  test('la foto que se está revelando va primera', () {
    final items = buildGalleryItems([capture], const []);
    expect(items.single, isA<PendingCaptureItem>());
  });

  test('ya guardada pero sin aparecer en el álbum, sigue primera', () {
    final saved = capture.copyWith(galleryKey: '42');
    final items = buildGalleryItems([saved], const []);
    expect(items.single, isA<PendingCaptureItem>());
  });
}
