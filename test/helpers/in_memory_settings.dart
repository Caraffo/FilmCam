import 'package:filmcam/features/settings/data/app_setting.dart';
import 'package:filmcam/features/settings/data/settings_repository.dart';

/// Preferencias en memoria para tests.
class InMemorySettingsRepository implements SettingsRepository {
  final bools = <AppSetting, bool>{};
  final choices = <StoredChoice, String>{};

  @override
  bool getBool(AppSetting setting) => bools[setting] ?? setting.defaultValue;

  @override
  Future<void> setBool(AppSetting setting, bool value) async =>
      bools[setting] = value;

  @override
  String? getChoice(StoredChoice choice) => choices[choice];

  @override
  Future<void> setChoice(StoredChoice choice, String value) async =>
      choices[choice] = value;
}
