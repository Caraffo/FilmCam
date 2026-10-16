import 'dart:ui' as ui;

import 'package:filmcam/features/camera/data/photo_processor.dart';
import 'package:filmcam/features/film/data/builtin_presets.dart';
import 'package:filmcam/features/film/data/film_preset.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

const _width = 40;
const _height = 30;
const _jpegTolerance = 6;

img.Image _gradient() {
  final image = img.Image(width: _width, height: _height);
  for (var y = 0; y < _height; y++) {
    for (var x = 0; x < _width; x++) {
      image.setPixelRgb(x, y, x * 6, y * 8, 128);
    }
  }
  return image;
}

Future<ui.Image> _loadLut() async {
  final data = await rootBundle.load(LutAssets.identity);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  return (await codec.getNextFrame()).image;
}

Future<img.Image> _process(WidgetTester tester, FilmPreset look) async {
  final result = await tester.runAsync(() async {
    final program = await ui.FragmentProgram.fromAsset('shaders/film.frag');
    final jpeg = await const PhotoProcessor().process(
      img.encodePng(_gradient()),
      look: look,
      program: program,
      lut: await _loadLut(),
    );
    return img.decodeJpg(jpeg)!;
  });
  return result!;
}

void main() {
  testWidgets('el look neutro no altera la foto', (tester) async {
    final output = await _process(tester, kOriginalPreset);
    final input = _gradient();

    expect(output.width, _width);
    expect(output.height, _height);
    for (final (x, y) in [(0, 0), (20, 15), (39, 29), (10, 25)]) {
      final a = input.getPixel(x, y);
      final b = output.getPixel(x, y);
      expect(
        (a.r - b.r).abs(),
        lessThanOrEqualTo(_jpegTolerance),
        reason: 'R en ($x,$y)',
      );
      expect(
        (a.g - b.g).abs(),
        lessThanOrEqualTo(_jpegTolerance),
        reason: 'G en ($x,$y)',
      );
      expect(
        (a.b - b.b).abs(),
        lessThanOrEqualTo(_jpegTolerance),
        reason: 'B en ($x,$y)',
      );
    }
  });

  testWidgets('el LUT identidad con intensidad completa no altera la foto', (
    tester,
  ) async {
    const look = FilmPreset(
      id: 'lut',
      name: 'LUT',
      lutAsset: LutAssets.identity,
    );
    final output = await _process(tester, look);
    final input = _gradient();
    final a = input.getPixel(20, 15);
    final b = output.getPixel(20, 15);
    expect((a.r - b.r).abs(), lessThanOrEqualTo(_jpegTolerance));
    expect((a.g - b.g).abs(), lessThanOrEqualTo(_jpegTolerance));
    expect((a.b - b.b).abs(), lessThanOrEqualTo(_jpegTolerance));
  });

  testWidgets('Plata 400 deja la foto en blanco y negro', (tester) async {
    final silver = kBuiltInPresets.firstWhere((p) => p.id == 'silver_400');
    final output = await _process(tester, silver.copyWith(grain: 0));
    final pixel = output.getPixel(20, 15);
    expect((pixel.r - pixel.g).abs(), lessThanOrEqualTo(_jpegTolerance));
    expect((pixel.g - pixel.b).abs(), lessThanOrEqualTo(_jpegTolerance));
  });
}
