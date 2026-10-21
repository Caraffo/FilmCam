import 'package:flutter/material.dart';

import '../../../core/theme/motion.dart';
import '../../../core/theme/spacing.dart';

const double kPresetTileSize = 56;
const double _tileRadius = 12;
const double _selectedBorderWidth = 2;
const double _unselectedScale = 0.94;
const double _pressedScale = 0.9;

/// Marco común de los tiles de filtros: imagen redondeada y nombre debajo.
/// El elegido se agranda y se resalta; al apretarlo se hunde un poco.
class PresetTileFrame extends StatefulWidget {
  const PresetTileFrame({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.child,
    this.onLongPress,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;
  final Widget child;

  @override
  State<PresetTileFrame> createState() => _PresetTileFrameState();
}

class _PresetTileFrameState extends State<PresetTileFrame> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final radius = BorderRadius.circular(_tileRadius);
    final scale = _pressed
        ? _pressedScale
        : widget.selected
        ? 1.0
        : _unselectedScale;

    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      onTapDown: (_) => _setPressed(true),
      onTapUp: (_) => _setPressed(false),
      onTapCancel: () => _setPressed(false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
        child: Column(
          children: [
            AnimatedScale(
              scale: scale,
              duration: Motion.fast,
              curve: Motion.emphasized,
              child: AnimatedContainer(
                duration: Motion.fast,
                curve: Motion.standard,
                width: kPresetTileSize,
                height: kPresetTileSize,
                foregroundDecoration: BoxDecoration(
                  borderRadius: radius,
                  border: Border.all(
                    color: widget.selected
                        ? scheme.primary
                        : Colors.transparent,
                    width: _selectedBorderWidth,
                  ),
                ),
                child: ClipRRect(borderRadius: radius, child: widget.child),
              ),
            ),
            const SizedBox(height: Spacing.s),
            SizedBox(
              width: kPresetTileSize + Spacing.m,
              child: AnimatedDefaultTextStyle(
                duration: Motion.fast,
                style: textTheme.labelSmall!.copyWith(
                  color: widget.selected
                      ? scheme.primary
                      : scheme.onSurfaceVariant,
                  fontWeight: widget.selected
                      ? FontWeight.w600
                      : FontWeight.w500,
                ),
                child: Text(
                  widget.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
