import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../editor/presentation/screens/preset_editor_screen.dart';
import '../../../film/presentation/film_providers.dart';
import '../camera_session.dart';
import 'preset_thumbnail.dart';

/// Carrusel de filtros con miniaturas de la cámara en vivo. Tocar elige el
/// filtro; mantener apretado lo abre en el editor.
class PresetCarousel extends ConsumerWidget {
  const PresetCarousel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(presetsProvider).value ?? const [];
    final active = ref.watch(activeLookProvider);
    final controller = ref.watch(cameraSessionProvider).value?.controller;

    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      children: [
        for (final preset in presets)
          PresetThumbnail(
            name: preset.name,
            // El elegido muestra los ajustes rápidos aplicados encima.
            look: preset.id == active.id ? active : preset,
            controller: controller,
            selected: preset.id == active.id,
            onTap: () => ref.read(activeLookProvider.notifier).select(preset),
            onLongPress: () =>
                Navigator.of(context).push(PresetEditorScreen.route(preset)),
          ),
        _NewPresetTile(
          onTap: () => Navigator.of(
            context,
          ).push(PresetEditorScreen.route(active, createNew: true)),
        ),
      ],
    );
  }
}

class _NewPresetTile extends StatelessWidget {
  const _NewPresetTile({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return PresetTileFrame(
      label: 'Nuevo',
      selected: false,
      onTap: onTap,
      child: ColoredBox(
        color: scheme.surfaceContainerHighest,
        child: Icon(CupertinoIcons.add, color: scheme.onSurface),
      ),
    );
  }
}
