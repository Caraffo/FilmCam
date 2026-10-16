import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../film/presentation/film_providers.dart';
import '../camera_session.dart';
import 'white_balance_pad.dart';

enum _Adjustment { whiteBalance, exposure }

/// Ajustes rápidos: balance de blancos o exposición de la cámara.
class AdjustmentPanel extends StatefulWidget {
  const AdjustmentPanel({super.key});

  @override
  State<AdjustmentPanel> createState() => _AdjustmentPanelState();
}

class _AdjustmentPanelState extends State<AdjustmentPanel> {
  _Adjustment _selected = _Adjustment.whiteBalance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: Column(
        children: [
          SegmentedButton<_Adjustment>(
            segments: const [
              ButtonSegment(
                value: _Adjustment.whiteBalance,
                icon: Icon(Icons.thermostat),
                label: Text('Balance'),
              ),
              ButtonSegment(
                value: _Adjustment.exposure,
                icon: Icon(Icons.exposure),
                label: Text('Exposición'),
              ),
            ],
            selected: {_selected},
            onSelectionChanged: (s) => setState(() => _selected = s.first),
          ),
          const SizedBox(height: Spacing.s),
          switch (_selected) {
            _Adjustment.whiteBalance => const _WhiteBalanceControls(),
            _Adjustment.exposure => const _ExposureControls(),
          },
        ],
      ),
    );
  }
}

class _WhiteBalanceControls extends ConsumerWidget {
  const _WhiteBalanceControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final look = ref.watch(activeLookProvider);
    final notifier = ref.read(activeLookProvider.notifier);
    return Row(
      children: [
        Expanded(
          child: WhiteBalancePad(
            temperatureK: look.temperatureK,
            tint: look.tint,
            onChanged: notifier.setWhiteBalance,
          ),
        ),
        IconButton(
          tooltip: 'Volver al balance del preset',
          onPressed: notifier.resetWhiteBalance,
          icon: const Icon(Icons.restart_alt),
        ),
      ],
    );
  }
}

class _ExposureControls extends ConsumerWidget {
  const _ExposureControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraSessionProvider).value;
    if (camera == null ||
        camera.minExposureOffset == camera.maxExposureOffset) {
      return const SizedBox(height: WhiteBalancePad.height);
    }
    final session = ref.read(cameraSessionProvider.notifier);
    return SizedBox(
      height: WhiteBalancePad.height,
      child: Row(
        children: [
          Expanded(
            child: Slider(
              min: camera.minExposureOffset,
              max: camera.maxExposureOffset,
              value: camera.exposureOffset,
              label: camera.exposureOffset.toStringAsFixed(1),
              onChanged: session.setExposureOffset,
            ),
          ),
          SizedBox(
            width: Spacing.xl * 2,
            child: Text(
              '${camera.exposureOffset.toStringAsFixed(1)} EV',
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
