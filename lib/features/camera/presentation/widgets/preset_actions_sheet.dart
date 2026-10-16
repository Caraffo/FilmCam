import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../editor/presentation/screens/preset_editor_screen.dart';
import '../../../film/data/builtin_presets.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_providers.dart';

/// Menú de un filtro al mantenerlo apretado: editarlo o borrarlo (con la
/// opción de deshacer). "Original" solo se puede usar de base para editar.
Future<void> showPresetActions(
  BuildContext context,
  WidgetRef ref,
  FilmPreset preset,
) {
  HapticFeedback.mediumImpact();
  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.of(context);
  final presets = ref.read(presetsProvider.notifier);

  Future<void> delete() async {
    try {
      await presets.delete(preset);
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo borrar el filtro: $error')),
      );
      return;
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text('Borraste "${preset.name}"'),
        action: SnackBarAction(
          label: 'Deshacer',
          onPressed: () => presets.restore(preset),
        ),
      ),
    );
  }

  return showCupertinoModalPopup<void>(
    context: context,
    builder: (sheetContext) {
      void close(VoidCallback action) {
        Navigator.of(sheetContext).pop();
        action();
      }

      return CupertinoActionSheet(
        title: Text(preset.name),
        actions: [
          CupertinoActionSheetAction(
            onPressed: () => close(
              () => navigator.push(
                PresetEditorScreen.route(
                  preset,
                  createNew: preset.id == kOriginalPresetId,
                ),
              ),
            ),
            child: Text(
              preset.id == kOriginalPresetId
                  ? 'Crear filtro a partir de este'
                  : 'Editar',
            ),
          ),
          if (preset.id != kOriginalPresetId)
            CupertinoActionSheetAction(
              isDestructiveAction: true,
              onPressed: () => close(delete),
              child: const Text('Borrar'),
            ),
        ],
        cancelButton: CupertinoActionSheetAction(
          onPressed: () => Navigator.of(sheetContext).pop(),
          child: const Text('Cancelar'),
        ),
      );
    },
  );
}
