import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/painting.dart';

import '../../film/data/film_preset.dart';
import '../../film/rendering/film_shader_uniforms.dart';
import 'image_codec.dart';

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
      if (dateStamp != null) _paintDateStamp(canvas, size, dateStamp);

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
