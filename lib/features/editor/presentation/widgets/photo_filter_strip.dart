import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/data/builtin_presets.dart';
import '../../../film/data/film_preset.dart';
import '../../../film/presentation/film_filter.dart';
import '../../../film/presentation/film_providers.dart';
import '../../../film/presentation/preset_tile_frame.dart';

/// Ancho al que se decodifica la foto para las miniaturas.
const int _thumbnailDecodeWidth = 240;

/// Carrusel de filtros con la foto que se está editando como miniatura.
class PhotoFilterStrip extends ConsumerWidget {
  const PhotoFilterStrip({
    super.key,
    required this.source,
    required this.selectedId,
    required this.onSelected,
    this.originalLabel,
  });

  final Uint8List source;
  final String selectedId;
  final ValueChanged<FilmPreset> onSelected;

  /// Nombre a mostrar en lugar de "Original" (por ejemplo, cuando la foto
  /// no tiene original guardado y ese tile la deja como está).
  final String? originalLabel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presets = ref.watch(presetsProvider).value ?? const [];
    return ListView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.m,
        vertical: Spacing.s,
      ),
      children: [
        for (final preset in presets)
          PresetTileFrame(
            label: preset.id == kOriginalPresetId
                ? originalLabel ?? preset.name
                : preset.name,
            selected: preset.id == selectedId,
            onTap: () => onSelected(preset),
            child: FilmFilter(
              look: preset,
              child: Image.memory(
                source,
                fit: BoxFit.cover,
                cacheWidth: _thumbnailDecodeWidth,
                width: kPresetTileSize,
                height: kPresetTileSize,
              ),
            ),
          ),
      ],
    );
  }
}
