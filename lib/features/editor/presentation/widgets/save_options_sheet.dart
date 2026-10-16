import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum SaveMode { copy, replace }

/// Pregunta si guardar la edición como copia o reemplazar la foto.
Future<SaveMode?> showSaveOptionsSheet(BuildContext context) {
  return showModalBottomSheet<SaveMode>(
    context: context,
    showDragHandle: true,
    builder: (context) => SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(CupertinoIcons.doc_on_doc),
            title: const Text('Guardar copia'),
            subtitle: const Text('La foto anterior queda en la galería'),
            onTap: () => Navigator.of(context).pop(SaveMode.copy),
          ),
          ListTile(
            leading: const Icon(CupertinoIcons.arrow_2_squarepath),
            title: const Text('Reemplazar'),
            subtitle: const Text(
              'Se borra la anterior; Android te pide confirmar',
            ),
            onTap: () => Navigator.of(context).pop(SaveMode.replace),
          ),
        ],
      ),
    ),
  );
}
