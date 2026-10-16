import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../editor/presentation/screens/preset_editor_screen.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_providers.dart';

Future<void> showPresetSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) => const _PresetSheet(),
  );
}

class _PresetSheet extends ConsumerWidget {
  const _PresetSheet();

  void _openEditor(BuildContext context, FilmPreset preset) {
    Navigator.of(context)
      ..pop()
      ..push(
        MaterialPageRoute<void>(
          builder: (_) => PresetEditorScreen(initial: preset),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(presetsProvider);
    final active = ref.watch(activeLookProvider);

    return presets.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(Spacing.xl),
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Text('No se pudieron cargar los presets: $error'),
      ),
      data: (list) => ListView(
        shrinkWrap: true,
        children: [
          for (final preset in list)
            ListTile(
              title: Text(preset.name),
              subtitle: preset.isBuiltIn ? null : const Text('Tuyo'),
              selected: preset.id == active.id,
              onTap: () {
                ref.read(activeLookProvider.notifier).select(preset);
                Navigator.of(context).pop();
              },
              trailing: IconButton(
                tooltip: 'Editar',
                icon: const Icon(Icons.tune),
                onPressed: () => _openEditor(context, preset),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(Spacing.m),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.add),
              label: const Text('Crear preset desde el actual'),
              onPressed: () => _openEditor(context, active),
            ),
          ),
        ],
      ),
    );
  }
}
