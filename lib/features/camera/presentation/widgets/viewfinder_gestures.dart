import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/viewfinder_geometry.dart';
import '../camera_session.dart';
import '../capture_providers.dart';
import 'focus_indicator.dart';

/// Recorrido vertical del dedo que cubre todo el rango de brillo.
const double _exposureDragDistance = 240;

/// Tiempo sin tocar tras el cual se esconde el indicador de enfoque.
const Duration _focusIndicatorTimeout = Duration(seconds: 3);

/// Gestos del visor, como en la cámara de Samsung:
/// - tocar enfoca y mide la luz en ese punto, y muestra el indicador;
/// - con el indicador visible, arrastrar un dedo hacia arriba o abajo sube
///   o baja el brillo;
/// - pellizcar con dos dedos hace zoom (con un toque en cada zoom entero).
class ViewfinderGestures extends ConsumerStatefulWidget {
  const ViewfinderGestures({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<ViewfinderGestures> createState() => _ViewfinderGesturesState();
}

class _ViewfinderGesturesState extends ConsumerState<ViewfinderGestures> {
  double? _pinchStartZoom;
  double _requestedZoom = 1;

  Offset? _focusPoint;
  int _focusTapCount = 0;
  bool _focusVisible = false;
  Timer? _hideTimer;

  double? _exposureDragStartOffset;
  double _exposureDragStartY = 0;

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  CameraSession get _session => ref.read(cameraSessionProvider.notifier);

  void _keepFocusVisible() {
    _hideTimer?.cancel();
    _hideTimer = Timer(_focusIndicatorTimeout, () {
      if (mounted) setState(() => _focusVisible = false);
    });
  }

  void _onTap(Offset position, Size area) {
    final camera = ref.read(cameraSessionProvider).value;
    if (camera == null) return;
    final aspect = ref.read(captureAspectSettingProvider).ratio;
    final box = viewfinderRect(area, aspect);
    if (!box.contains(position)) return;
    HapticFeedback.selectionClick();
    _session
      ..focusAt(
        previewPointFor(
          position - box.topLeft,
          box.size,
          camera.controller.value.aspectRatio,
        ),
      )
      // Como en la cámara del teléfono, un enfoque nuevo vuelve el brillo a 0.
      ..setExposureOffset(0);
    setState(() {
      _focusPoint = position;
      _focusTapCount++;
      _focusVisible = true;
    });
    _keepFocusVisible();
  }

  void _onScaleStart(ScaleStartDetails details) {
    final camera = ref.read(cameraSessionProvider).value;
    if (camera == null) return;
    if (details.pointerCount >= 2) {
      _pinchStartZoom = camera.displayZoom;
    } else if (_focusVisible) {
      _exposureDragStartOffset = camera.exposureOffset;
      _exposureDragStartY = details.focalPoint.dy;
    }
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    final camera = ref.read(cameraSessionProvider).value;
    if (camera == null) return;
    if (details.pointerCount >= 2) {
      _exposureDragStartOffset = null;
      _pinch(camera.displayZoom, details.scale);
      return;
    }
    final startOffset = _exposureDragStartOffset;
    if (startOffset == null) return;
    final range = camera.maxExposureOffset - camera.minExposureOffset;
    final dragged = _exposureDragStartY - details.focalPoint.dy;
    _session.setExposureOffset(
      startOffset + dragged / _exposureDragDistance * range,
    );
    _keepFocusVisible();
  }

  void _pinch(double currentZoom, double scale) {
    // Si el segundo dedo llegó después, el pellizco arranca recién acá.
    final start = _pinchStartZoom ??= currentZoom;
    _requestedZoom = start * scale;
    _session.pinchZoomTo(_requestedZoom);
    final reached = ref.read(cameraSessionProvider).value?.displayZoom;
    if (reached != null && currentZoom.floor() != reached.floor()) {
      HapticFeedback.selectionClick();
    }
  }

  void _onScaleEnd(ScaleEndDetails details) {
    _exposureDragStartOffset = null;
    if (_pinchStartZoom == null) return;
    _pinchStartZoom = null;
    _session.endPinch(_requestedZoom);
  }

  @override
  Widget build(BuildContext context) {
    final camera = ref.watch(cameraSessionProvider).value;
    final focusPoint = _focusPoint;
    return LayoutBuilder(
      builder: (context, constraints) {
        final area = constraints.biggest;
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTapUp: (details) => _onTap(details.localPosition, area),
          onScaleStart: _onScaleStart,
          onScaleUpdate: _onScaleUpdate,
          onScaleEnd: _onScaleEnd,
          child: Stack(
            fit: StackFit.expand,
            children: [
              widget.child,
              if (focusPoint != null && camera != null)
                FocusIndicator(
                  key: ValueKey(_focusTapCount),
                  center: focusPoint,
                  area: area,
                  visible: _focusVisible,
                  exposure: camera.exposureOffset,
                  minExposure: camera.minExposureOffset,
                  maxExposure: camera.maxExposureOffset,
                ),
            ],
          ),
        );
      },
    );
  }
}
