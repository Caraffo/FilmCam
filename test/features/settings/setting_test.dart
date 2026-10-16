import 'package:filmcam/features/settings/data/app_setting.dart';
import 'package:filmcam/features/settings/data/settings_repository.dart';
import 'package:filmcam/features/settings/presentation/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemorySettingsRepository implements SettingsRepository {
  final stored = <AppSetting, bool>{};

  @override
  Future<bool> load(AppSetting setting) async =>
      stored[setting] ?? setting.defaultValue;

  @override
  Future<void> save(AppSetting setting, bool value) async =>
      stored[setting] = value;
}

void main() {
  late _InMemorySettingsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _InMemorySettingsRepository();
    container = ProviderContainer(
      overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
    );
  });

  tearDown(() => container.dispose());

  test('arranca con los valores por defecto', () async {
    expect(
      await container.read(settingProvider(AppSetting.shutterSound).future),
      isTrue,
    );
    expect(
      await container.read(
        settingProvider(AppSetting.openPhotoAfterCapture).future,
      ),
      isFalse,
    );
  });

  test('al cambiar una preferencia se guarda', () async {
    final provider = settingProvider(AppSetting.shutterSound);
    await container.read(provider.future);
    await container.read(provider.notifier).set(false);

    expect(container.read(provider).value, isFalse);
    expect(repository.stored[AppSetting.shutterSound], isFalse);
  });
}
