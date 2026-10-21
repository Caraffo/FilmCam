import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import 'update_providers.dart';

/// Baja la versión nueva mostrando el avance y abre el instalador. Si algo
/// falla, lo avisa con un snackbar.
Future<void> runUpdateFlow(BuildContext context, WidgetRef ref) async {
  final messenger = ScaffoldMessenger.of(context);
  final navigator = Navigator.of(context, rootNavigator: true);
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (_) => const _DownloadDialog(),
  );
  try {
    await ref.read(appUpdateProvider.notifier).install();
  } catch (error) {
    messenger.showSnackBar(
      SnackBar(content: Text('No se pudo actualizar: $error')),
    );
  } finally {
    navigator.pop();
  }
}

class _DownloadDialog extends ConsumerWidget {
  const _DownloadDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final update = ref.watch(appUpdateProvider);
    final progress = update.progress;
    final percent = (progress * 100).round();
    return AlertDialog(
      title: const Text('Actualizando FilmCam'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Versión ${update.remote?.versionName ?? ''}',
            style: mono(Theme.of(context).textTheme.labelMedium),
          ),
          const SizedBox(height: Spacing.m),
          LinearProgressIndicator(
            value: progress > 0 && progress < 1 ? progress : null,
          ),
          const SizedBox(height: Spacing.s),
          Text(
            progress < 1
                ? 'Descargando… $percent %'
                : 'Abriendo el instalador…',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
