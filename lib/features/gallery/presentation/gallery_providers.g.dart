// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_providers.dart';

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

@ProviderFor(photoLibrary)
final photoLibraryProvider = PhotoLibraryProvider._();

final class PhotoLibraryProvider
    extends $FunctionalProvider<PhotoLibrary, PhotoLibrary, PhotoLibrary>
    with $Provider<PhotoLibrary> {
  PhotoLibraryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoLibraryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoLibraryHash();

  @$internal
  @override
  $ProviderElement<PhotoLibrary> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoLibrary create(Ref ref) {
    return photoLibrary(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoLibrary value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoLibrary>(value),
    );
  }
}

String _$photoLibraryHash() => r'fe602bbd86f528e1d14413a2641edaf53671c86d';

@ProviderFor(photoRecordStore)
final photoRecordStoreProvider = PhotoRecordStoreProvider._();

final class PhotoRecordStoreProvider
    extends
        $FunctionalProvider<
          PhotoRecordStore,
          PhotoRecordStore,
          PhotoRecordStore
        >
    with $Provider<PhotoRecordStore> {
  PhotoRecordStoreProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoRecordStoreProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoRecordStoreHash();

  @$internal
  @override
  $ProviderElement<PhotoRecordStore> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoRecordStore create(Ref ref) {
    return photoRecordStore(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoRecordStore value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoRecordStore>(value),
    );
  }
}

String _$photoRecordStoreHash() => r'c31d8df5227cf6b353e309ba08fe9703084610e1';

@ProviderFor(photoDeveloper)
final photoDeveloperProvider = PhotoDeveloperProvider._();

final class PhotoDeveloperProvider
    extends $FunctionalProvider<PhotoDeveloper, PhotoDeveloper, PhotoDeveloper>
    with $Provider<PhotoDeveloper> {
  PhotoDeveloperProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'photoDeveloperProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$photoDeveloperHash();

  @$internal
  @override
  $ProviderElement<PhotoDeveloper> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PhotoDeveloper create(Ref ref) {
    return photoDeveloper(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PhotoDeveloper value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PhotoDeveloper>(value),
    );
  }
}

String _$photoDeveloperHash() => r'6a9c2f0df4567146cbdb5217b76cc70e828475a6';

@ProviderFor(photoRecord)
final photoRecordProvider = PhotoRecordFamily._();

final class PhotoRecordProvider
    extends
        $FunctionalProvider<
          AsyncValue<PhotoRecord?>,
          PhotoRecord?,
          FutureOr<PhotoRecord?>
        >
    with $FutureModifier<PhotoRecord?>, $FutureProvider<PhotoRecord?> {
  PhotoRecordProvider._({
    required PhotoRecordFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'photoRecordProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$photoRecordHash();

  @override
  String toString() {
    return r'photoRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PhotoRecord?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PhotoRecord?> create(Ref ref) {
    final argument = this.argument as String;
    return photoRecord(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PhotoRecordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$photoRecordHash() => r'866fdc9fa3880b7e31088f80deb6c1fea3097673';

final class PhotoRecordFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PhotoRecord?>, String> {
  PhotoRecordFamily._()
    : super(
        retry: null,
        name: r'photoRecordProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  PhotoRecordProvider call(String key) =>
      PhotoRecordProvider._(argument: key, from: this);

  @override
  String toString() => r'photoRecordProvider';
}

@ProviderFor(originalBytes)
final originalBytesProvider = OriginalBytesFamily._();

final class OriginalBytesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Uint8List?>,
          Uint8List?,
          FutureOr<Uint8List?>
        >
    with $FutureModifier<Uint8List?>, $FutureProvider<Uint8List?> {
  OriginalBytesProvider._({
    required OriginalBytesFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'originalBytesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$originalBytesHash();

  @override
  String toString() {
    return r'originalBytesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Uint8List?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List?> create(Ref ref) {
    final argument = this.argument as String;
    return originalBytes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OriginalBytesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$originalBytesHash() => r'ad955a198e02c885a3e4aa56e301613f86cb4d74';

final class OriginalBytesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Uint8List?>, String> {
  OriginalBytesFamily._()
    : super(
        retry: null,
        name: r'originalBytesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OriginalBytesProvider call(String originalKey) =>
      OriginalBytesProvider._(argument: originalKey, from: this);

  @override
  String toString() => r'originalBytesProvider';
}

@ProviderFor(galleryPhotoBytes)
final galleryPhotoBytesProvider = GalleryPhotoBytesFamily._();

final class GalleryPhotoBytesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Uint8List>,
          Uint8List,
          FutureOr<Uint8List>
        >
    with $FutureModifier<Uint8List>, $FutureProvider<Uint8List> {
  GalleryPhotoBytesProvider._({
    required GalleryPhotoBytesFamily super.from,
    required GalleryPhoto super.argument,
  }) : super(
         retry: null,
         name: r'galleryPhotoBytesProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$galleryPhotoBytesHash();

  @override
  String toString() {
    return r'galleryPhotoBytesProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Uint8List> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List> create(Ref ref) {
    final argument = this.argument as GalleryPhoto;
    return galleryPhotoBytes(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GalleryPhotoBytesProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$galleryPhotoBytesHash() => r'4fef9852adc956a995c93dcdc3c3856a4b97a10e';

final class GalleryPhotoBytesFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Uint8List>, GalleryPhoto> {
  GalleryPhotoBytesFamily._()
    : super(
        retry: null,
        name: r'galleryPhotoBytesProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GalleryPhotoBytesProvider call(GalleryPhoto photo) =>
      GalleryPhotoBytesProvider._(argument: photo, from: this);

  @override
  String toString() => r'galleryPhotoBytesProvider';
}

@ProviderFor(galleryThumbnail)
final galleryThumbnailProvider = GalleryThumbnailFamily._();

final class GalleryThumbnailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Uint8List>,
          Uint8List,
          FutureOr<Uint8List>
        >
    with $FutureModifier<Uint8List>, $FutureProvider<Uint8List> {
  GalleryThumbnailProvider._({
    required GalleryThumbnailFamily super.from,
    required GalleryPhoto super.argument,
  }) : super(
         retry: null,
         name: r'galleryThumbnailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$galleryThumbnailHash();

  @override
  String toString() {
    return r'galleryThumbnailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Uint8List> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Uint8List> create(Ref ref) {
    final argument = this.argument as GalleryPhoto;
    return galleryThumbnail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is GalleryThumbnailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$galleryThumbnailHash() => r'f3ae38768297471cbaa3859595aaacd027e86a2e';

final class GalleryThumbnailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Uint8List>, GalleryPhoto> {
  GalleryThumbnailFamily._()
    : super(
        retry: null,
        name: r'galleryThumbnailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  GalleryThumbnailProvider call(GalleryPhoto photo) =>
      GalleryThumbnailProvider._(argument: photo, from: this);

  @override
  String toString() => r'galleryThumbnailProvider';
}

/// Fotos del álbum de FilmCam, de la más nueva a la más vieja.

@ProviderFor(GalleryPhotos)
final galleryPhotosProvider = GalleryPhotosProvider._();

/// Fotos del álbum de FilmCam, de la más nueva a la más vieja.
final class GalleryPhotosProvider
    extends $AsyncNotifierProvider<GalleryPhotos, List<GalleryPhoto>> {
  /// Fotos del álbum de FilmCam, de la más nueva a la más vieja.
  GalleryPhotosProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'galleryPhotosProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$galleryPhotosHash();

  @$internal
  @override
  GalleryPhotos create() => GalleryPhotos();
}

String _$galleryPhotosHash() => r'752a32c4d1427717354fbbc7906ace9cd45009dd';

/// Fotos del álbum de FilmCam, de la más nueva a la más vieja.

abstract class _$GalleryPhotos extends $AsyncNotifier<List<GalleryPhoto>> {
  FutureOr<List<GalleryPhoto>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<GalleryPhoto>>, List<GalleryPhoto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<GalleryPhoto>>, List<GalleryPhoto>>,
              AsyncValue<List<GalleryPhoto>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
