// Genera assets/sounds/shutter.wav: un clic de obturador sintetizado
// (golpe del espejo y cierre de la cortina), sin depender de audios de terceros.
// Uso: dart run tool/generate_shutter_sound.dart
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

const _sampleRate = 44100;
const _durationSeconds = 0.16;
const _outputPath = 'assets/sounds/shutter.wav';

/// Cada golpe: momento de inicio (s), volumen, decaimiento y tono grave (Hz).
const _clicks = [
  (start: 0.0, gain: 0.9, decay: 90.0, body: 180.0),
  (start: 0.065, gain: 0.6, decay: 120.0, body: 260.0),
];

void main() {
  final random = math.Random(7);
  final sampleCount = (_sampleRate * _durationSeconds).round();
  final samples = Float64List(sampleCount);

  for (final click in _clicks) {
    final offset = (click.start * _sampleRate).round();
    for (var i = offset; i < sampleCount; i++) {
      final t = (i - offset) / _sampleRate;
      final envelope = math.exp(-t * click.decay);
      final noise = random.nextDouble() * 2 - 1;
      final body = math.sin(2 * math.pi * click.body * t);
      samples[i] += click.gain * envelope * (0.7 * noise + 0.3 * body);
    }
  }

  File(_outputPath).writeAsBytesSync(_encodeWav(samples));
  stdout.writeln('Sonido generado: $_outputPath');
}

Uint8List _encodeWav(Float64List samples) {
  const bytesPerSample = 2;
  final dataSize = samples.length * bytesPerSample;
  final data = ByteData(44 + dataSize);
  void ascii(int offset, String text) {
    for (var i = 0; i < text.length; i++) {
      data.setUint8(offset + i, text.codeUnitAt(i));
    }
  }

  ascii(0, 'RIFF');
  data.setUint32(4, 36 + dataSize, Endian.little);
  ascii(8, 'WAVE');
  ascii(12, 'fmt ');
  data.setUint32(16, 16, Endian.little);
  data.setUint16(20, 1, Endian.little); // PCM
  data.setUint16(22, 1, Endian.little); // mono
  data.setUint32(24, _sampleRate, Endian.little);
  data.setUint32(28, _sampleRate * bytesPerSample, Endian.little);
  data.setUint16(32, bytesPerSample, Endian.little);
  data.setUint16(34, 16, Endian.little);
  ascii(36, 'data');
  data.setUint32(40, dataSize, Endian.little);
  for (var i = 0; i < samples.length; i++) {
    final value = (samples[i].clamp(-1.0, 1.0) * 32767).round();
    data.setInt16(44 + i * bytesPerSample, value, Endian.little);
  }
  return data.buffer.asUint8List();
}
