import 'package:shared_preferences/shared_preferences.dart';

import 'app_setting.dart';

/// Preferencias del usuario guardadas en el dispositivo.
class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferencesAsync _prefs;

  Future<bool> load(AppSetting setting) async =>
      await _prefs.getBool(setting.key) ?? setting.defaultValue;

  Future<void> save(AppSetting setting, bool value) =>
      _prefs.setBool(setting.key, value);
}
