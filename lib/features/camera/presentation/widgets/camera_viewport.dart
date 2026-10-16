import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/presentation/film_providers.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import 'cropped_camera_preview.dart';

/// Preview de la cámara con el look activo aplicado en vivo.
class CameraViewport extends ConsumerWidget {
  const CameraViewport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(cameraSessionProvider);
    return session.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _CameraError(
        message: error.toString(),
        onRetry: () => ref.invalidate(cameraSessionProvider),
      ),
      data: (camera) => Center(
        child: CroppedCameraPreview(
          controller: camera.controller,
          look: ref.watch(activeLookProvider),
          aspectRatio: ref.watch(captureAspectSettingProvider).ratio,
        ),
      ),
    );
  }
}

class _CameraError extends StatelessWidget {
  const _CameraError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'No se pudo abrir la cámara.\n$message',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.m),
            FilledButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
