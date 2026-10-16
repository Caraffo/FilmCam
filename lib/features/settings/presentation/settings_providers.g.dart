// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  SettingsRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsRepositoryHash();

  @$internal
  @override
  $ProviderElement<SettingsRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SettingsRepository create(Ref ref) {
    return settingsRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsRepository>(value),
    );
  }
}

String _$settingsRepositoryHash() =>
    r'eea72d781f43f01df10d1b5f764e81a9894afdfe';

/// Si suena el obturador al sacar una foto. Activado por defecto.

@ProviderFor(ShutterSoundEnabled)
final shutterSoundEnabledProvider = ShutterSoundEnabledProvider._();

/// Si suena el obturador al sacar una foto. Activado por defecto.
final class ShutterSoundEnabledProvider
    extends $AsyncNotifierProvider<ShutterSoundEnabled, bool> {
  /// Si suena el obturador al sacar una foto. Activado por defecto.
  ShutterSoundEnabledProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'shutterSoundEnabledProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$shutterSoundEnabledHash();

  @$internal
  @override
  ShutterSoundEnabled create() => ShutterSoundEnabled();
}

String _$shutterSoundEnabledHash() =>
    r'f4e7cd5777fbd24fc8e381bd9abd9a33c32711a2';

/// Si suena el obturador al sacar una foto. Activado por defecto.

abstract class _$ShutterSoundEnabled extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool>, bool>,
              AsyncValue<bool>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
