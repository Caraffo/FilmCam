import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../../../gallery/presentation/screens/photo_viewer_screen.dart';
import '../../../film/presentation/film_providers.dart';
import '../../../settings/data/app_setting.dart';
import '../../../settings/presentation/settings_providers.dart';
import '../../../update/presentation/update_banner.dart';
import '../../../update/presentation/update_providers.dart';
import '../camera_layout.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import '../widgets/camera_bottom_bar.dart';
import '../widgets/camera_panel.dart';
import '../widgets/camera_top_bar.dart';
import '../widgets/camera_viewport.dart';
import '../widgets/control_strip.dart';
import '../widgets/viewfinder_gestures.dart';
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
    duration: ShutterCurtain.closeDuration,
    reverseDuration: ShutterCurtain.openDuration,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(shutterSoundPlayerProvider).preload();
    // Si no hay internet falla en silencio: se puede buscar a mano en Ajustes.
    ref.read(appUpdateProvider.notifier).check();
    preloadFilmAssets(ref).catchError(
      (Object error) =>
          debugPrint('No se pudieron precargar los filtros: $error'),
    );
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
    // La cortina queda cerrada mientras la cámara captura.
    _curtain.forward();
    try {
      final taken = await ref.read(captureProvider.notifier).takePhoto();
      // Si ya había una captura en curso, esa se encarga de la cortina.
      if (!taken) return;
      // El sonido y la vibración marcan el momento en que la foto ya se tomó.
      HapticFeedback.mediumImpact();
      if (ref.read(settingProvider(AppSetting.shutterSound))) {
        ref.read(shutterSoundPlayerProvider).play().ignore();
      }
    } catch (error) {
      _curtain.reverse();
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo sacar la foto: $error')),
      );
      return;
    }
    final openPhoto = ref.read(
      settingProvider(AppSetting.openPhotoAfterCapture),
    );
    if (!mounted) return;
    if (!openPhoto) {
      _curtain.reverse();
      return;
    }
    await Navigator.of(context).push(PhotoViewerScreen.route());
    if (mounted) _curtain.reverse();
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
                  const ViewfinderGestures(child: CameraViewport()),
                  ShutterCurtain(animation: _curtain),
                  const Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Center(child: UpdateBanner()),
                  ),
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
