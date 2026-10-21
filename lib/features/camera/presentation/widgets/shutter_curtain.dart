import 'package:flutter/material.dart';

/// Cortina negra sobre el visor mientras la cámara captura, como el
/// apagón de una cámara real: se cierra al disparar y se abre recién cuando
/// la foto ya se tomó, así se sabe cuándo se puede mover el teléfono.
/// [animation] va de 0 (abierta) a 1 (cerrada).
class ShutterCurtain extends StatelessWidget {
  const ShutterCurtain({super.key, required this.animation});

  /// Lo que tarda en cerrarse.
  static const Duration closeDuration = Duration(milliseconds: 70);

  /// Lo que tarda en abrirse cuando la foto ya está.
  static const Duration openDuration = Duration(milliseconds: 160);

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FadeTransition(
        opacity: animation,
        child: ColoredBox(color: Theme.of(context).colorScheme.surface),
      ),
    );
  }
}
