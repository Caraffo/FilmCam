import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/motion_switcher.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/date_stamp_overlay.dart';
import '../../../film/presentation/film_filter.dart';
import '../../../gallery/presentation/gallery_providers.dart';
import '../../../gallery/presentation/widgets/status_pill.dart';
import '../../data/photo_edit_request.dart';
import '../widgets/editor_tabs.dart';
import '../widgets/photo_filter_strip.dart';
import '../widgets/adjustment_panel.dart';
import '../widgets/save_options_sheet.dart';

const double _filtersPanelHeight = 112;
const double _adjustPanelHeight = 250;
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

  /// Filtro elegido; los ajustes se marcan y restablecen respecto de él.
  late FilmPreset _base = widget.request.look;
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
                    child: Stack(
                      children: [
                        if (_showingOriginal)
                          preview
                        else
                          FilmFilter(
                            look: _look,
                            animateChanges: true,
                            child: preview,
                          ),
                        if (_dateStamp && !_showingOriginal)
                          Positioned.fill(
                            child: DateStampOverlay(date: _stampDate),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              if (!widget.request.hasOriginal)
                const _NoOriginalNotice()
              else
                const _CompareHint(),
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
                      originalLabel: widget.request.hasOriginal
                          ? null
                          : 'Sin cambios',
                      onSelected: (preset) => setState(() {
                        HapticFeedback.selectionClick();
                        _look = _base = preset;
                      }),
                    ),
                    EditorTab.adjust => AdjustmentPanel(
                      key: const ValueKey(EditorTab.adjust),
                      look: _look,
                      base: _base,
                      onChanged: (look) => setState(() => _look = look),
                      toggles: [
                        ToggleTool(
                          label: 'Fecha',
                          icon: CupertinoIcons.calendar,
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

/// Aviso para fotos sin original guardado: el filtro se aplica sobre la
/// versión que ya tiene look y no se puede volver a la foto sin filtro.
class _NoOriginalNotice extends StatelessWidget {
  const _NoOriginalNotice();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(Spacing.m, Spacing.s, Spacing.m, 0),
      child: Text(
        'Esta foto es de antes de que FilmCam guardara los originales: '
        'se edita sobre la versión con filtro y no se puede quitar.',
        textAlign: TextAlign.center,
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}

class _CompareHint extends StatelessWidget {
  const _CompareHint();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: Spacing.s),
      child: Text(
        'Mantené apretada la foto para ver el original',
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
      ),
    );
  }
}
