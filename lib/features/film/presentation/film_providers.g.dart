// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'film_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(filmProgram)
final filmProgramProvider = FilmProgramProvider._();

final class FilmProgramProvider
    extends
        $FunctionalProvider<
          AsyncValue<ui.FragmentProgram>,
          ui.FragmentProgram,
          FutureOr<ui.FragmentProgram>
        >
    with
        $FutureModifier<ui.FragmentProgram>,
        $FutureProvider<ui.FragmentProgram> {
  FilmProgramProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filmProgramProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filmProgramHash();

  @$internal
  @override
  $FutureProviderElement<ui.FragmentProgram> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<ui.FragmentProgram> create(Ref ref) {
    return filmProgram(ref);
  }
}

String _$filmProgramHash() => r'3f1a42c3af00abda77d020bcedde8743c0486079';

/// Imagen del LUT del preset; sin LUT se usa el identidad.

@ProviderFor(lutImage)
final lutImageProvider = LutImageFamily._();

/// Imagen del LUT del preset; sin LUT se usa el identidad.

final class LutImageProvider
    extends
        $FunctionalProvider<AsyncValue<ui.Image>, ui.Image, FutureOr<ui.Image>>
    with $FutureModifier<ui.Image>, $FutureProvider<ui.Image> {
  /// Imagen del LUT del preset; sin LUT se usa el identidad.
  LutImageProvider._({
    required LutImageFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'lutImageProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$lutImageHash();

  @override
  String toString() {
    return r'lutImageProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<ui.Image> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<ui.Image> create(Ref ref) {
    final argument = this.argument as String?;
    return lutImage(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is LutImageProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$lutImageHash() => r'58b75cf09a6fd58717afd456e86289486ded053b';

/// Imagen del LUT del preset; sin LUT se usa el identidad.

final class LutImageFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<ui.Image>, String?> {
  LutImageFamily._()
    : super(
        retry: null,
        name: r'lutImageProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Imagen del LUT del preset; sin LUT se usa el identidad.

  LutImageProvider call(String? asset) =>
      LutImageProvider._(argument: asset, from: this);

  @override
  String toString() => r'lutImageProvider';
}

@ProviderFor(presetRepository)
final presetRepositoryProvider = PresetRepositoryProvider._();

final class PresetRepositoryProvider
    extends
        $FunctionalProvider<
          PresetRepository,
          PresetRepository,
          PresetRepository
        >
    with $Provider<PresetRepository> {
  PresetRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'presetRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$presetRepositoryHash();

  @$internal
  @override
  $ProviderElement<PresetRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PresetRepository create(Ref ref) {
    return presetRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PresetRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PresetRepository>(value),
    );
  }
}

String _$presetRepositoryHash() => r'53a2e1920a8be2c5e70cae30b9233294a1dc4fba';

/// Presets visibles: los de fábrica que no se borraron, seguidos de los
/// creados por el usuario.

@ProviderFor(Presets)
final presetsProvider = PresetsProvider._();

/// Presets visibles: los de fábrica que no se borraron, seguidos de los
/// creados por el usuario.
final class PresetsProvider
    extends $AsyncNotifierProvider<Presets, List<FilmPreset>> {
  /// Presets visibles: los de fábrica que no se borraron, seguidos de los
  /// creados por el usuario.
  PresetsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'presetsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$presetsHash();

  @$internal
  @override
  Presets create() => Presets();
}

String _$presetsHash() => r'7d0b144898c06d18ea88cc6f4ebd25ae75ef526e';

/// Presets visibles: los de fábrica que no se borraron, seguidos de los
/// creados por el usuario.

abstract class _$Presets extends $AsyncNotifier<List<FilmPreset>> {
  FutureOr<List<FilmPreset>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<FilmPreset>>, List<FilmPreset>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<FilmPreset>>, List<FilmPreset>>,
              AsyncValue<List<FilmPreset>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Look activo en la cámara: el preset elegido más los ajustes rápidos
/// (por ejemplo, el balance de blancos) que se hagan encima.

@ProviderFor(ActiveLook)
final activeLookProvider = ActiveLookProvider._();

/// Look activo en la cámara: el preset elegido más los ajustes rápidos
/// (por ejemplo, el balance de blancos) que se hagan encima.
final class ActiveLookProvider
    extends $NotifierProvider<ActiveLook, FilmPreset> {
  /// Look activo en la cámara: el preset elegido más los ajustes rápidos
  /// (por ejemplo, el balance de blancos) que se hagan encima.
  ActiveLookProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'activeLookProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$activeLookHash();

  @$internal
  @override
  ActiveLook create() => ActiveLook();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FilmPreset value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FilmPreset>(value),
    );
  }
}

String _$activeLookHash() => r'21afc511a817d12effb38b18a03489c05ee7a656';

/// Look activo en la cámara: el preset elegido más los ajustes rápidos
/// (por ejemplo, el balance de blancos) que se hagan encima.

abstract class _$ActiveLook extends $Notifier<FilmPreset> {
  FilmPreset build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<FilmPreset, FilmPreset>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<FilmPreset, FilmPreset>,
              FilmPreset,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
