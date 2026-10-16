import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/data/film_preset.dart';

// Colores que representan el efecto de cada eje sobre la foto.
const _coolColor = Color(0xFF4FC3F7);
const _warmColor = Color(0xFFFF8A65);
const _magentaColor = Color(0x99E040FB);
const _greenColor = Color(0x9976FF03);
const _knobSize = 28.0;
const _knobBorder = 3.0;

/// Pad 2D de balance de blancos: horizontal temperatura (derecha más
/// cálido), vertical tint (arriba magenta, abajo verde).
class WhiteBalancePad extends StatelessWidget {
  const WhiteBalancePad({
    super.key,
    required this.temperatureK,
    required this.tint,
    required this.onChanged,
  });

  static const double height = 96;

  final double temperatureK;
  final double tint;
  final void Function(double temperatureK, double tint) onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      children: [
        Text(
          '${temperatureK.round()}K ${tint.round()}',
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: Spacing.xs),
        SizedBox(
          height: height - Spacing.l,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final size = constraints.biggest;
              void update(Offset position) => _onPosition(position, size);
              final knob = _knobCenter(size);
              return GestureDetector(
                onPanDown: (d) => update(d.localPosition),
                onPanUpdate: (d) => update(d.localPosition),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const _PadGradient(),
                    Positioned(
                      left: knob.dx - _knobSize / 2,
                      top: knob.dy - _knobSize / 2,
                      child: Container(
                        width: _knobSize,
                        height: _knobSize,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: scheme.surface,
                          border: Border.all(
                            color: scheme.onSurface,
                            width: _knobBorder,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Offset _knobCenter(Size size) {
    final x =
        (temperatureK - kMinTemperatureK) /
        (kMaxTemperatureK - kMinTemperatureK);
    final y = (kMaxTint - tint) / (2 * kMaxTint);
    return Offset(x * size.width, y * size.height);
  }

  void _onPosition(Offset position, Size size) {
    final x = (position.dx / size.width).clamp(0.0, 1.0);
    final y = (position.dy / size.height).clamp(0.0, 1.0);
    onChanged(
      kMinTemperatureK + x * (kMaxTemperatureK - kMinTemperatureK),
      kMaxTint - y * 2 * kMaxTint,
    );
  }
}

class _PadGradient extends StatelessWidget {
  const _PadGradient();

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(Spacing.m);
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          gradient: const LinearGradient(colors: [_coolColor, _warmColor]),
        ),
        foregroundDecoration: BoxDecoration(
          borderRadius: radius,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [_magentaColor, Colors.transparent, _greenColor],
          ),
        ),
      ),
    );
  }
}
