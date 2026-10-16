import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../camera/data/captured_photo.dart';
import '../../../camera/presentation/capture_providers.dart';
import '../widgets/before_after_view.dart';

const Duration _transitionDuration = Duration(milliseconds: 220);
const double _transitionStartScale = 0.94;
const double _dismissVelocity = 700;

/// Muestra la última foto apenas se saca, con el comparador contra el
/// original y la opción de guardar también el original.
class ReviewScreen extends ConsumerWidget {
  const ReviewScreen({super.key});

  static Route<void> route() => PageRouteBuilder(
    transitionDuration: _transitionDuration,
    reverseTransitionDuration: _transitionDuration,
    pageBuilder: (_, _, _) => const ReviewScreen(),
    transitionsBuilder: (_, animation, _, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOut);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: _transitionStartScale, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );

  Future<void> _saveOriginal(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(captureProvider.notifier).saveOriginal();
      messenger.showSnackBar(
        const SnackBar(content: Text('Original guardado en la galería')),
      );
    } catch (error) {
      messenger.showSnackBar(
        SnackBar(content: Text('No se pudo guardar el original: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = ref.watch(captureProvider);
    final media = MediaQuery.of(context);
    final decodeWidth = (media.size.width * media.devicePixelRatio).round();

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onVerticalDragEnd: (d) {
            if ((d.primaryVelocity ?? 0) > _dismissVelocity) {
              Navigator.of(context).pop();
            }
          },
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  tooltip: 'Volver a la cámara',
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(CupertinoIcons.chevron_down),
                ),
              ),
              Expanded(
                child: photo == null
                    ? const SizedBox.shrink()
                    : _PhotoView(photo: photo, decodeWidth: decodeWidth),
              ),
              const SizedBox(height: Spacing.m),
              if (photo != null)
                _ReviewActions(
                  photo: photo,
                  onSaveOriginal: () => _saveOriginal(context, ref),
                ),
              const SizedBox(height: Spacing.l),
            ],
          ),
        ),
      ),
    );
  }
}

class _PhotoView extends StatelessWidget {
  const _PhotoView({required this.photo, required this.decodeWidth});

  final CapturedPhoto photo;
  final int decodeWidth;

  @override
  Widget build(BuildContext context) {
    final filtered = photo.filtered;
    if (filtered != null) {
      return BeforeAfterView(
        original: photo.original,
        filtered: filtered,
        decodeWidth: decodeWidth,
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.memory(
          photo.original,
          fit: BoxFit.contain,
          cacheWidth: decodeWidth,
        ),
        Center(
          child: photo.processingError == null
              ? const _StatusPill(text: 'Revelando…', loading: true)
              : _StatusPill(
                  text:
                      'No se pudo aplicar el filtro: ${photo.processingError}',
                ),
        ),
      ],
    );
  }
}

class _StatusPill extends StatelessWidget {
  const _StatusPill({required this.text, this.loading = false});

  static const double _alpha = 0.7;
  static const double _spinnerSize = 14;

  final String text;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.all(Spacing.l),
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.m,
        vertical: Spacing.s,
      ),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: _alpha),
        borderRadius: BorderRadius.circular(Spacing.l),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (loading) ...[
            const SizedBox.square(
              dimension: _spinnerSize,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
            const SizedBox(width: Spacing.s),
          ],
          Flexible(child: Text(text, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}

class _ReviewActions extends StatelessWidget {
  const _ReviewActions({required this.photo, required this.onSaveOriginal});

  final CapturedPhoto photo;
  final VoidCallback onSaveOriginal;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Text(
          photo.filtered == null
              ? 'La versión con filtro se guarda sola al terminar'
              : 'La versión con filtro ya está en tu galería',
          style: textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: Spacing.m),
        TextButton.icon(
          onPressed: photo.originalSaved ? null : onSaveOriginal,
          icon: Icon(
            photo.originalSaved
                ? CupertinoIcons.checkmark_alt
                : CupertinoIcons.arrow_down_to_line,
          ),
          label: Text(
            photo.originalSaved ? 'Original guardado' : 'Guardar original',
          ),
          style: TextButton.styleFrom(
            foregroundColor: scheme.primary,
            textStyle: textTheme.titleSmall,
          ),
        ),
      ],
    );
  }
}
