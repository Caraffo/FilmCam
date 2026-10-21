import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'update_flow.dart';
import 'update_providers.dart';

/// Fila de Ajustes con el estado de las actualizaciones y el botón para
/// buscar o instalar.
class UpdateTile extends ConsumerWidget {
  const UpdateTile({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final update = ref.watch(appUpdateProvider);
    final notifier = ref.read(appUpdateProvider.notifier);
    final installed = update.installedBuild;
    final subtitle = switch (update.status) {
      UpdateStatus.idle => 'Buscá si hay una versión nueva',
      UpdateStatus.checking => 'Buscando…',
      UpdateStatus.upToDate => 'Tenés la última versión (build $installed)',
      UpdateStatus.available =>
        'Versión ${update.remote?.versionName} disponible',
      UpdateStatus.downloading => 'Descargando…',
      UpdateStatus.failed =>
        'No se pudo buscar: ${update.error}. Revisá la conexión.',
    };
    final available = update.status == UpdateStatus.available;
    return ListTile(
      leading: const Icon(CupertinoIcons.arrow_down_circle),
      title: const Text('Actualizaciones'),
      subtitle: Text(subtitle),
      trailing: TextButton(
        onPressed:
            update.status == UpdateStatus.checking ||
                update.status == UpdateStatus.downloading
            ? null
            : available
            ? () => runUpdateFlow(context, ref)
            : notifier.check,
        child: Text(available ? 'Instalar' : 'Buscar'),
      ),
    );
  }
}
