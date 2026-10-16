import 'dart:typed_data';
import 'dart:ui' as ui;

import 'image_codec.dart';

/// Recorta una foto al centro con la relación de aspecto pedida
/// (ancho / alto). Si ya la tiene, la devuelve tal cual.
Future<Uint8List> cropToAspect(Uint8List jpeg, double aspect) async {
  final photo = await decodeImage(jpeg);
  try {
    final source = _centerCrop(photo.width, photo.height, aspect);
    if (source.width == photo.width && source.height == photo.height) {
      return jpeg;
    }
    final recorder = ui.PictureRecorder();
    ui.Canvas(recorder).drawImageRect(
      photo,
      source,
      ui.Offset.zero & source.size,
      ui.Paint()..filterQuality = ui.FilterQuality.none,
    );
    final cropped = await recorder.endRecording().toImage(
      source.width.round(),
      source.height.round(),
    );
    try {
      return await encodeJpeg(cropped);
    } finally {
      cropped.dispose();
    }
  } finally {
    photo.dispose();
  }
}

ui.Rect _centerCrop(int width, int height, double aspect) {
  if (width / height > aspect) {
    final croppedWidth = (height * aspect).roundToDouble();
    return ui.Rect.fromLTWH(
      (width - croppedWidth) / 2,
      0,
      croppedWidth,
      height.toDouble(),
    );
  }
  final croppedHeight = (width / aspect).roundToDouble();
  return ui.Rect.fromLTWH(
    0,
    (height - croppedHeight) / 2,
    width.toDouble(),
    croppedHeight,
  );
}
