import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/presentation/film_providers.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import 'preset_sheet.dart';

const _thumbnailSize = 64.0;
const _shutterSize = 76.0;
const _shutterBorder = 4.0;

class CameraBottomBar extends ConsumerWidget {
  const CameraBottomBar({super.key});

  Future<void> _takePhoto(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(captureProvider.notifier).takePhoto();
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo guardar la foto: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final capture = ref.watch(captureProvider);
    final cameraReady = ref.watch(cameraSessionProvider).hasValue;
    final look = ref.watch(activeLookProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _Thumbnail(capture: capture),
          _ShutterButton(
            enabled: cameraReady && !capture.isProcessing,
            onPressed: () => _takePhoto(context, ref),
          ),
          SizedBox(
            width: _thumbnailSize * 1.5,
            child: TextButton(
              onPressed: () => showPresetSheet(context),
              child: Text(look.name, textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.capture});

  final CaptureState capture;

  @override
  Widget build(BuildContext context) {
    final photo = capture.lastPhoto;
    final scheme = Theme.of(context).colorScheme;
    return SizedBox.square(
      dimension: _thumbnailSize,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Spacing.m),
        child: ColoredBox(
          color: scheme.surfaceContainerHighest,
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (photo != null)
                GestureDetector(
                  onTap: () => showDialog<void>(
                    context: context,
                    builder: (_) => Dialog(child: Image.memory(photo)),
                  ),
                  child: Image.memory(photo, fit: BoxFit.cover),
                ),
              if (capture.isProcessing)
                const Center(child: CircularProgressIndicator()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ShutterButton extends StatelessWidget {
  const _ShutterButton({required this.enabled, required this.onPressed});

  final bool enabled;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: enabled ? onPressed : null,
      child: Container(
        width: _shutterSize,
        height: _shutterSize,
        padding: const EdgeInsets.all(_shutterBorder),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: scheme.onSurface, width: _shutterBorder),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: enabled
                ? scheme.onSurface
                : scheme.onSurface.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }
}
