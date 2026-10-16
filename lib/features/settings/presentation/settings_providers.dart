import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/app_setting.dart';
import '../data/settings_repository.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepository(SharedPreferencesAsync());

/// Valor de una preferencia; se guarda al cambiarla.
@Riverpod(keepAlive: true)
class Setting extends _$Setting {
  @override
  Future<bool> build(AppSetting setting) =>
      ref.read(settingsRepositoryProvider).load(setting);

  /// Valor actual, o el por defecto mientras carga.
  bool get current => state.value ?? setting.defaultValue;

  Future<void> set(bool value) async {
    state = AsyncData(value);
    await ref.read(settingsRepositoryProvider).save(setting, value);
  }
}
