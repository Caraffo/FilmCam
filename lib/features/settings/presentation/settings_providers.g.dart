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

/// Valor de una preferencia; se guarda al cambiarla.

@ProviderFor(Setting)
final settingProvider = SettingFamily._();

/// Valor de una preferencia; se guarda al cambiarla.
final class SettingProvider extends $AsyncNotifierProvider<Setting, bool> {
  /// Valor de una preferencia; se guarda al cambiarla.
  SettingProvider._({
    required SettingFamily super.from,
    required AppSetting super.argument,
  }) : super(
         retry: null,
         name: r'settingProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$settingHash();

  @override
  String toString() {
    return r'settingProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  Setting create() => Setting();

  @override
  bool operator ==(Object other) {
    return other is SettingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$settingHash() => r'96bfb62f15b27b949b22a04e8896c4c7f16ff8c9';

/// Valor de una preferencia; se guarda al cambiarla.

final class SettingFamily extends $Family
    with
        $ClassFamilyOverride<
          Setting,
          AsyncValue<bool>,
          bool,
          FutureOr<bool>,
          AppSetting
        > {
  SettingFamily._()
    : super(
        retry: null,
        name: r'settingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Valor de una preferencia; se guarda al cambiarla.

  SettingProvider call(AppSetting setting) =>
      SettingProvider._(argument: setting, from: this);

  @override
  String toString() => r'settingProvider';
}

/// Valor de una preferencia; se guarda al cambiarla.

abstract class _$Setting extends $AsyncNotifier<bool> {
  late final _$args = ref.$arg as AppSetting;
  AppSetting get setting => _$args;

  FutureOr<bool> build(AppSetting setting);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
