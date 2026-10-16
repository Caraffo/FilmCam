import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/presentation/film_filter.dart';
import '../../../film/presentation/film_providers.dart';
import '../camera_session.dart';

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
        child: FilmFilter(
          look: ref.watch(activeLookProvider),
          child: CameraPreview(camera.controller),
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
