import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/round_icon_button.dart';
import '../../../settings/presentation/settings_providers.dart';
import '../camera_session.dart';
import '../capture_providers.dart';

class CameraTopBar extends ConsumerWidget {
  const CameraTopBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final camera = ref.watch(cameraSessionProvider).value;
    final session = ref.read(cameraSessionProvider.notifier);
    final dateStamp = ref.watch(dateStampEnabledProvider);
    final sound = ref.watch(shutterSoundEnabledProvider).value ?? true;
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
            tooltip: 'Sonido del obturador',
            icon: sound
                ? CupertinoIcons.speaker_2_fill
                : CupertinoIcons.speaker_slash_fill,
            active: sound,
            onPressed: ref.read(shutterSoundEnabledProvider.notifier).toggle,
          ),
          const Spacer(),
          _AspectButton(
            label: ref.watch(captureAspectSettingProvider).label,
            onPressed: ref.read(captureAspectSettingProvider.notifier).cycle,
          ),
          const SizedBox(width: Spacing.s),
          RoundIconButton(
            tooltip: 'Cambiar cámara',
            icon: CupertinoIcons.arrow_2_circlepath,
            onPressed: (camera?.cameras.length ?? 0) > 1
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

/// Botón con la relación de aspecto actual; al tocarlo pasa a la siguiente.
class _AspectButton extends StatelessWidget {
  const _AspectButton({required this.label, required this.onPressed});

  static const double _height = 40;
  static const double _backgroundAlpha = 0.55;

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: _height,
        padding: const EdgeInsets.symmetric(horizontal: Spacing.m),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest.withValues(
            alpha: _backgroundAlpha,
          ),
          borderRadius: BorderRadius.circular(_height / 2),
        ),
        child: Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
