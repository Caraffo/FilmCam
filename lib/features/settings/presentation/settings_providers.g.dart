// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Se inyecta en `main` ya cargado (ver [SettingsRepository.load]).

@ProviderFor(settingsRepository)
final settingsRepositoryProvider = SettingsRepositoryProvider._();

/// Se inyecta en `main` ya cargado (ver [SettingsRepository.load]).

final class SettingsRepositoryProvider
    extends
        $FunctionalProvider<
          SettingsRepository,
          SettingsRepository,
          SettingsRepository
        >
    with $Provider<SettingsRepository> {
  /// Se inyecta en `main` ya cargado (ver [SettingsRepository.load]).
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
    r'a2f4d412fedefc771a942effcff1108ed1135982';

/// Valor de una preferencia de sí/no; se guarda al cambiarla.

@ProviderFor(Setting)
final settingProvider = SettingFamily._();

/// Valor de una preferencia de sí/no; se guarda al cambiarla.
final class SettingProvider extends $NotifierProvider<Setting, bool> {
  /// Valor de una preferencia de sí/no; se guarda al cambiarla.
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

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SettingProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$settingHash() => r'8d0fb7717e066ca6822d4c2350e2662c44590646';

/// Valor de una preferencia de sí/no; se guarda al cambiarla.

final class SettingFamily extends $Family
    with $ClassFamilyOverride<Setting, bool, bool, bool, AppSetting> {
  SettingFamily._()
    : super(
        retry: null,
        name: r'settingProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Valor de una preferencia de sí/no; se guarda al cambiarla.

  SettingProvider call(AppSetting setting) =>
      SettingProvider._(argument: setting, from: this);

  @override
  String toString() => r'settingProvider';
}

/// Valor de una preferencia de sí/no; se guarda al cambiarla.

abstract class _$Setting extends $Notifier<bool> {
  late final _$args = ref.$arg as AppSetting;
  AppSetting get setting => _$args;

  bool build(AppSetting setting);
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
    return element.handleCreate(ref, () => build(_$args));
  }
}
