import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../camera_session.dart';
import '../capture_providers.dart';

/// Zooms ofrecidos como "lentes"; se muestran solo los que soporta la cámara.
const _zoomStops = [0.6, 1.0, 2.0, 3.0];

class CameraTopBar extends ConsumerWidget {
  const CameraTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraSessionProvider).value;
    final session = ref.read(cameraSessionProvider.notifier);
    final dateStamp = ref.watch(dateStampEnabledProvider);
    final zoomStops = camera == null
        ? const <double>[]
        : _zoomStops
              .where((z) => z >= camera.minZoom && z <= camera.maxZoom)
              .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.s),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Flash',
            onPressed: camera == null ? null : session.cycleFlash,
            icon: Icon(_flashIcon(camera?.flashMode ?? FlashMode.off)),
          ),
          IconButton(
            tooltip: 'Fecha en la foto',
            isSelected: dateStamp,
            onPressed: ref.read(dateStampEnabledProvider.notifier).toggle,
            icon: const Icon(Icons.event_busy),
            selectedIcon: const Icon(Icons.event),
          ),
          const Spacer(),
          for (final zoom in zoomStops)
            _ZoomChip(
              zoom: zoom,
              selected: camera?.zoom == zoom,
              onTap: () => session.setZoom(zoom),
            ),
          const Spacer(),
          IconButton(
            tooltip: 'Cambiar cámara',
            onPressed: (camera?.cameras.length ?? 0) > 1
                ? session.switchCamera
                : null,
            icon: const Icon(Icons.cameraswitch_outlined),
          ),
        ],
      ),
    );
  }

  static IconData _flashIcon(FlashMode mode) => switch (mode) {
    FlashMode.auto => Icons.flash_auto,
    FlashMode.always || FlashMode.torch => Icons.flash_on,
    FlashMode.off => Icons.flash_off,
  };
}

class _ZoomChip extends StatelessWidget {
  const _ZoomChip({
    required this.zoom,
    required this.selected,
    required this.onTap,
  });

  final double zoom;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final label = zoom == zoom.roundToDouble()
        ? '${zoom.toInt()}x'
        : '${zoom.toStringAsFixed(1)}x';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.xs),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => onTap(),
      ),
    );
  }
}
