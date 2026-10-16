import 'dart:typed_data';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'captured_photo.freezed.dart';

/// Una foto sacada: el original de la cámara y, cuando termina de procesarse,
/// la versión con el look aplicado.
@freezed
abstract class CapturedPhoto with _$CapturedPhoto {
  const CapturedPhoto._();

  const factory CapturedPhoto({
    required Uint8List original,
    Uint8List? filtered,
    @Default(false) bool originalSaved,
    Object? processingError,
  }) = _CapturedPhoto;

  bool get isProcessing => filtered == null && processingError == null;
}
