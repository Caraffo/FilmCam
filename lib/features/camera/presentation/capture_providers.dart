import 'dart:typed_data';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../film/presentation/film_providers.dart';
import '../data/gallery_repository.dart';
import '../data/photo_processor.dart';
import 'camera_session.dart';

part 'capture_providers.g.dart';

@Riverpod(keepAlive: true)
PhotoProcessor photoProcessor(Ref ref) => const PhotoProcessor();

@Riverpod(keepAlive: true)
GalleryRepository galleryRepository(Ref ref) => GalleryRepository();

/// Si se estampa la fecha en las fotos.
@Riverpod(keepAlive: true)
class DateStampEnabled extends _$DateStampEnabled {
  @override
  bool build() => false;

  void toggle() => state = !state;
}

typedef CaptureState = ({Uint8List? lastPhoto, bool isProcessing});

/// Última foto sacada (ya procesada) y si hay una procesándose.
@Riverpod(keepAlive: true)
class Capture extends _$Capture {
  @override
  CaptureState build() => (lastPhoto: null, isProcessing: false);

  /// Saca, procesa y guarda la foto. Los errores se propagan a quien llama.
  Future<void> takePhoto() async {
    if (state.isProcessing) return;
    state = (lastPhoto: state.lastPhoto, isProcessing: true);
    try {
      final jpeg = await _captureAndSave();
      state = (lastPhoto: jpeg, isProcessing: false);
    } catch (_) {
      state = (lastPhoto: state.lastPhoto, isProcessing: false);
      rethrow;
    }
  }

  Future<Uint8List> _captureAndSave() async {
    final look = ref.read(activeLookProvider);
    final file = await ref.read(cameraSessionProvider.notifier).takePicture();
    final program = await ref.read(filmProgramProvider.future);
    final lut = await ref.read(lutImageProvider(look.lutAsset).future);
    final jpeg = await ref
        .read(photoProcessorProvider)
        .process(
          await file.readAsBytes(),
          look: look,
          program: program,
          lut: lut,
          dateStamp: ref.read(dateStampEnabledProvider) ? DateTime.now() : null,
        );
    await ref.read(galleryRepositoryProvider).saveJpeg(jpeg);
    return jpeg;
  }
}
