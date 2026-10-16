import 'package:filmcam/features/camera/data/capture_aspect.dart';
import 'package:filmcam/features/camera/data/photo_cropper.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

void main() {
  final photo = img.encodeJpg(img.Image(width: 300, height: 400));

  Future<img.Image> crop(WidgetTester tester, CaptureAspect aspect) async {
    final bytes = await tester.runAsync(
      () => cropToAspect(photo, aspect.ratio),
    );
    return img.decodeJpg(bytes!)!;
  }

  testWidgets('1:1 recorta al cuadrado del centro', (tester) async {
    final result = await crop(tester, CaptureAspect.square);
    expect((result.width, result.height), (300, 300));
  });

  testWidgets('9:16 recorta los costados', (tester) async {
    final result = await crop(tester, CaptureAspect.tall);
    expect((result.width, result.height), (225, 400));
  });

  testWidgets('3:4 deja la foto igual', (tester) async {
    final result = await crop(tester, CaptureAspect.native);
    expect((result.width, result.height), (300, 400));
  });
}
