import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../theme/motion.dart';

/// Image.memory que aparece con un fundido cuando termina de decodificarse.
class FadeInMemoryImage extends StatelessWidget {
  const FadeInMemoryImage(this.bytes, {super.key, this.fit, this.cacheWidth});

  final Uint8List bytes;
  final BoxFit? fit;
  final int? cacheWidth;

  @override
  Widget build(BuildContext context) {
    return Image.memory(
      bytes,
      fit: fit,
      cacheWidth: cacheWidth,
      gaplessPlayback: true,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (wasSynchronouslyLoaded) return child;
        return AnimatedOpacity(
          opacity: frame == null ? 0 : 1,
          duration: Motion.medium,
          curve: Motion.standard,
          child: child,
        );
      },
    );
  }
}
