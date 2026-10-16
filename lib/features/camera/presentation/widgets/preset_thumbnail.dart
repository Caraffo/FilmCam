import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../film/data/film_preset.dart';
import '../../../film/presentation/preset_tile_frame.dart';
import 'cropped_camera_preview.dart';

/// Miniatura de un filtro: el visor en vivo con ese look aplicado.
class PresetThumbnail extends StatelessWidget {
  const PresetThumbnail({
    super.key,
    required this.name,
    required this.look,
    required this.controller,
    required this.selected,
    required this.onTap,
    required this.onLongPress,
  });

  final String name;
  final FilmPreset look;
  final CameraController? controller;
  final bool selected;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  @override
  Widget build(BuildContext context) {
    final controller = this.controller;
    final scheme = Theme.of(context).colorScheme;
    return PresetTileFrame(
      label: name,
      selected: selected,
      onTap: onTap,
      onLongPress: onLongPress,
      child: controller == null || !controller.value.isInitialized
          ? ColoredBox(color: scheme.surfaceContainerHighest)
          : CroppedCameraPreview(
              controller: controller,
              look: look,
              aspectRatio: 1,
            ),
    );
  }
}
