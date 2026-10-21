// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(updateRepository)
final updateRepositoryProvider = UpdateRepositoryProvider._();

final class UpdateRepositoryProvider
    extends
        $FunctionalProvider<
          UpdateRepository,
          UpdateRepository,
          UpdateRepository
        >
    with $Provider<UpdateRepository> {
  UpdateRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'updateRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$updateRepositoryHash();

  @$internal
  @override
  $ProviderElement<UpdateRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UpdateRepository create(Ref ref) {
    return updateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateRepository>(value),
    );
  }
}

String _$updateRepositoryHash() => r'6a4794a35d7d1f22101f86401cb153e0b5b24431';

/// Si hay una versión nueva de la app publicada en GitHub, y su instalación.

@ProviderFor(AppUpdate)
final appUpdateProvider = AppUpdateProvider._();

/// Si hay una versión nueva de la app publicada en GitHub, y su instalación.
final class AppUpdateProvider
    extends $NotifierProvider<AppUpdate, UpdateState> {
  /// Si hay una versión nueva de la app publicada en GitHub, y su instalación.
  AppUpdateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appUpdateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appUpdateHash();

  @$internal
  @override
  AppUpdate create() => AppUpdate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UpdateState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UpdateState>(value),
    );
  }
}

String _$appUpdateHash() => r'fdada7db420443ee70b2dcdeb4610e2c6c153667';

/// Si hay una versión nueva de la app publicada en GitHub, y su instalación.

abstract class _$AppUpdate extends $Notifier<UpdateState> {
  UpdateState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<UpdateState, UpdateState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UpdateState, UpdateState>,
              UpdateState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
