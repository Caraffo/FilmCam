import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/fade_in_memory_image.dart';

const double _handleSize = 36;
const double _dividerWidth = 2;
const double _labelAlpha = 0.55;
const double _initialSplit = 0.5;

/// Compara el original (izquierda) con la versión con filtro (derecha)
/// arrastrando la barra. Mantener apretado muestra el original completo.
class BeforeAfterView extends StatefulWidget {
  const BeforeAfterView({
    super.key,
    required this.original,
    required this.filtered,
    required this.decodeWidth,
  });

  final Uint8List original;
  final Uint8List filtered;

  /// Ancho al que se decodifican las fotos, para no cargar la resolución
  /// completa en memoria.
  final int decodeWidth;

  @override
  State<BeforeAfterView> createState() => _BeforeAfterViewState();
}

class _BeforeAfterViewState extends State<BeforeAfterView> {
  double _split = _initialSplit;
  bool _showingOriginal = false;

  Widget _image(Uint8List bytes) => FadeInMemoryImage(
    bytes,
    fit: BoxFit.contain,
    cacheWidth: widget.decodeWidth,
  );

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        final split = _showingOriginal ? 1.0 : _split;
        return GestureDetector(
          onHorizontalDragUpdate: (d) => setState(
            () => _split = (d.localPosition.dx / width).clamp(0.0, 1.0),
          ),
          onLongPressStart: (_) => setState(() => _showingOriginal = true),
          onLongPressEnd: (_) => setState(() => _showingOriginal = false),
          child: Stack(
            fit: StackFit.expand,
            children: [
              _image(widget.filtered),
              ClipRect(
                clipper: _LeftClipper(split),
                child: _image(widget.original),
              ),
              if (!_showingOriginal) ...[
                Positioned(
                  left: width * split - _handleSize / 2,
                  top: 0,
                  bottom: 0,
                  child: const _SplitHandle(),
                ),
                const Positioned(
                  left: Spacing.m,
                  top: Spacing.m,
                  child: _Label('Original'),
                ),
                const Positioned(
                  right: Spacing.m,
                  top: Spacing.m,
                  child: _Label('Con filtro'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _LeftClipper extends CustomClipper<Rect> {
  const _LeftClipper(this.fraction);

  final double fraction;

  @override
  Rect getClip(Size size) =>
      Rect.fromLTWH(0, 0, size.width * fraction, size.height);

  @override
  bool shouldReclip(_LeftClipper oldClipper) => oldClipper.fraction != fraction;
}

class _SplitHandle extends StatelessWidget {
  const _SplitHandle();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: _handleSize,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(width: _dividerWidth, color: scheme.onSurface),
          Container(
            width: _handleSize,
            height: _handleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: scheme.onSurface,
            ),
            child: Icon(
              CupertinoIcons.arrow_left_right,
              size: Spacing.m,
              color: scheme.surface,
            ),
          ),
        ],
      ),
    );
  }
}

class _Label extends StatelessWidget {
  const _Label(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: Spacing.s,
        vertical: Spacing.xs,
      ),
      decoration: BoxDecoration(
        color: scheme.surface.withValues(alpha: _labelAlpha),
        borderRadius: BorderRadius.circular(Spacing.s),
      ),
      child: Text(text, style: Theme.of(context).textTheme.labelSmall),
    );
  }
}
