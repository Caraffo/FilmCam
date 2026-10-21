import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';

const double _ringSize = 68;
const double _ringStroke = 1.5;
const double _ringStartScale = 1.25;
const double _trackHeight = 120;
const double _trackWidth = 28;
const double _trackLineWidth = 1.5;
const double _trackAlpha = 0.6;
const double _sunSize = 20;

/// Aro de enfoque donde se tocó, con la barra de brillo al costado (el sol
/// sube y baja con la exposición).
class FocusIndicator extends StatelessWidget {
  const FocusIndicator({
    super.key,
    required this.center,
    required this.area,
    required this.visible,
    required this.exposure,
    required this.minExposure,
    required this.maxExposure,
  });

  final Offset center;
  final Size area;
  final bool visible;
  final double exposure;
  final double minExposure;
  final double maxExposure;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    // La barra va a la derecha del aro, o a la izquierda si no entra.
    final trackOnRight =
        center.dx + _ringSize / 2 + Spacing.s + _trackWidth < area.width;
    final range = maxExposure - minExposure;
    final fraction = range == 0 ? 0.5 : (exposure - minExposure) / range;
    final trackLeft = trackOnRight
        ? center.dx + _ringSize / 2 + Spacing.s
        : center.dx - _ringSize / 2 - Spacing.s - _trackWidth;
    final trackTop = (center.dy - _trackHeight / 2).clamp(
      0.0,
      area.height - _trackHeight,
    );

    return IgnorePointer(
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Motion.medium,
        child: Stack(
          children: [
            Positioned(
              left: center.dx - _ringSize / 2,
              top: center.dy - _ringSize / 2,
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: _ringStartScale, end: 1),
                duration: Motion.medium,
                curve: Motion.emphasized,
                builder: (context, scale, child) =>
                    Transform.scale(scale: scale, child: child),
                child: Container(
                  width: _ringSize,
                  height: _ringSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: color, width: _ringStroke),
                  ),
                ),
              ),
            ),
            Positioned(
              left: trackLeft,
              top: trackTop,
              width: _trackWidth,
              height: _trackHeight,
              child: _ExposureTrack(fraction: fraction, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExposureTrack extends StatelessWidget {
  const _ExposureTrack({required this.fraction, required this.color});

  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final sunTop = (1 - fraction) * (_trackHeight - _sunSize);
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Positioned.fill(
          child: Center(
            child: Container(
              width: _trackLineWidth,
              color: color.withValues(alpha: _trackAlpha),
            ),
          ),
        ),
        Positioned(
          top: sunTop,
          child: Icon(
            CupertinoIcons.sun_max_fill,
            size: _sunSize,
            color: color,
          ),
        ),
      ],
    );
  }
}
