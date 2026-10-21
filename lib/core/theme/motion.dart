import 'package:flutter/animation.dart';

/// Duraciones y curvas comunes de las animaciones de la app. Cortas y sin
/// rebotes; si el sistema pide reducir el movimiento, las duraciones son 0.
abstract final class Motion {
  /// Lo actualiza la app según `MediaQuery.disableAnimations`.
  static bool reduced = false;

  static Duration get fast => _scaled(120);
  static Duration get medium => _scaled(180);
  static Duration get slow => _scaled(260);

  /// Para cambios de estado.
  static const Curve standard = Cubic(0.4, 0, 0.2, 1);

  /// Para entradas: arranca rápido y frena suave.
  static const Curve emphasized = Cubic(0.22, 1, 0.36, 1);

  static Duration _scaled(int milliseconds) =>
      reduced ? Duration.zero : Duration(milliseconds: milliseconds);
}
