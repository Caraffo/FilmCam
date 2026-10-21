import 'package:shared_preferences/shared_preferences.dart';

import 'app_setting.dart';

/// Preferencias del usuario guardadas en el dispositivo. Se cargan una vez
/// al abrir la app, así la cámara arranca con lo último que se eligió.
class SettingsRepository {
  SettingsRepository(this._prefs);

  static Future<SettingsRepository> load() async => SettingsRepository(
    await SharedPreferencesWithCache.create(
      cacheOptions: const SharedPreferencesWithCacheOptions(),
    ),
  );

  final SharedPreferencesWithCache _prefs;

  bool getBool(AppSetting setting) =>
      _prefs.getBool(setting.key) ?? setting.defaultValue;

  Future<void> setBool(AppSetting setting, bool value) =>
      _prefs.setBool(setting.key, value);

  String? getChoice(StoredChoice choice) => _prefs.getString(choice.key);

  Future<void> setChoice(StoredChoice choice, String value) =>
      _prefs.setString(choice.key, value);
}
