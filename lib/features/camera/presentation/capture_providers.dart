import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../film/data/film_preset.dart';
import '../../film/presentation/film_providers.dart';
import '../../settings/presentation/settings_providers.dart';
import '../data/captured_photo.dart';
import '../data/gallery_repository.dart';
import '../data/photo_processor.dart';
import '../data/shutter_sound_player.dart';
import 'camera_session.dart';

part 'capture_providers.g.dart';

@Riverpod(keepAlive: true)
PhotoProcessor photoProcessor(Ref ref) => const PhotoProcessor();

@Riverpod(keepAlive: true)
GalleryRepository galleryRepository(Ref ref) => GalleryRepository();

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

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// procesado y el guardado de la versión con filtro siguen en segundo plano.
@Riverpod(keepAlive: true)
class Capture extends _$Capture {
  bool _shooting = false;

  @override
  CapturedPhoto? build() => null;

  /// Dispara la cámara. Los errores al sacar la foto se propagan; los del
  /// procesado quedan en [CapturedPhoto.processingError].
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
      final photo = CapturedPhoto(original: await file.readAsBytes());
      state = photo;
      unawaited(_processAndSave(photo, look, dateStamp));
    } finally {
      _shooting = false;
    }
  }

  Future<void> _processAndSave(
    CapturedPhoto photo,
    FilmPreset look,
    DateTime? dateStamp,
  ) async {
    try {
      final program = await ref.read(filmProgramProvider.future);
      final lut = await ref.read(lutImageProvider(look.lutAsset).future);
      final filtered = await ref
          .read(photoProcessorProvider)
          .process(
            photo.original,
            look: look,
            program: program,
            lut: lut,
            dateStamp: dateStamp,
          );
      await ref.read(galleryRepositoryProvider).saveJpeg(filtered);
      _updateIfCurrent(photo, (p) => p.copyWith(filtered: filtered));
    } catch (error) {
      _updateIfCurrent(photo, (p) => p.copyWith(processingError: error));
    }
  }

  Future<void> saveOriginal() async {
    final photo = state;
    if (photo == null || photo.originalSaved) return;
    await ref.read(galleryRepositoryProvider).saveJpeg(photo.original);
    _updateIfCurrent(photo, (p) => p.copyWith(originalSaved: true));
  }

  /// Aplica el cambio solo si [photo] sigue siendo la última foto.
  void _updateIfCurrent(
    CapturedPhoto photo,
    CapturedPhoto Function(CapturedPhoto) update,
  ) {
    if (identical(state?.original, photo.original)) state = update(state!);
  }
}
