import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/spacing.dart';
import '../camera_session.dart';
import '../widgets/adjustment_panel.dart';
import '../widgets/camera_bottom_bar.dart';
import '../widgets/camera_top_bar.dart';
import '../widgets/camera_viewport.dart';

class CameraScreen extends ConsumerStatefulWidget {
  const CameraScreen({super.key});

  @override
  ConsumerState<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends ConsumerState<CameraScreen>
    with WidgetsBindingObserver {
  bool _closedInBackground = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            CameraTopBar(),
            Expanded(child: CameraViewport()),
            SizedBox(height: Spacing.s),
            AdjustmentPanel(),
            SizedBox(height: Spacing.m),
            CameraBottomBar(),
            SizedBox(height: Spacing.m),
          ],
        ),
      ),
    );
  }
}
