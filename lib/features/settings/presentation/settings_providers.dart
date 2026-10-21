import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/app_setting.dart';
import '../data/settings_repository.dart';

part 'settings_providers.g.dart';

/// Se inyecta en `main` ya cargado (ver [SettingsRepository.load]).
@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) => throw UnimplementedError(
  'settingsRepositoryProvider se sobrescribe en main',
);

/// Valor de una preferencia de sí/no; se guarda al cambiarla.
@Riverpod(keepAlive: true)
class Setting extends _$Setting {
  @override
  bool build(AppSetting setting) =>
      ref.read(settingsRepositoryProvider).getBool(setting);

  Future<void> set(bool value) async {
    state = value;
    await ref.read(settingsRepositoryProvider).setBool(setting, value);
  }

  Future<void> toggle() => set(!state);
}
