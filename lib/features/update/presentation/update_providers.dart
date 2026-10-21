import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/update_repository.dart';

part 'update_providers.g.dart';

enum UpdateStatus { idle, checking, upToDate, available, downloading, failed }

class UpdateState {
  const UpdateState({
    this.status = UpdateStatus.idle,
    this.remote,
    this.installedBuild,
    this.progress = 0,
    this.error,
  });

  final UpdateStatus status;
  final RemoteBuild? remote;
  final int? installedBuild;
  final double progress;
  final Object? error;

  UpdateState copyWith({
    UpdateStatus? status,
    RemoteBuild? remote,
    int? installedBuild,
    double? progress,
    Object? error,
  }) => UpdateState(
    status: status ?? this.status,
    remote: remote ?? this.remote,
    installedBuild: installedBuild ?? this.installedBuild,
    progress: progress ?? this.progress,
    error: error,
  );
}

@Riverpod(keepAlive: true)
UpdateRepository updateRepository(Ref ref) => UpdateRepository();

/// Si hay una versión nueva de la app publicada en GitHub, y su instalación.
@Riverpod(keepAlive: true)
class AppUpdate extends _$AppUpdate {
  @override
  UpdateState build() => const UpdateState();

  UpdateRepository get _repository => ref.read(updateRepositoryProvider);

  /// Busca si hay una versión más nueva que la instalada.
  Future<void> check() async {
    if (state.status == UpdateStatus.checking ||
        state.status == UpdateStatus.downloading) {
      return;
    }
    state = state.copyWith(status: UpdateStatus.checking);
    try {
      final installed = await _repository.installedBuildNumber();
      final remote = await _repository.fetchLatest();
      state = state.copyWith(
        installedBuild: installed,
        remote: remote,
        status: remote.buildNumber > installed
            ? UpdateStatus.available
            : UpdateStatus.upToDate,
      );
    } catch (error) {
      state = state.copyWith(status: UpdateStatus.failed, error: error);
    }
  }

  /// Baja la versión nueva y abre el instalador de Android.
  Future<void> install() async {
    state = state.copyWith(status: UpdateStatus.downloading, progress: 0);
    try {
      final apk = await _repository.download(
        onProgress: (p) => state = state.copyWith(progress: p),
      );
      await _repository.install(apk);
      state = state.copyWith(status: UpdateStatus.available);
    } catch (error) {
      state = state.copyWith(status: UpdateStatus.failed, error: error);
      rethrow;
    }
  }
}
