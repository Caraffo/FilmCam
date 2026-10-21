import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import '../../film/data/film_preset.dart';
import '../../film/rendering/date_stamp.dart';
import '../../film/rendering/film_shader_uniforms.dart';
import 'image_codec.dart';

/// Aplica el look a la foto en resolución completa y la devuelve en JPEG.
class PhotoProcessor {
  const PhotoProcessor();

  Future<Uint8List> process(
    Uint8List originalBytes, {
    required FilmPreset look,
    required ui.FragmentProgram program,
    required ui.Image lut,
    DateTime? dateStamp,
  }) async {
    final photo = await decodeImage(originalBytes);
    final size = ui.Size(photo.width.toDouble(), photo.height.toDouble());
    final shader = program.fragmentShader();
    try {
      applyFilmUniforms(
        shader,
        look,
        size: size,
        lut: lut,
        isFilter: false,
        seed: math.Random().nextDouble() * 1000,
      );
      shader.setImageSampler(
        kInputSamplerIndex,
        photo,
        filterQuality: ui.FilterQuality.low,
      );

      final recorder = ui.PictureRecorder();
      final canvas = ui.Canvas(recorder);
      canvas.drawRect(ui.Offset.zero & size, ui.Paint()..shader = shader);
      if (dateStamp != null) paintDateStamp(canvas, size, dateStamp);

      final rendered = await recorder.endRecording().toImage(
        photo.width,
        photo.height,
      );
      try {
        return await encodeJpeg(rendered);
      } finally {
        rendered.dispose();
      }
    } finally {
      shader.dispose();
      photo.dispose();
    }
  }
}
