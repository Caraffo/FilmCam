import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/round_icon_button.dart';
import '../../../editor/presentation/screens/preset_editor_screen.dart';
import '../../../film/presentation/film_providers.dart';
import '../../../review/presentation/screens/review_screen.dart';
import '../camera_layout.dart';
import '../camera_session.dart';
import '../capture_providers.dart';

/// Ancho de la última foto, en píxeles, para no decodificar la foto entera.
const int _thumbnailDecodeWidth = 200;

class CameraBottomBar extends ConsumerWidget {
  const CameraBottomBar({super.key, required this.onShutter});

  final VoidCallback onShutter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photo = ref.watch(captureProvider);
    final cameraReady = ref.watch(cameraSessionProvider).hasValue;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Spacing.l),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox.square(
            dimension: CameraLayout.sideButtonSize,
            child: photo == null
                ? null
                : GestureDetector(
                    onTap: () =>
                        Navigator.of(context).push(ReviewScreen.route()),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Spacing.s),
                      child: Image.memory(
                        photo.filtered ?? photo.original,
                        fit: BoxFit.cover,
                        cacheWidth: _thumbnailDecodeWidth,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
          ),
          _ShutterButton(onPressed: cameraReady ? onShutter : null),
          RoundIconButton(
            tooltip: 'Editar filtro',
            size: CameraLayout.sideButtonSize,
            icon: CupertinoIcons.slider_horizontal_3,
            onPressed: () => Navigator.of(
              context,
            ).push(PresetEditorScreen.route(ref.read(activeLookProvider))),
          ),
        ],
      ),
    );
  }
}

class _ShutterButton extends StatefulWidget {
  const _ShutterButton({required this.onPressed});

  final VoidCallback? onPressed;

  @override
  State<_ShutterButton> createState() => _ShutterButtonState();
}

class _ShutterButtonState extends State<_ShutterButton> {
  static const _pressedScale = 0.9;
  static const _disabledAlpha = 0.4;
  static const _pressDuration = Duration(milliseconds: 90);

  bool _pressed = false;

  void _setPressed(bool value) => setState(() => _pressed = value);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurface;
    final enabled = widget.onPressed != null;
    return GestureDetector(
      onTapDown: enabled ? (_) => _setPressed(true) : null,
      onTapUp: enabled ? (_) => _setPressed(false) : null,
      onTapCancel: () => _setPressed(false),
      onTap: widget.onPressed,
      child: Container(
        width: CameraLayout.shutterSize,
        height: CameraLayout.shutterSize,
        padding: const EdgeInsets.all(
          CameraLayout.shutterRingWidth + CameraLayout.shutterRingGap,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: color,
            width: CameraLayout.shutterRingWidth,
          ),
        ),
        child: AnimatedScale(
          scale: _pressed ? _pressedScale : 1,
          duration: _pressDuration,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: enabled ? color : color.withValues(alpha: _disabledAlpha),
            ),
          ),
        ),
      ),
    );
  }
}
