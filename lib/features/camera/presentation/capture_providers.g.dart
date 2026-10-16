// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(photoProcessor)
final photoProcessorProvider = PhotoProcessorProvider._();

final class PhotoProcessorProvider
    extends $FunctionalProvider<PhotoProcessor, PhotoProcessor, PhotoProcessor>
    with $Provider<PhotoProcessor> {
  PhotoProcessorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoProcessorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoProcessorHash();

  @$internal
  @override
  $ProviderElement<PhotoProcessor> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoProcessor create(Ref ref) {
    return photoProcessor(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoProcessor value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoProcessor>(value),
    );
  }
}

String _$photoProcessorHash() => r'76d9e387372325731c360d493fc15e369a234803';

@ProviderFor(galleryRepository)
final galleryRepositoryProvider = GalleryRepositoryProvider._();

final class GalleryRepositoryProvider
    extends
        $FunctionalProvider<
          GalleryRepository,
          GalleryRepository,
          GalleryRepository
        >
    with $Provider<GalleryRepository> {
  GalleryRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'galleryRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$galleryRepositoryHash();

  @$internal
  @override
  $ProviderElement<GalleryRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GalleryRepository create(Ref ref) {
    return galleryRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GalleryRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GalleryRepository>(value),
    );
  }
}

String _$galleryRepositoryHash() => r'9bb907296177590a6bf78eef931f3a159fcf78dc';

@ProviderFor(shutterSoundPlayer)
final shutterSoundPlayerProvider = ShutterSoundPlayerProvider._();

final class ShutterSoundPlayerProvider
    extends
        $FunctionalProvider<
          ShutterSoundPlayer,
          ShutterSoundPlayer,
          ShutterSoundPlayer
        >
    with $Provider<ShutterSoundPlayer> {
  ShutterSoundPlayerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shutterSoundPlayerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shutterSoundPlayerHash();

  @$internal
  @override
  $ProviderElement<ShutterSoundPlayer> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ShutterSoundPlayer create(Ref ref) {
    return shutterSoundPlayer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ShutterSoundPlayer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ShutterSoundPlayer>(value),
    );
  }
}

String _$shutterSoundPlayerHash() =>
    r'725657d5c4b7e902656f7682d47a823515021508';

/// Si se estampa la fecha en las fotos.

@ProviderFor(DateStampEnabled)
final dateStampEnabledProvider = DateStampEnabledProvider._();

/// Si se estampa la fecha en las fotos.
final class DateStampEnabledProvider
    extends $NotifierProvider<DateStampEnabled, bool> {
  /// Si se estampa la fecha en las fotos.
  DateStampEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dateStampEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dateStampEnabledHash();

  @$internal
  @override
  DateStampEnabled create() => DateStampEnabled();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$dateStampEnabledHash() => r'364be9a5fbbbff5124a446f0ff8cfccee176aad2';

/// Si se estampa la fecha en las fotos.

abstract class _$DateStampEnabled extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// procesado y el guardado de la versión con filtro siguen en segundo plano.

@ProviderFor(Capture)
final captureProvider = CaptureProvider._();

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// procesado y el guardado de la versión con filtro siguen en segundo plano.
final class CaptureProvider extends $NotifierProvider<Capture, CapturedPhoto?> {
  /// Última foto sacada. [takePhoto] vuelve apenas está el original; el
  /// procesado y el guardado de la versión con filtro siguen en segundo plano.
  CaptureProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'captureProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$captureHash();

  @$internal
  @override
  Capture create() => Capture();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CapturedPhoto? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CapturedPhoto?>(value),
    );
  }
}

String _$captureHash() => r'e313bc8f017143e5280da21e5c44744ba1a42152';

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// procesado y el guardado de la versión con filtro siguen en segundo plano.

abstract class _$Capture extends $Notifier<CapturedPhoto?> {
  CapturedPhoto? build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CapturedPhoto?, CapturedPhoto?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CapturedPhoto?, CapturedPhoto?>,
              CapturedPhoto?,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
