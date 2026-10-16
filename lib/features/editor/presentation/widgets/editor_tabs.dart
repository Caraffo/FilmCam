import 'package:flutter/material.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';

enum EditorTab {
  filters('Filtros'),
  adjust('Ajustes');

  const EditorTab(this.label);

  final String label;
}

/// Pestañas de texto al estilo de iOS: la elegida en color de acento.
class EditorTabs extends StatelessWidget {
  const EditorTabs({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final EditorTab selected;
  final ValueChanged<EditorTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (final tab in EditorTab.values)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => onChanged(tab),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Spacing.m,
                vertical: Spacing.s,
              ),
              child: AnimatedDefaultTextStyle(
                duration: Motion.fast,
                style: textTheme.labelMedium!.copyWith(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600,
                  color: tab == selected
                      ? scheme.primary
                      : scheme.onSurfaceVariant,
                ),
                child: Text(tab.label.toUpperCase()),
              ),
            ),
          ),
      ],
    );
  }
}
