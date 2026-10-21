// Dibuja el ícono de la app y lo exporta a assets/icon/.
// Uso: flutter test tool/icon/render_icon_test.dart
//      dart run flutter_launcher_icons
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const double _size = 1024;

/// Fondo negro cálido y un solo acento ámbar, como la app.
const Color _background = Color(0xFF12100D);
const Color _body = Color(0xFFF1EBE0);
const Color _accent = Color(0xFFFFC53D);
const Color _glass = Color(0xFF12100D);
const Color _glassHighlight = Color(0x33FFFFFF);

/// Fracción del lienzo que ocupa la cámara. En el ícono adaptativo de Android
/// solo el 66 % central es seguro, por eso esa versión va más chica.
const double _fullScale = 0.78;
const double _adaptiveScale = 0.6;

class _CameraIconPainter extends CustomPainter {
  const _CameraIconPainter({required this.scale, required this.withBackground});

  final double scale;
  final bool withBackground;

  @override
  void paint(Canvas canvas, Size size) {
    if (withBackground) {
      canvas.drawRect(Offset.zero & size, Paint()..color = _background);
    }
    // Se dibuja en un espacio de 100 x 100 centrado y escalado.
    final unit = size.width * scale / 100;
    canvas
      ..translate(size.width / 2, size.height / 2)
      ..scale(unit);

    final body = Paint()..color = _body;
    // Joroba del visor, arriba a la izquierda.
    canvas.drawRRect(
      RRect.fromLTRBR(-34, -38, -6, -22, const Radius.circular(5)),
      body,
    );
    // Cuerpo.
    canvas.drawRRect(
      RRect.fromLTRBR(-50, -28, 50, 36, const Radius.circular(12)),
      body,
    );
    // Lente: aro ámbar, vidrio oscuro y un reflejo.
    const lensCenter = Offset(0, 5);
    canvas
      ..drawCircle(lensCenter, 24, Paint()..color = _background)
      ..drawCircle(
        lensCenter,
        19,
        Paint()
          ..color = _accent
          ..style = PaintingStyle.stroke
          ..strokeWidth = 4,
      )
      ..drawCircle(lensCenter, 15, Paint()..color = _glass)
      ..drawCircle(
        lensCenter.translate(-5, -5),
        5,
        Paint()..color = _glassHighlight,
      );
    // Botón de disparo.
    canvas.drawCircle(const Offset(37, -18), 4, Paint()..color = _accent);
  }

  @override
  bool shouldRepaint(_CameraIconPainter oldDelegate) => false;
}

Future<void> _export(
  String path, {
  required double scale,
  required bool withBackground,
}) async {
  final recorder = ui.PictureRecorder();
  _CameraIconPainter(
    scale: scale,
    withBackground: withBackground,
  ).paint(Canvas(recorder), const Size(_size, _size));
  final image = await recorder.endRecording().toImage(
    _size.toInt(),
    _size.toInt(),
  );
  final png = await image.toByteData(format: ui.ImageByteFormat.png);
  File(path).writeAsBytesSync(png!.buffer.asUint8List());
}

void main() {
  test('exporta el ícono', () async {
    await _export(
      'assets/icon/icon.png',
      scale: _fullScale,
      withBackground: true,
    );
    await _export(
      'assets/icon/icon_foreground.png',
      scale: _adaptiveScale,
      withBackground: false,
    );
  });
}
