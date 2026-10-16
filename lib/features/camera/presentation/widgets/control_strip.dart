import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/round_icon_button.dart';
import '../../../film/presentation/film_providers.dart';
import 'camera_panel.dart';

/// Fila con el nombre del look activo y los accesos a exposición y balance.
class ControlStrip extends ConsumerWidget {
  const ControlStrip({super.key, required this.panel, required this.onToggle});

  final CameraPanelMode panel;
  final ValueChanged<CameraPanelMode> onToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final look = ref.watch(activeLookProvider);
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: Row(
        children: [
          RoundIconButton(
            tooltip: 'Exposición',
            icon: CupertinoIcons.plusminus_circle,
            active: panel == CameraPanelMode.exposure,
            onPressed: () => onToggle(CameraPanelMode.exposure),
          ),
          Expanded(
            child: Text(
              look.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: textTheme.labelMedium?.copyWith(
                letterSpacing: 1.5,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          RoundIconButton(
            tooltip: 'Balance de blancos',
            icon: CupertinoIcons.thermometer,
            active: panel == CameraPanelMode.whiteBalance,
            onPressed: () => onToggle(CameraPanelMode.whiteBalance),
          ),
        ],
      ),
    );
  }
}
