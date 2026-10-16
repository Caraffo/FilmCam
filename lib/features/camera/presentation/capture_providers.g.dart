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

/// Última foto sacada (ya procesada) y si hay una procesándose.

@ProviderFor(Capture)
final captureProvider = CaptureProvider._();

/// Última foto sacada (ya procesada) y si hay una procesándose.
final class CaptureProvider extends $NotifierProvider<Capture, CaptureState> {
  /// Última foto sacada (ya procesada) y si hay una procesándose.
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
  Override overrideWithValue(CaptureState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CaptureState>(value),
    );
  }
}

String _$captureHash() => r'0d010e97977c71eda209bee26af6c28698bee360';

/// Última foto sacada (ya procesada) y si hay una procesándose.

abstract class _$Capture extends $Notifier<CaptureState> {
  CaptureState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CaptureState, CaptureState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CaptureState, CaptureState>,
              CaptureState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
