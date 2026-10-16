import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/motion_switcher.dart';
import '../../../../core/widgets/round_icon_button.dart';
import '../../../film/presentation/film_providers.dart';
import '../camera_session.dart';
import 'preset_carousel.dart';
import 'white_balance_pad.dart';

enum CameraPanelMode { filters, exposure, whiteBalance }

/// Zona inferior del visor: el carrusel de filtros o el ajuste abierto.
class CameraPanel extends StatelessWidget {
  const CameraPanel({super.key, required this.mode});

  final CameraPanelMode mode;

  @override
  Widget build(BuildContext context) {
    return MotionSwitcher(
      child: switch (mode) {
        CameraPanelMode.filters => const PresetCarousel(),
        CameraPanelMode.exposure => const _ExposureControls(),
        CameraPanelMode.whiteBalance => const _WhiteBalanceControls(),
      },
    );
  }
}

class _WhiteBalanceControls extends ConsumerWidget {
  const _WhiteBalanceControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final look = ref.watch(activeLookProvider);
    final notifier = ref.read(activeLookProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
      child: Row(
        children: [
          Expanded(
            child: WhiteBalancePad(
              temperatureK: look.temperatureK,
              tint: look.tint,
              onChanged: notifier.setWhiteBalance,
            ),
          ),
          const SizedBox(width: Spacing.s),
          RoundIconButton(
            tooltip: 'Volver al balance del filtro',
            icon: CupertinoIcons.arrow_counterclockwise,
            onPressed: notifier.resetWhiteBalance,
          ),
        ],
      ),
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
      return const Center(child: Text('Exposición no disponible'));
    }
    final session = ref.read(cameraSessionProvider.notifier);
    final value = camera.exposureOffset;
    final sign = value > 0 ? '+' : '';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$sign${value.toStringAsFixed(1)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: Spacing.s),
          Row(
            children: [
              const Icon(CupertinoIcons.minus, size: Spacing.m),
              Expanded(
                child: Slider(
                  min: camera.minExposureOffset,
                  max: camera.maxExposureOffset,
                  value: value,
                  onChanged: session.setExposureOffset,
                ),
              ),
              const Icon(CupertinoIcons.plus, size: Spacing.m),
            ],
          ),
        ],
      ),
    );
  }
}
