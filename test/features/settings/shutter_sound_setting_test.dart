import 'package:filmcam/features/settings/data/settings_repository.dart';
import 'package:filmcam/features/settings/presentation/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSettingsRepository implements SettingsRepository {
  _FakeSettingsRepository(this.stored);

  bool stored;

  @override
  Future<bool> loadShutterSoundEnabled() async => stored;

  @override
  Future<void> saveShutterSoundEnabled(bool enabled) async => stored = enabled;
}

void main() {
  test(
    'el sonido arranca con lo guardado y al cambiarlo se persiste',
    () async {
      final repository = _FakeSettingsRepository(true);
      final container = ProviderContainer(
        overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
      );
      addTearDown(container.dispose);

      expect(await container.read(shutterSoundEnabledProvider.future), isTrue);
      await container.read(shutterSoundEnabledProvider.notifier).toggle();

      expect(container.read(shutterSoundEnabledProvider).value, isFalse);
      expect(repository.stored, isFalse);
    },
  );
}
