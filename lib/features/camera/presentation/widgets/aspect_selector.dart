import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/typography.dart';
import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../../data/capture_aspect.dart';

const double _height = 40;
const double _backgroundAlpha = 0.55;

/// Muestra la relación de aspecto actual; al tocarla se despliegan todas
/// las opciones y al elegir una se vuelve a cerrar.
class AspectSelector extends StatefulWidget {
  const AspectSelector({
    super.key,
    required this.selected,
    required this.onSelected,
  });

  final CaptureAspect selected;
  final ValueChanged<CaptureAspect> onSelected;

  @override
  State<AspectSelector> createState() => _AspectSelectorState();
}

class _AspectSelectorState extends State<AspectSelector> {
  bool _expanded = false;

  void _onTap(CaptureAspect aspect) {
    HapticFeedback.selectionClick();
    if (_expanded && aspect != widget.selected) widget.onSelected(aspect);
    setState(() => _expanded = !_expanded);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final options = _expanded ? CaptureAspect.values : [widget.selected];
    return AnimatedContainer(
      duration: Motion.medium,
      curve: Motion.standard,
      height: _height,
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest.withValues(
          alpha: _backgroundAlpha,
        ),
        borderRadius: BorderRadius.circular(_height / 2),
      ),
      child: AnimatedSize(
        duration: Motion.medium,
        curve: Motion.standard,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final aspect in options)
              _AspectOption(
                key: ValueKey(aspect),
                aspect: aspect,
                highlighted: _expanded && aspect == widget.selected,
                onTap: () => _onTap(aspect),
              ),
          ],
        ),
      ),
    );
  }
}

class _AspectOption extends StatelessWidget {
  const _AspectOption({
    super.key,
    required this.aspect,
    required this.highlighted,
    required this.onTap,
  });

  final CaptureAspect aspect;
  final bool highlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: Motion.fast,
            style: mono(Theme.of(context).textTheme.labelMedium)!.copyWith(
              fontWeight: FontWeight.w600,
              color: highlighted ? scheme.primary : scheme.onSurface,
            ),
            child: Text(aspect.label),
          ),
        ),
      ),
    );
  }
}
