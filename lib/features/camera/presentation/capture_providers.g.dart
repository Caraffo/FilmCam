// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'capture_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

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

@ProviderFor(CaptureAspectSetting)
final captureAspectSettingProvider = CaptureAspectSettingProvider._();

final class CaptureAspectSettingProvider
    extends $NotifierProvider<CaptureAspectSetting, CaptureAspect> {
  CaptureAspectSettingProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'captureAspectSettingProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$captureAspectSettingHash();

  @$internal
  @override
  CaptureAspectSetting create() => CaptureAspectSetting();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CaptureAspect value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CaptureAspect>(value),
    );
  }
}

String _$captureAspectSettingHash() =>
    r'1fc7f103ec9f039bcdc811bca91515c3004c4ea4';

abstract class _$CaptureAspectSetting extends $Notifier<CaptureAspect> {
  CaptureAspect build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<CaptureAspect, CaptureAspect>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CaptureAspect, CaptureAspect>,
              CaptureAspect,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// recorte, el revelado y el guardado siguen en segundo plano.

@ProviderFor(Capture)
final captureProvider = CaptureProvider._();

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// recorte, el revelado y el guardado siguen en segundo plano.
final class CaptureProvider extends $NotifierProvider<Capture, CapturedPhoto?> {
  /// Última foto sacada. [takePhoto] vuelve apenas está el original; el
  /// recorte, el revelado y el guardado siguen en segundo plano.
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

String _$captureHash() => r'ca40e44dff5f0fd2d4ed7a882ed2b3fc1a25f0c2';

/// Última foto sacada. [takePhoto] vuelve apenas está el original; el
/// recorte, el revelado y el guardado siguen en segundo plano.

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
