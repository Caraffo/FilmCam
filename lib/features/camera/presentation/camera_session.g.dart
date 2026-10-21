// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_session.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Cámara abierta y sus ajustes. Se cierra con [close] cuando la app pasa a
/// segundo plano y se reabre invalidando el provider.

@ProviderFor(CameraSession)
final cameraSessionProvider = CameraSessionProvider._();

/// Cámara abierta y sus ajustes. Se cierra con [close] cuando la app pasa a
/// segundo plano y se reabre invalidando el provider.
final class CameraSessionProvider
    extends $AsyncNotifierProvider<CameraSession, CameraState> {
  /// Cámara abierta y sus ajustes. Se cierra con [close] cuando la app pasa a
  /// segundo plano y se reabre invalidando el provider.
  CameraSessionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cameraSessionProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cameraSessionHash();

  @$internal
  @override
  CameraSession create() => CameraSession();
}

String _$cameraSessionHash() => r'e704f8ec7f1308a347d21389bef96fb846e26351';

/// Cámara abierta y sus ajustes. Se cierra con [close] cuando la app pasa a
/// segundo plano y se reabre invalidando el provider.

abstract class _$CameraSession extends $AsyncNotifier<CameraState> {
  FutureOr<CameraState> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CameraState>, CameraState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CameraState>, CameraState>,
              AsyncValue<CameraState>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
