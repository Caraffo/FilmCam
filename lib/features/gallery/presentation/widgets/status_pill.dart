import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';

const double _alpha = 0.7;
const double _spinnerSize = 14;
const double _spinnerStroke = 2;

/// Cartel flotante de estado (por ejemplo, "Revelando…").
class StatusPill extends StatelessWidget {
  const StatusPill({super.key, required this.text, this.loading = false});

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
              child: CircularProgressIndicator(strokeWidth: _spinnerStroke),
            ),
            const SizedBox(width: Spacing.s),
          ],
          Flexible(child: Text(text, textAlign: TextAlign.center)),
        ],
      ),
    );
  }
}
