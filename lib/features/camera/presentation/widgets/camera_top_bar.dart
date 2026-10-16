import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/round_icon_button.dart';
import '../../../settings/presentation/settings_sheet.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import 'aspect_selector.dart';

class CameraTopBar extends ConsumerWidget {
  const CameraTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraSessionProvider).value;
    final session = ref.read(cameraSessionProvider.notifier);
    final dateStamp = ref.watch(dateStampEnabledProvider);
    final flash = camera?.flashMode ?? FlashMode.off;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.m,
        vertical: Spacing.s,
      ),
      child: Row(
        children: [
          RoundIconButton(
            tooltip: 'Flash',
            icon: _flashIcon(flash),
            active: flash != FlashMode.off,
            onPressed: camera == null ? null : session.cycleFlash,
          ),
          const SizedBox(width: Spacing.s),
          RoundIconButton(
            tooltip: 'Fecha en la foto',
            icon: CupertinoIcons.calendar,
            active: dateStamp,
            onPressed: ref.read(dateStampEnabledProvider.notifier).toggle,
          ),
          const SizedBox(width: Spacing.s),
          RoundIconButton(
            tooltip: 'Ajustes',
            icon: CupertinoIcons.gear,
            onPressed: () => showSettingsSheet(context),
          ),
          const Spacer(),
          AspectSelector(
            selected: ref.watch(captureAspectSettingProvider),
            onSelected: ref.read(captureAspectSettingProvider.notifier).select,
          ),
          const SizedBox(width: Spacing.s),
          RoundIconButton(
            tooltip: 'Cambiar cámara',
            icon: CupertinoIcons.arrow_2_circlepath,
            onPressed: camera?.lenses.front != null
                ? session.switchCamera
                : null,
          ),
        ],
      ),
    );
  }

  static IconData _flashIcon(FlashMode mode) => switch (mode) {
    FlashMode.auto => CupertinoIcons.bolt_badge_a_fill,
    FlashMode.always || FlashMode.torch => CupertinoIcons.bolt_fill,
    FlashMode.off => CupertinoIcons.bolt_slash_fill,
  };
}
