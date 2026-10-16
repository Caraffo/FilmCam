import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'capture_aspect.dart';

part 'captured_photo.freezed.dart';

/// La foto recién sacada mientras se revela: el original de la cámara (sin
/// recortar) y, al terminar, la versión con el look ya guardada en la galería.
@freezed
abstract class CapturedPhoto with _$CapturedPhoto {
  const CapturedPhoto._();

  const factory CapturedPhoto({
    required Uint8List original,
    required CaptureAspect aspect,
    Uint8List? filtered,

    /// Clave de la foto en la galería, cuando ya se guardó.
    String? galleryKey,
    Object? processingError,
  }) = _CapturedPhoto;

  bool get isProcessing => filtered == null && processingError == null;
}
