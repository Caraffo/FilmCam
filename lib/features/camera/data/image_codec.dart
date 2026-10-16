import 'dart:isolate';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:image/image.dart' as img;

const int _jpegQuality = 92;

Future<ui.Image> decodeImage(Uint8List bytes) async {
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  codec.dispose();
  return frame.image;
}

/// Codifica la imagen en JPEG fuera del hilo de la UI.
Future<Uint8List> encodeJpeg(ui.Image image) async {
  final rgba = await image.toByteData(format: ui.ImageByteFormat.rawRgba);
  if (rgba == null) {
    throw StateError('No se pudieron leer los píxeles de la imagen.');
  }
  // Solo datos enviables al isolate: ui.Image no lo es.
  final pixels = rgba.buffer.asUint8List();
  final width = image.width;
  final height = image.height;
  return Isolate.run(() => _encode(pixels, width, height));
}

Uint8List _encode(Uint8List rgba, int width, int height) {
  final image = img.Image.fromBytes(
    width: width,
    height: height,
    bytes: rgba.buffer,
    numChannels: 4,
  );
  return img.encodeJpg(image, quality: _jpegQuality);
}
