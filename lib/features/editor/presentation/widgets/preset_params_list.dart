import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/data/film_preset.dart';
import '../preset_params.dart';
import 'lut_selector.dart';
import 'param_slider.dart';

/// Lista de todos los parámetros de un look (LUT y sliders), con
/// [header] opcional arriba de todo.
class PresetParamsList extends StatelessWidget {
  const PresetParamsList({
    super.key,
    required this.look,
    required this.onChanged,
    this.header = const [],
  });

  final FilmPreset look;
  final ValueChanged<FilmPreset> onChanged;
  final List<Widget> header;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: Spacing.m),
      children: [
        ...header,
        LutSelector(
          value: look.lutAsset,
          onChanged: (asset) => onChanged(look.copyWith(lutAsset: asset)),
        ),
        for (final group in kPresetParamGroups) ...[
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Spacing.m,
              Spacing.l,
              Spacing.m,
              Spacing.s,
            ),
            child: Text(
              group.title,
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          for (final param in group.params)
            ParamSlider(
              label: param.label,
              value: param.read(look),
              min: param.min,
              max: param.max,
              decimals: param.decimals,
              onChanged: (v) => onChanged(param.write(look, v)),
            ),
        ],
      ],
    );
  }
}
