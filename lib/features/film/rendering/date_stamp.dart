import 'package:flutter/painting.dart';

// Fecha estampada al estilo de las cámaras compactas de rollo. Las medidas
// son proporcionales a la foto para que el preview y el JPEG coincidan.
const Color _color = Color(0xFFFF8A1E);
const String _fontFamily = 'IBM Plex Mono';
const double _heightRatio = 0.03;
const double _marginRatio = 0.04;
const double _glowRatio = 0.15;

String formatDateStamp(DateTime date) {
  String twoDigits(int value) => value.toString().padLeft(2, '0');
  return "'${twoDigits(date.year % 100)} "
      '${twoDigits(date.month)} ${twoDigits(date.day)}';
}

/// Arma el texto de la fecha para una foto de [size], ya medido.
TextPainter layoutDateStamp(DateTime date, Size size) {
  final fontSize = size.shortestSide * _heightRatio;
  return TextPainter(
    text: TextSpan(
      text: formatDateStamp(date),
      style: TextStyle(
        color: _color,
        fontSize: fontSize,
        fontFamily: _fontFamily,
        fontWeight: FontWeight.w600,
        shadows: [Shadow(color: _color, blurRadius: fontSize * _glowRatio)],
      ),
    ),
    textDirection: TextDirection.ltr,
  )..layout();
}

/// Dónde va la fecha (abajo a la derecha) dentro de una foto de [size].
Offset dateStampOffset(TextPainter painter, Size size) {
  final margin = size.shortestSide * _marginRatio;
  return Offset(
    size.width - painter.width - margin,
    size.height - painter.height - margin,
  );
}

/// Dibuja la fecha sobre una foto de [size].
void paintDateStamp(Canvas canvas, Size size, DateTime date) {
  final painter = layoutDateStamp(date, size);
  painter.paint(canvas, dateStampOffset(painter, size));
  painter.dispose();
}
