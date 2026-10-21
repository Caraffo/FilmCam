import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../../../film/data/builtin_presets.dart';
import '../../../film/data/film_preset.dart';
import '../preset_params.dart';
import 'adjustment_slider.dart';

const _lutOptions = <String?, String>{
  null: 'Ninguno',
  LutAssets.classicFx: 'Clásico',
  LutAssets.cine800t: 'Cine',
  LutAssets.mood: 'Otoño',
};

/// Elección del LUT de color y su intensidad.
class LutPicker extends StatelessWidget {
  const LutPicker({
    super.key,
    required this.look,
    required this.base,
    required this.onChanged,
  });

  final FilmPreset look;
  final FilmPreset base;
  final ValueChanged<FilmPreset> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Wrap(
          spacing: Spacing.s,
          children: [
            for (final entry in _lutOptions.entries)
              _LutChip(
                label: entry.value,
                selected: look.lutAsset == entry.key,
                onTap: () {
                  HapticFeedback.selectionClick();
                  onChanged(look.copyWith(lutAsset: entry.key));
                },
              ),
          ],
        ),
        if (look.lutAsset != null) ...[
          const SizedBox(height: Spacing.s),
          AdjustmentSlider(
            param: kLutIntensityParam,
            value: kLutIntensityParam.read(look),
            resetValue: kLutIntensityParam.read(base),
            onChanged: (v) => onChanged(kLutIntensityParam.write(look, v)),
          ),
        ],
      ],
    );
  }
}

class _LutChip extends StatelessWidget {
  const _LutChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  static const double _height = 34;

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: Motion.fast,
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_height / 2),
          border: Border.all(color: selected ? scheme.primary : scheme.outline),
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? scheme.primary : scheme.onSurface,
          ),
        ),
      ),
    );
  }
}
