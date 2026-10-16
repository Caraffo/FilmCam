import 'package:flutter/animation.dart';

/// Duraciones y curvas comunes de las animaciones de la app.
abstract final class Motion {
  static const Duration fast = Duration(milliseconds: 160);
  static const Duration medium = Duration(milliseconds: 260);
  static const Duration slow = Duration(milliseconds: 380);

  static const Curve standard = Curves.easeOutCubic;
  static const Curve emphasized = Curves.easeInOutCubicEmphasized;

  /// Rebote suave para escalas (botones y tiles).
  static const Curve spring = Curves.easeOutBack;
}
