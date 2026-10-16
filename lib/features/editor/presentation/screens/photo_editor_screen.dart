import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/motion_switcher.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_filter.dart';
import '../../../gallery/presentation/gallery_providers.dart';
import '../../../gallery/presentation/widgets/status_pill.dart';
import '../../data/photo_edit_request.dart';
import '../widgets/editor_tabs.dart';
import '../widgets/photo_filter_strip.dart';
import '../widgets/preset_params_list.dart';
import '../widgets/save_options_sheet.dart';

const double _filtersPanelHeight = 112;
const double _adjustPanelHeight = 300;
const double _barrierAlpha = 0.5;

/// Edita una foto ya sacada: arranca con su look y permite cambiar de
/// filtro y ajustar los sliders. Devuelve true si se guardó.
class PhotoEditorScreen extends ConsumerStatefulWidget {
  const PhotoEditorScreen({super.key, required this.request});

  final PhotoEditRequest request;

  static Route<bool> route(PhotoEditRequest request) =>
      MaterialPageRoute(builder: (_) => PhotoEditorScreen(request: request));

  @override
  ConsumerState<PhotoEditorScreen> createState() => _PhotoEditorScreenState();
}

class _PhotoEditorScreenState extends ConsumerState<PhotoEditorScreen> {
  late FilmPreset _look = widget.request.look;
  late bool _dateStamp = widget.request.dateStamp != null;
  EditorTab _tab = EditorTab.filters;
  bool _showingOriginal = false;
  bool _saving = false;

  DateTime get _stampDate => widget.request.dateStamp ?? widget.request.takenAt;

  Future<void> _save() async {
    final mode = await showSaveOptionsSheet(context);
    if (mode == null || !mounted) return;
    setState(() => _saving = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final replaced = await ref
          .read(galleryPhotosProvider.notifier)
          .saveEdit(
            source: widget.request.source,
            originalKey: widget.request.originalKey,
            look: _look,
            dateStamp: _dateStamp ? _stampDate : null,
            replacing: mode == SaveMode.replace ? widget.request.photo : null,
          );
      if (!replaced) {
        messenger.showSnackBar(
          const SnackBar(
            content: Text('Se guardó como copia: la anterior no se borró'),
          ),
        );
      }
      if (mounted) Navigator.of(context).pop(true);
    } catch (error) {
      if (!mounted) return;
      setState(() => _saving = false);
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo guardar: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context);
    final previewWidth = (media.size.width * media.devicePixelRatio).round();
    final preview = Image.memory(
      widget.request.source,
      cacheWidth: previewWidth,
      gaplessPlayback: true,
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Cancelar',
          onPressed: _saving ? null : () => Navigator.of(context).pop(false),
          icon: const Icon(CupertinoIcons.xmark),
        ),
        title: const Text('Editar'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: const Text('Guardar'),
          ),
        ],
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onLongPressStart: (_) =>
                      setState(() => _showingOriginal = true),
                  onLongPressEnd: (_) =>
                      setState(() => _showingOriginal = false),
                  child: Center(
                    child: _showingOriginal
                        ? preview
                        : FilmFilter(
                            look: _look,
                            animateChanges: true,
                            child: preview,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: Spacing.s),
              EditorTabs(
                selected: _tab,
                onChanged: (tab) => setState(() => _tab = tab),
              ),
              AnimatedContainer(
                duration: Motion.medium,
                curve: Motion.emphasized,
                height: _tab == EditorTab.filters
                    ? _filtersPanelHeight
                    : _adjustPanelHeight,
                child: MotionSwitcher(
                  child: switch (_tab) {
                    EditorTab.filters => PhotoFilterStrip(
                      key: const ValueKey(EditorTab.filters),
                      source: widget.request.source,
                      selectedId: _look.id,
                      onSelected: (preset) => setState(() => _look = preset),
                    ),
                    EditorTab.adjust => PresetParamsList(
                      key: const ValueKey(EditorTab.adjust),
                      look: _look,
                      onChanged: (look) => setState(() => _look = look),
                      header: [
                        SwitchListTile(
                          title: const Text('Fecha en la foto'),
                          value: _dateStamp,
                          onChanged: (v) => setState(() => _dateStamp = v),
                        ),
                      ],
                    ),
                  },
                ),
              ),
            ],
          ),
          // El velo de "Revelando…" aparece y desaparece con un fundido.
          Positioned.fill(
            child: IgnorePointer(
              ignoring: !_saving,
              child: AnimatedOpacity(
                opacity: _saving ? 1 : 0,
                duration: Motion.medium,
                child: ColoredBox(
                  color: Theme.of(
                    context,
                  ).colorScheme.surface.withValues(alpha: _barrierAlpha),
                  child: const Center(
                    child: StatusPill(text: 'Revelando…', loading: true),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
