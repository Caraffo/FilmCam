import 'dart:isolate';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';
import 'package:image/image.dart' as img;

import '../../film/data/film_preset.dart';
import '../../film/rendering/film_shader_uniforms.dart';

const int _jpegQuality = 92;

// Fecha estampada al estilo de las cámaras compactas de rollo.
const Color _dateStampColor = Color(0xFFFF8A1E);
const double _dateStampHeightRatio = 0.03;
const double _dateStampMarginRatio = 0.04;
const double _dateStampGlowSigma = 4;

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
    final photo = await _decode(originalBytes);
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
      if (dateStamp != null) _paintDateStamp(canvas, size, dateStamp);

      final rendered = await recorder.endRecording().toImage(
        photo.width,
        photo.height,
      );
      final rgba = await rendered.toByteData(
        format: ui.ImageByteFormat.rawRgba,
      );
      rendered.dispose();
      if (rgba == null) {
        throw StateError('No se pudo leer la foto procesada.');
      }
      // Solo datos enviables al isolate: ui.Image no lo es.
      final pixels = rgba.buffer.asUint8List();
      final width = photo.width;
      final height = photo.height;
      return Isolate.run(() => _encodeJpeg(pixels, width, height));
    } finally {
      shader.dispose();
      photo.dispose();
    }
  }

  Future<ui.Image> _decode(Uint8List bytes) async {
    final codec = await ui.instantiateImageCodec(bytes);
    final frame = await codec.getNextFrame();
    codec.dispose();
    return frame.image;
  }

  void _paintDateStamp(ui.Canvas canvas, ui.Size size, DateTime date) {
    final fontSize = size.shortestSide * _dateStampHeightRatio;
    final text =
        "'${_twoDigits(date.year % 100)} "
        '${_twoDigits(date.month)} ${_twoDigits(date.day)}';
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: _dateStampColor,
          fontSize: fontSize,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w600,
          shadows: const [
            Shadow(color: _dateStampColor, blurRadius: _dateStampGlowSigma),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final margin = size.shortestSide * _dateStampMarginRatio;
    painter.paint(
      canvas,
      ui.Offset(
        size.width - painter.width - margin,
        size.height - painter.height - margin,
      ),
    );
    painter.dispose();
  }

  static String _twoDigits(int value) => value.toString().padLeft(2, '0');
}

Uint8List _encodeJpeg(Uint8List rgba, int width, int height) {
  final image = img.Image.fromBytes(
    width: width,
    height: height,
    bytes: rgba.buffer,
    numChannels: 4,
  );
  return img.encodeJpg(image, quality: _jpegQuality);
}
