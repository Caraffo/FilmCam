import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../film/data/film_preset.dart';
import '../../film/presentation/film_providers.dart';
import '../../gallery/presentation/gallery_providers.dart';
import '../../settings/data/app_setting.dart';
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

/// Relación de aspecto de las fotos; se recuerda entre sesiones.
@Riverpod(keepAlive: true)
class CaptureAspectSetting extends _$CaptureAspectSetting {
  @override
  CaptureAspect build() {
    final saved = ref
        .read(settingsRepositoryProvider)
        .getChoice(StoredChoice.captureAspect);
    return CaptureAspect.values.asNameMap()[saved] ?? CaptureAspect.native;
  }

  Future<void> select(CaptureAspect aspect) async {
    state = aspect;
    await ref
        .read(settingsRepositoryProvider)
        .setChoice(StoredChoice.captureAspect, aspect.name);
  }
}

/// Fotos sacadas en esta sesión que todavía hacen falta, de la más nueva a
/// la más vieja: la última (para la miniatura) y las que se están revelando
/// o fallaron. [takePhoto] vuelve apenas está el original; el revelado sigue
/// en segundo plano, de a una foto por vez para no agotar la memoria al
/// sacar varias seguidas.
@Riverpod(keepAlive: true)
class Capture extends _$Capture {
  bool _shooting = false;
  int _nextId = 0;
  Future<void> _developQueue = Future.value();

  @override
  List<CapturedPhoto> build() => const [];

  /// Dispara la cámara y vuelve cuando la foto ya se tomó. Devuelve false
  /// si había otra captura en curso. Los errores al sacar la foto se
  /// propagan; los del revelado quedan en [CapturedPhoto.processingError].
  Future<bool> takePhoto() async {
    if (_shooting) return false;
    _shooting = true;
    try {
      final look = ref.read(activeLookProvider);
      final dateStamp = ref.read(settingProvider(AppSetting.dateStamp))
          ? DateTime.now()
          : null;
      final file = await ref.read(cameraSessionProvider.notifier).takePicture();
      final photo = CapturedPhoto(
        id: _nextId++,
        original: await file.readAsBytes(),
        aspect: ref.read(captureAspectSettingProvider),
      );
      state = [photo, ...state];
      _developQueue = _developQueue.then(
        (_) => _develop(photo, look, dateStamp),
      );
      return true;
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
      _update(
        photo.id,
        (p) => p.copyWith(
          filtered: developed.jpeg,
          galleryKey: developed.record.key,
        ),
      );
      // Ya está en el álbum: solo se conserva si es la última (miniatura).
      if (state.isNotEmpty && state.first.id != photo.id) {
        state = [
          for (final p in state)
            if (p.id != photo.id) p,
        ];
      }
      ref.invalidate(galleryPhotosProvider);
    } catch (error) {
      _update(photo.id, (p) => p.copyWith(processingError: error));
    }
  }

  void _update(int id, CapturedPhoto Function(CapturedPhoto) update) {
    state = [for (final p in state) p.id == id ? update(p) : p];
  }
}
