import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/theme/typography.dart';
import '../preset_params.dart';

const double _trackHeight = 4;
const double _thumbSize = 22;
const double _thumbBorder = 2;
const double _neutralTickHeight = 12;
const double _touchHeight = 44;

// Colores de las barras que representan un efecto sobre la foto.
const _coolColor = Color(0xFF5AA9E6);
const _warmColor = Color(0xFFF2A541);
const _greenColor = Color(0xFF7BC67B);
const _magentaColor = Color(0xFFD46FC8);
const _hueStops = [
  Color(0xFFE05A5A),
  Color(0xFFE0C35A),
  Color(0xFF6CC56C),
  Color(0xFF5AC4E0),
  Color(0xFF5A6CE0),
  Color(0xFFC85AE0),
  Color(0xFFE05A5A),
];

/// Barra de un parámetro con su nombre y valor. Se rellena desde el valor
/// neutro; doble toque en el nombre vuelve al valor del filtro
/// ([resetValue]).
class AdjustmentSlider extends StatelessWidget {
  const AdjustmentSlider({
    super.key,
    required this.param,
    required this.value,
    required this.resetValue,
    required this.onChanged,
  });

  final PresetParam param;
  final double value;
  final double resetValue;
  final ValueChanged<double> onChanged;

  double _fraction(double v) =>
      ((v - param.min) / (param.max - param.min)).clamp(0.0, 1.0);

  void _onDrag(double dx, double width) {
    final fraction = (dx / width).clamp(0.0, 1.0);
    final next = param.min + fraction * (param.max - param.min);
    // Un toque al cruzar el valor neutro, para sentir el "centro".
    final crossed = (value - param.neutral).sign != (next - param.neutral).sign;
    if (crossed) HapticFeedback.selectionClick();
    onChanged(next);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onDoubleTap: () {
            HapticFeedback.lightImpact();
            onChanged(resetValue);
          },
          child: Row(
            children: [
              Text(
                param.label,
                style: textTheme.bodyMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Text(param.format(value), style: mono(textTheme.labelLarge)),
            ],
          ),
        ),
        const SizedBox(height: Spacing.xs),
        SizedBox(
          height: _touchHeight,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = constraints.maxWidth;
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onHorizontalDragUpdate: (d) =>
                    _onDrag(d.localPosition.dx, width),
                onTapDown: (d) => _onDrag(d.localPosition.dx, width),
                child: CustomPaint(
                  size: Size(width, _touchHeight),
                  painter: _SliderPainter(
                    track: param.track,
                    value: _fraction(value),
                    neutral: _fraction(param.neutral),
                    trackColor: scheme.outline,
                    fillColor: scheme.onSurface,
                    thumbColor: scheme.onSurface,
                    thumbBorderColor: scheme.surface,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SliderPainter extends CustomPainter {
  const _SliderPainter({
    required this.track,
    required this.value,
    required this.neutral,
    required this.trackColor,
    required this.fillColor,
    required this.thumbColor,
    required this.thumbBorderColor,
  });

  final ParamTrack track;
  final double value;
  final double neutral;
  final Color trackColor;
  final Color fillColor;
  final Color thumbColor;
  final Color thumbBorderColor;

  List<Color>? get _gradient => switch (track) {
    ParamTrack.plain => null,
    ParamTrack.temperature => const [_coolColor, _warmColor],
    ParamTrack.tint => const [_greenColor, _magentaColor],
    ParamTrack.hue => _hueStops,
  };

  @override
  void paint(Canvas canvas, Size size) {
    // El pulgar no se sale de los bordes.
    const inset = _thumbSize / 2;
    final left = inset;
    final right = size.width - inset;
    final centerY = size.height / 2;
    double x(double fraction) => left + (right - left) * fraction;

    final trackRect = RRect.fromLTRBR(
      left,
      centerY - _trackHeight / 2,
      right,
      centerY + _trackHeight / 2,
      const Radius.circular(_trackHeight / 2),
    );
    final gradient = _gradient;
    final trackPaint = Paint();
    if (gradient == null) {
      trackPaint.color = trackColor;
    } else {
      trackPaint.shader = LinearGradient(
        colors: gradient,
      ).createShader(trackRect.outerRect);
    }
    canvas.drawRRect(trackRect, trackPaint);

    if (gradient == null) {
      final from = x(neutral);
      final to = x(value);
      canvas.drawRRect(
        RRect.fromLTRBR(
          from < to ? from : to,
          centerY - _trackHeight / 2,
          from < to ? to : from,
          centerY + _trackHeight / 2,
          const Radius.circular(_trackHeight / 2),
        ),
        Paint()..color = fillColor,
      );
    }
    if (neutral > 0 && neutral < 1) {
      canvas.drawLine(
        Offset(x(neutral), centerY - _neutralTickHeight / 2),
        Offset(x(neutral), centerY + _neutralTickHeight / 2),
        Paint()
          ..color = fillColor
          ..strokeWidth = 1,
      );
    }
    final thumbCenter = Offset(x(value), centerY);
    canvas
      ..drawCircle(thumbCenter, _thumbSize / 2, Paint()..color = thumbColor)
      ..drawCircle(
        thumbCenter,
        _thumbSize / 2,
        Paint()
          ..color = thumbBorderColor
          ..style = PaintingStyle.stroke
          ..strokeWidth = _thumbBorder,
      );
  }

  @override
  bool shouldRepaint(_SliderPainter old) =>
      old.value != value ||
      old.neutral != neutral ||
      old.track != track ||
      old.fillColor != fillColor;
}
