import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../editor/presentation/screens/preset_editor_screen.dart';
import '../../../film/presentation/film_providers.dart';
import '../../../film/presentation/preset_tile_frame.dart';
import '../camera_session.dart';
import 'preset_actions_sheet.dart';
import 'preset_thumbnail.dart';

/// Carrusel de filtros con miniaturas de la cámara en vivo. Tocar elige el
/// filtro; mantener apretado abre el menú para editarlo o borrarlo.
class PresetCarousel extends ConsumerWidget {
  const PresetCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(presetsProvider).value ?? const [];
    final presetsNotifier = ref.read(presetsProvider.notifier);
    final active = ref.watch(activeLookProvider);
    final controller = ref.watch(cameraSessionProvider).value?.controller;

    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      children: [
        for (final preset in presets)
          PresetThumbnail(
            key: ValueKey(preset.id),
            name: preset.name,
            // El elegido muestra los ajustes rápidos aplicados encima.
            look: preset.id == active.id ? active : preset,
            controller: controller,
            selected: preset.id == active.id,
            onTap: () {
              if (preset.id == active.id) return;
              HapticFeedback.selectionClick();
              ref.read(activeLookProvider.notifier).select(preset);
            },
            onLongPress: () => showPresetActions(context, ref, preset),
          ),
        _IconTile(
          label: 'Nuevo',
          icon: CupertinoIcons.add,
          onTap: () => Navigator.of(
            context,
          ).push(PresetEditorScreen.route(active, createNew: true)),
        ),
        if (presetsNotifier.hasHiddenBuiltIns)
          _IconTile(
            label: 'Restaurar',
            icon: CupertinoIcons.arrow_counterclockwise,
            onTap: presetsNotifier.restoreAllBuiltIns,
          ),
      ],
    );
  }
}

class _IconTile extends StatelessWidget {
  const _IconTile({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PresetTileFrame(
      label: label,
      selected: false,
      onTap: onTap,
      child: ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: Icon(icon, color: scheme.onSurface),
      ),
    );
  }
}
