// Genera los LUTs de assets/luts/ (64 niveles en mosaico de 8x8, 512x512).
// Uso: dart run tool/generate_luts.dart
import 'dart:io';
import 'dart:math' as math;

import 'package:image/image.dart' as img;

const _levels = 64;
const _tilesPerRow = 8;
const _textureSize = _levels * _tilesPerRow;
const _outputDir = 'assets/luts';

typedef ColorTransform = List<double> Function(List<double> rgb);

void main() {
  _writeLut('identity', (rgb) => rgb);
  _writeLut('classic_fx', _classicFx);
  _writeLut('cine_800t', _cine800t);
  _writeLut('mood', _mood);
}

void _writeLut(String name, ColorTransform transform) {
  final image = img.Image(width: _textureSize, height: _textureSize);
  for (var b = 0; b < _levels; b++) {
    final tileX = (b % _tilesPerRow) * _levels;
    final tileY = (b ~/ _tilesPerRow) * _levels;
    for (var g = 0; g < _levels; g++) {
      for (var r = 0; r < _levels; r++) {
        final out = transform([
          r / (_levels - 1),
          g / (_levels - 1),
          b / (_levels - 1),
        ]);
        image.setPixelRgb(
          tileX + r,
          tileY + g,
          _toByte(out[0]),
          _toByte(out[1]),
          _toByte(out[2]),
        );
      }
    }
  }
  File('$_outputDir/$name.png').writeAsBytesSync(img.encodePng(image));
  stdout.writeln('LUT generado: $_outputDir/$name.png');
}

int _toByte(double v) => (v.clamp(0.0, 1.0) * 255).round();

/// Colores sobrios: verdes hacia el cian, rojos más profundos y menos
/// saturación general, con las altas luces comprimidas.
List<double> _classicFx(List<double> rgb) {
  final hsv = _rgbToHsv(rgb);
  var hue = hsv[0];
  var sat = hsv[1] * 0.82;
  var value = hsv[2];
  hue += 18 * _hueWeight(hue, center: 120, width: 60);
  hue -= 6 * _hueWeight(hue, center: 50, width: 25);
  sat *= 1 - 0.25 * _hueWeight(hue, center: 220, width: 40);
  value *= 1 - 0.08 * _hueWeight(hue, center: 0, width: 30) * sat;
  value = _compressHighlights(value, 0.85);
  return _hsvToRgb([hue, sat, value]);
}

/// Look de cine con película tungsteno: azules y sombras hacia el teal,
/// pieles naranjas más saturadas.
List<double> _cine800t(List<double> rgb) {
  final hsv = _rgbToHsv(rgb);
  var hue = hsv[0];
  var sat = hsv[1];
  hue -= 20 * _hueWeight(hue, center: 230, width: 50);
  hue -= 25 * _hueWeight(hue, center: 120, width: 60);
  sat *= 1 + 0.2 * _hueWeight(hue, center: 30, width: 25);
  final value = _compressHighlights(hsv[2], 0.8);
  return _hsvToRgb([hue, sat.clamp(0.0, 1.0), value]);
}

/// Look apagado: verdes hacia el oliva y desaturados, azules más grises.
List<double> _mood(List<double> rgb) {
  final hsv = _rgbToHsv(rgb);
  var hue = hsv[0];
  var sat = hsv[1];
  hue -= 35 * _hueWeight(hue, center: 120, width: 60);
  sat *= 1 - 0.4 * _hueWeight(hue, center: 90, width: 50);
  sat *= 1 - 0.3 * _hueWeight(hue, center: 215, width: 45);
  sat *= 1 - 0.1 * _hueWeight(hue, center: 30, width: 30);
  final value = _compressHighlights(hsv[2], 0.8);
  return _hsvToRgb([hue, sat, value]);
}

/// Peso suave (0..1) según la distancia de un tono a [center], en grados.
double _hueWeight(double hue, {required double center, required double width}) {
  var distance = (hue - center).abs() % 360;
  if (distance > 180) distance = 360 - distance;
  if (distance >= width) return 0;
  return 0.5 + 0.5 * math.cos(math.pi * distance / width);
}

double _compressHighlights(double value, double knee) {
  if (value <= knee) return value;
  final over = (value - knee) / (1 - knee);
  return knee + (1 - knee) * (over - over * over * 0.25);
}

List<double> _rgbToHsv(List<double> rgb) {
  final maxC = rgb.reduce(math.max);
  final minC = rgb.reduce(math.min);
  final delta = maxC - minC;
  double hue = 0;
  if (delta > 0) {
    if (maxC == rgb[0]) {
      hue = 60 * (((rgb[1] - rgb[2]) / delta) % 6);
    } else if (maxC == rgb[1]) {
      hue = 60 * ((rgb[2] - rgb[0]) / delta + 2);
    } else {
      hue = 60 * ((rgb[0] - rgb[1]) / delta + 4);
    }
  }
  final sat = maxC == 0 ? 0.0 : delta / maxC;
  return [hue % 360, sat, maxC];
}

List<double> _hsvToRgb(List<double> hsv) {
  final hue = hsv[0] % 360;
  final c = hsv[2] * hsv[1];
  final x = c * (1 - ((hue / 60) % 2 - 1).abs());
  final m = hsv[2] - c;
  final (r, g, b) = switch (hue ~/ 60) {
    0 => (c, x, 0.0),
    1 => (x, c, 0.0),
    2 => (0.0, c, x),
    3 => (0.0, x, c),
    4 => (x, 0.0, c),
    _ => (c, 0.0, x),
  };
  return [r + m, g + m, b + m];
}
