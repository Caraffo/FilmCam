import 'package:shared_preferences/shared_preferences.dart';

/// Preferencias del usuario guardadas en el dispositivo.
class SettingsRepository {
  SettingsRepository(this._prefs);

  static const _shutterSoundKey = 'shutter_sound_enabled';

  final SharedPreferencesAsync _prefs;

  Future<bool> loadShutterSoundEnabled() async =>
      await _prefs.getBool(_shutterSoundKey) ?? true;

  Future<void> saveShutterSoundEnabled(bool enabled) =>
      _prefs.setBool(_shutterSoundKey, enabled);
}
