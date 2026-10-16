import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../film/data/film_preset.dart';
import '../../film/presentation/film_providers.dart';
import '../../gallery/presentation/gallery_providers.dart';
import '../../settings/presentation/settings_providers.dart';
import '../data/capture_aspect.dart';
import '../data/captured_photo.dart';
import '../data/photo_cropper.dart';
import '../data/shutter_sound_player.dart';
import 'camera_session.dart';

part 'capture_providers.g.dart';

@Riverpod(keepAlive: true)
ShutterSoundPlayer shutterSoundPlayer(Ref ref) {
  final player = ShutterSoundPlayer();
  ref.onDispose(player.dispose);
  return player;
}

/// Si se estampa la fecha en las fotos.
@Riverpod(keepAlive: true)
class DateStampEnabled extends _$DateStampEnabled {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

@Riverpod(keepAlive: true)
class CaptureAspectSetting extends _$CaptureAspectSetting {
  @override
  CaptureAspect build() => CaptureAspect.native;

  void select(CaptureAspect aspect) => state = aspect;
}

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// recorte, el revelado y el guardado siguen en segundo plano.
@Riverpod(keepAlive: true)
class Capture extends _$Capture {
  bool _shooting = false;

  @override
  CapturedPhoto? build() => null;

  /// Dispara la cámara. Los errores al sacar la foto se propagan; los del
  /// revelado quedan en [CapturedPhoto.processingError].
  Future<void> takePhoto() async {
    if (_shooting) return;
    _shooting = true;
    try {
      if (ref.read(shutterSoundEnabledProvider).value ?? true) {
        // El sonido no debe frenar ni hacer fallar el disparo.
        ref.read(shutterSoundPlayerProvider).play().ignore();
      }
      final look = ref.read(activeLookProvider);
      final dateStamp = ref.read(dateStampEnabledProvider)
          ? DateTime.now()
          : null;
      final file = await ref.read(cameraSessionProvider.notifier).takePicture();
      final photo = CapturedPhoto(
        original: await file.readAsBytes(),
        aspect: ref.read(captureAspectSettingProvider),
      );
      state = photo;
      unawaited(_develop(photo, look, dateStamp));
    } finally {
      _shooting = false;
    }
  }

  Future<void> _develop(
    CapturedPhoto photo,
    FilmPreset look,
    DateTime? dateStamp,
  ) async {
    try {
      final original = photo.aspect == CaptureAspect.native
          ? photo.original
          : await cropToAspect(photo.original, photo.aspect.ratio);
      final originalKey = await ref
          .read(photoRecordStoreProvider)
          .storeOriginal(original);
      final developed = await developPhoto(
        ref,
        original: original,
        originalKey: originalKey,
        look: look,
        dateStamp: dateStamp,
      );
      _updateIfCurrent(
        photo,
        (p) => p.copyWith(
          filtered: developed.jpeg,
          galleryKey: developed.record.key,
        ),
      );
      ref.invalidate(galleryPhotosProvider);
    } catch (error) {
      _updateIfCurrent(photo, (p) => p.copyWith(processingError: error));
    }
  }

  /// Aplica el cambio solo si [photo] sigue siendo la última foto.
  void _updateIfCurrent(
    CapturedPhoto photo,
    CapturedPhoto Function(CapturedPhoto) update,
  ) {
    if (identical(state?.original, photo.original)) state = update(state!);
  }
}
