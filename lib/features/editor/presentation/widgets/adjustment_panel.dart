import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/motion_switcher.dart';
import '../../../film/data/film_preset.dart';
import '../preset_params.dart';
import 'adjustment_slider.dart';
import 'lut_picker.dart';
import 'tool_button.dart';

/// Herramienta extra que agrega quien usa el panel (por ejemplo, la fecha
/// en el editor de fotos): un botón que se prende y apaga.
class ToggleTool {
  const ToggleTool({
    required this.label,
    required this.icon,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final IconData icon;
  final bool value;
  final ValueChanged<bool> onChanged;
}

const double _toolbarHeight = 92;
const IconData _lutIcon = CupertinoIcons.film;
const String _lutLabel = 'Color';

/// Editor de un look al estilo de las apps de fotos: arriba las barras de
/// la herramienta elegida y abajo la fila de herramientas con íconos.
class AdjustmentPanel extends StatefulWidget {
  const AdjustmentPanel({
    super.key,
    required this.look,
    required this.base,
    required this.onChanged,
    this.toggles = const [],
  });

  final FilmPreset look;

  /// Look de partida: "Restablecer" vuelve a sus valores y las herramientas
  /// que difieren de él se marcan con un punto.
  final FilmPreset base;
  final ValueChanged<FilmPreset> onChanged;
  final List<ToggleTool> toggles;

  @override
  State<AdjustmentPanel> createState() => _AdjustmentPanelState();
}

class _AdjustmentPanelState extends State<AdjustmentPanel> {
  /// Índice en [kAdjustmentTools]; null es la herramienta de color (LUT).
  int? _selected = 0;

  bool get _lutModified =>
      widget.look.lutAsset != widget.base.lutAsset ||
      kLutIntensityParam.read(widget.look) !=
          kLutIntensityParam.read(widget.base);

  void _select(int? index) {
    HapticFeedback.selectionClick();
    setState(() => _selected = index);
  }

  void _reset() {
    final base = widget.base;
    var look = widget.look;
    final selected = _selected;
    if (selected == null) {
      look = kLutIntensityParam.write(
        look.copyWith(lutAsset: base.lutAsset),
        kLutIntensityParam.read(base),
      );
    } else {
      for (final param in kAdjustmentTools[selected].params) {
        look = param.write(look, param.read(base));
      }
    }
    HapticFeedback.lightImpact();
    widget.onChanged(look);
  }

  @override
  Widget build(BuildContext context) {
    final selected = _selected;
    final look = widget.look;
    final modified = selected == null
        ? _lutModified
        : kAdjustmentTools[selected].isModified(look, widget.base);

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
            child: MotionSwitcher(
              child: Column(
                key: ValueKey(selected),
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (selected == null)
                    LutPicker(
                      look: look,
                      base: widget.base,
                      onChanged: widget.onChanged,
                    )
                  else
                    for (final param in kAdjustmentTools[selected].params)
                      AdjustmentSlider(
                        param: param,
                        value: param.read(look),
                        resetValue: param.read(widget.base),
                        onChanged: (v) =>
                            widget.onChanged(param.write(look, v)),
                      ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedOpacity(
                      opacity: modified ? 1 : 0,
                      duration: Motion.fast,
                      child: TextButton(
                        onPressed: modified ? _reset : null,
                        child: const Text('Restablecer'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: _toolbarHeight,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
            children: [
              for (final toggle in widget.toggles)
                ToolButton(
                  icon: toggle.icon,
                  label: toggle.label,
                  selected: toggle.value,
                  onTap: () {
                    HapticFeedback.selectionClick();
                    toggle.onChanged(!toggle.value);
                  },
                ),
              ToolButton(
                icon: _lutIcon,
                label: _lutLabel,
                selected: selected == null,
                modified: _lutModified,
                onTap: () => _select(null),
              ),
              for (var i = 0; i < kAdjustmentTools.length; i++)
                ToolButton(
                  icon: kAdjustmentTools[i].icon,
                  label: kAdjustmentTools[i].label,
                  selected: selected == i,
                  modified: kAdjustmentTools[i].isModified(look, widget.base),
                  onTap: () => _select(i),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
