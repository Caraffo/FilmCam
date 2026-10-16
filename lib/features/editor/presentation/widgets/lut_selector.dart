import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/data/builtin_presets.dart';

const _lutOptions = <String?, String>{
  null: 'Sin LUT',
  LutAssets.classicFx: 'Clásico',
  LutAssets.cine800t: 'Cine',
  LutAssets.mood: 'Otoño',
};

class LutSelector extends StatelessWidget {
  const LutSelector({super.key, required this.value, required this.onChanged});

  final String? value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.m, Spacing.m, 0),
      child: DropdownButtonFormField<String?>(
        initialValue: value,
        decoration: const InputDecoration(labelText: 'LUT de color'),
        items: [
          for (final entry in _lutOptions.entries)
            DropdownMenuItem(value: entry.key, child: Text(entry.value)),
        ],
        onChanged: onChanged,
      ),
    );
  }
}
