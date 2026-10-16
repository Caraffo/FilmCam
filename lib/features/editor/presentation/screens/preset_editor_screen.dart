import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../camera/presentation/camera_session.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_filter.dart';
import '../../../film/presentation/film_providers.dart';
import '../widgets/preset_params_list.dart';

/// Proporción del preview dentro del editor (alto de pantalla).
const _previewHeightFactor = 0.38;

/// Edita un preset con preview en vivo. Los presets de fábrica, o los
/// abiertos con [createNew], se guardan como uno nuevo; los del usuario se
/// sobrescriben.
class PresetEditorScreen extends ConsumerStatefulWidget {
  const PresetEditorScreen({
    super.key,
    required this.initial,
    this.createNew = false,
  });

  final FilmPreset initial;
  final bool createNew;

  static Route<void> route(FilmPreset initial, {bool createNew = false}) =>
      MaterialPageRoute(
        builder: (_) =>
            PresetEditorScreen(initial: initial, createNew: createNew),
      );

  bool get _savesAsNew => createNew || initial.isBuiltIn;

  @override
  ConsumerState<PresetEditorScreen> createState() => _PresetEditorScreenState();
}

class _PresetEditorScreenState extends ConsumerState<PresetEditorScreen> {
  late FilmPreset _draft = widget.initial;
  late final _nameController = TextEditingController(
    text: widget._savesAsNew
        ? '${widget.initial.name} (mío)'
        : widget.initial.name,
  );

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final name = _nameController.text.trim();
    final preset = _draft.copyWith(
      id: widget._savesAsNew
          ? 'user_${DateTime.now().millisecondsSinceEpoch}'
          : _draft.id,
      name: name.isEmpty ? widget.initial.name : name,
      isBuiltIn: false,
    );
    await _run(() => ref.read(presetsProvider.notifier).save(preset), preset);
  }

  Future<void> _delete() => _run(
    () => ref.read(presetsProvider.notifier).delete(widget.initial),
    null,
  );

  /// Ejecuta la acción, actualiza el look activo y cierra el editor.
  Future<void> _run(Future<void> Function() action, FilmPreset? select) async {
    try {
      await action();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('No se pudo guardar: $error')));
      return;
    }
    if (select != null) ref.read(activeLookProvider.notifier).select(select);
    if (mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final controller = ref.watch(cameraSessionProvider).value?.controller;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.createNew ? 'Nuevo filtro' : 'Editar filtro'),
        actions: [
          if (!widget._savesAsNew)
            IconButton(
              tooltip: 'Borrar',
              onPressed: _delete,
              icon: const Icon(CupertinoIcons.trash),
            ),
          IconButton(
            tooltip: 'Guardar',
            onPressed: _save,
            icon: const Icon(CupertinoIcons.checkmark_alt),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.sizeOf(context).height * _previewHeightFactor,
            child: controller == null
                ? const Center(child: CircularProgressIndicator())
                : Center(
                    child: FilmFilter(
                      look: _draft,
                      child: CameraPreview(controller),
                    ),
                  ),
          ),
          Expanded(
            child: PresetParamsList(
              look: _draft,
              onChanged: (look) => setState(() => _draft = look),
              header: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
