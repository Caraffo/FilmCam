import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/settings_repository.dart';

part 'settings_providers.g.dart';

@Riverpod(keepAlive: true)
SettingsRepository settingsRepository(Ref ref) =>
    SettingsRepository(SharedPreferencesAsync());

/// Si suena el obturador al sacar una foto. Activado por defecto.
@Riverpod(keepAlive: true)
class ShutterSoundEnabled extends _$ShutterSoundEnabled {
  @override
  Future<bool> build() =>
      ref.read(settingsRepositoryProvider).loadShutterSoundEnabled();

  Future<void> toggle() async {
    final enabled = !(state.value ?? true);
    state = AsyncData(enabled);
    await ref.read(settingsRepositoryProvider).saveShutterSoundEnabled(enabled);
  }
}
