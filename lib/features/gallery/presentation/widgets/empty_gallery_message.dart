import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';

/// Galería vacía, con la acción para volver a la cámara.
class EmptyGalleryMessage extends StatelessWidget {
  const EmptyGalleryMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Todavía no sacaste fotos con FilmCam',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
          const SizedBox(height: Spacing.s),
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((r) => r.isFirst),
            child: const Text('Sacar una foto'),
          ),
        ],
      ),
    );
  }
}
