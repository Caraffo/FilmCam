import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/motion.dart';
import '../../../../core/theme/spacing.dart';
import '../../../film/presentation/date_stamp_overlay.dart';
import '../../../film/presentation/film_providers.dart';
import '../../../gallery/presentation/gallery_providers.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import 'cropped_camera_preview.dart';

/// Preview de la cámara con el look activo aplicado en vivo.
class CameraViewport extends ConsumerWidget {
  const CameraViewport({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(cameraSessionProvider);
    final aspectRatio = ref.watch(captureAspectSettingProvider).ratio;
    // El fundido cubre la apertura de la cámara y el cambio de lente.
    return AnimatedSwitcher(
      duration: Motion.medium,
      child: session.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => _CameraError(
          permissionDenied: _isPermissionError(error),
          onRetry: () => ref.invalidate(cameraSessionProvider),
          onOpenSettings: ref.read(photoLibraryProvider).openPermissionSettings,
        ),
        data: (camera) => Center(
          key: ValueKey(camera.controller),
          // El visor se estira o encoge al cambiar la relación de aspecto.
          child: TweenAnimationBuilder<double>(
            tween: Tween(end: aspectRatio),
            duration: Motion.medium,
            curve: Motion.emphasized,
            builder: (context, ratio, _) => Stack(
              children: [
                CroppedCameraPreview(
                  controller: camera.controller,
                  look: ref.watch(activeLookProvider),
                  aspectRatio: ratio,
                ),
                // Muestra dónde y cómo saldrá la fecha estampada.
                if (ref.watch(dateStampEnabledProvider))
                  Positioned.fill(
                    child: DateStampOverlay(date: DateTime.now()),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

bool _isPermissionError(Object error) {
  if (error is! CameraException) return false;
  final code = error.code.toLowerCase();
  return code.contains('denied') || code.contains('permission');
}

class _CameraError extends StatelessWidget {
  const _CameraError({
    required this.permissionDenied,
    required this.onRetry,
    required this.onOpenSettings,
  });

  final bool permissionDenied;
  final VoidCallback onRetry;
  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Spacing.l),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              permissionDenied
                  ? 'FilmCam necesita permiso para usar la cámara. '
                        'Activalo en Ajustes y volvé a intentar.'
                  : 'No se pudo abrir la cámara. Puede que otra app la '
                        'esté usando: cerrala y volvé a intentar.',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: Spacing.m),
            if (permissionDenied)
              TextButton(
                onPressed: onOpenSettings,
                child: const Text('Abrir ajustes'),
              ),
            TextButton(onPressed: onRetry, child: const Text('Reintentar')),
          ],
        ),
      ),
    );
  }
}
