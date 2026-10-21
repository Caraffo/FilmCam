import 'package:flutter/foundation.dart';

/// Manda valores a la cámara de a uno. Si llegan varios mientras se aplica
/// uno (por ejemplo, al arrastrar un dedo), se aplica solo el último.
class LatestValueApplier<T extends Object> {
  LatestValueApplier(this._apply, {required this.description});

  final Future<void> Function(T value) _apply;

  /// Qué se aplica, para el log si falla (por ejemplo, "el zoom").
  final String description;

  T? _pending;
  bool _running = false;

  void push(T value) {
    _pending = value;
    if (!_running) _drain();
  }

  Future<void> _drain() async {
    _running = true;
    try {
      while (_pending != null) {
        final next = _pending!;
        _pending = null;
        await _apply(next);
      }
    } catch (error) {
      debugPrint('No se pudo aplicar $description: $error');
    } finally {
      _running = false;
    }
  }
}
