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

/// Relación de aspecto de las fotos; se recuerda entre sesiones.

@ProviderFor(CaptureAspectSetting)
final captureAspectSettingProvider = CaptureAspectSettingProvider._();

/// Relación de aspecto de las fotos; se recuerda entre sesiones.
final class CaptureAspectSettingProvider
    extends $NotifierProvider<CaptureAspectSetting, CaptureAspect> {
  /// Relación de aspecto de las fotos; se recuerda entre sesiones.
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
    r'4727ab7db93c970d0d87f38f4fa08541d9f9124b';

/// Relación de aspecto de las fotos; se recuerda entre sesiones.

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

/// Fotos sacadas en esta sesión que todavía hacen falta, de la más nueva a
/// la más vieja: la última (para la miniatura) y las que se están revelando
/// o fallaron. [takePhoto] vuelve apenas está el original; el revelado sigue
/// en segundo plano, de a una foto por vez para no agotar la memoria al
/// sacar varias seguidas.

@ProviderFor(Capture)
final captureProvider = CaptureProvider._();

/// Fotos sacadas en esta sesión que todavía hacen falta, de la más nueva a
/// la más vieja: la última (para la miniatura) y las que se están revelando
/// o fallaron. [takePhoto] vuelve apenas está el original; el revelado sigue
/// en segundo plano, de a una foto por vez para no agotar la memoria al
/// sacar varias seguidas.
final class CaptureProvider
    extends $NotifierProvider<Capture, List<CapturedPhoto>> {
  /// Fotos sacadas en esta sesión que todavía hacen falta, de la más nueva a
  /// la más vieja: la última (para la miniatura) y las que se están revelando
  /// o fallaron. [takePhoto] vuelve apenas está el original; el revelado sigue
  /// en segundo plano, de a una foto por vez para no agotar la memoria al
  /// sacar varias seguidas.
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
  Override overrideWithValue(List<CapturedPhoto> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CapturedPhoto>>(value),
    );
  }
}

String _$captureHash() => r'a97902579e3f83e79c870f745e491795060ff66e';

/// Fotos sacadas en esta sesión que todavía hacen falta, de la más nueva a
/// la más vieja: la última (para la miniatura) y las que se están revelando
/// o fallaron. [takePhoto] vuelve apenas está el original; el revelado sigue
/// en segundo plano, de a una foto por vez para no agotar la memoria al
/// sacar varias seguidas.

abstract class _$Capture extends $Notifier<List<CapturedPhoto>> {
  List<CapturedPhoto> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<CapturedPhoto>, List<CapturedPhoto>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CapturedPhoto>, List<CapturedPhoto>>,
              List<CapturedPhoto>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
