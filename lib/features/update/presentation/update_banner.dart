import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/motion.dart';
import '../../../core/theme/spacing.dart';
import 'update_flow.dart';
import 'update_providers.dart';

const double _alpha = 0.85;

/// Aviso discreto cuando hay una versión nueva, con el botón para instalarla.
class UpdateBanner extends ConsumerStatefulWidget {
  const UpdateBanner({super.key});

  @override
  ConsumerState<UpdateBanner> createState() => _UpdateBannerState();
}

class _UpdateBannerState extends ConsumerState<UpdateBanner> {
  bool _dismissed = false;

  @override
  Widget build(BuildContext context) {
    final update = ref.watch(appUpdateProvider);
    final visible = update.status == UpdateStatus.available && !_dismissed;
    final scheme = Theme.of(context).colorScheme;
    return IgnorePointer(
      ignoring: !visible,
      child: AnimatedOpacity(
        opacity: visible ? 1 : 0,
        duration: Motion.medium,
        child: Container(
          margin: const EdgeInsets.all(Spacing.s),
          padding: const EdgeInsets.only(left: Spacing.m),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHigh.withValues(alpha: _alpha),
            borderRadius: BorderRadius.circular(Spacing.l),
            border: Border.all(color: scheme.outline),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Hay una versión nueva',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextButton(
                onPressed: () => runUpdateFlow(context, ref),
                child: const Text('Actualizar'),
              ),
              IconButton(
                tooltip: 'Ahora no',
                visualDensity: VisualDensity.compact,
                onPressed: () => setState(() => _dismissed = true),
                icon: const Icon(CupertinoIcons.xmark, size: Spacing.m),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
