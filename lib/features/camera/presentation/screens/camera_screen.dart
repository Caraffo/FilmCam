import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../gallery/presentation/screens/gallery_screen.dart';
import '../camera_layout.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import '../widgets/camera_bottom_bar.dart';
import '../widgets/camera_panel.dart';
import '../widgets/camera_top_bar.dart';
import '../widgets/camera_viewport.dart';
import '../widgets/control_strip.dart';
import '../widgets/shutter_curtain.dart';
import '../widgets/zoom_selector.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  bool _closedInBackground = false;
  CameraPanelMode _panel = CameraPanelMode.filters;
  late final AnimationController _curtain = AnimationController(
    vsync: this,
    duration: ShutterCurtain.duration,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(shutterSoundPlayerProvider).preload();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _curtain.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Android libera la cámara en segundo plano: se cierra y se reabre.
    // Solo se cierra si ya estaba abierta, para no cortar la apertura cuando
    // aparece el diálogo de permisos.
    switch (state) {
      case AppLifecycleState.inactive
          when ref.read(cameraSessionProvider).hasValue:
        _closedInBackground = true;
        ref.read(cameraSessionProvider.notifier).close();
      case AppLifecycleState.resumed when _closedInBackground:
        _closedInBackground = false;
        ref.invalidate(cameraSessionProvider);
      default:
        break;
    }
  }

  void _togglePanel(CameraPanelMode mode) =>
      setState(() => _panel = _panel == mode ? CameraPanelMode.filters : mode);

  Future<void> _shoot() async {
    HapticFeedback.mediumImpact();
    _curtain.forward(from: 0);
    try {
      await ref.read(captureProvider.notifier).takePhoto();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo sacar la foto: $error')),
      );
      return;
    }
    if (!mounted) return;
    await _curtain.forward();
    if (mounted) await Navigator.of(context).push(GalleryScreen.route());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CameraTopBar(),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const CameraViewport(),
                  ShutterCurtain(animation: _curtain),
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: Spacing.m,
                    child: ZoomSelector(),
                  ),
                ],
              ),
            ),
            const SizedBox(height: Spacing.s),
            ControlStrip(panel: _panel, onToggle: _togglePanel),
            const SizedBox(height: Spacing.s),
            SizedBox(
              height: CameraLayout.panelHeight,
              child: CameraPanel(mode: _panel),
            ),
            const SizedBox(height: Spacing.s),
            CameraBottomBar(onShutter: _shoot),
            const SizedBox(height: Spacing.m),
          ],
        ),
      ),
    );
  }
}
