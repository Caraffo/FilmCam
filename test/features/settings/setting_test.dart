import 'package:filmcam/features/camera/data/capture_aspect.dart';
import 'package:filmcam/features/camera/presentation/capture_providers.dart';
import 'package:filmcam/features/film/data/builtin_presets.dart';
import 'package:filmcam/features/film/presentation/film_providers.dart';
import 'package:filmcam/features/settings/data/app_setting.dart';
import 'package:filmcam/features/settings/presentation/settings_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/in_memory_settings.dart';

void main() {
  late InMemorySettingsRepository repository;

  ProviderContainer newContainer() {
    final container = ProviderContainer(
      overrides: [settingsRepositoryProvider.overrideWithValue(repository)],
    );
    addTearDown(container.dispose);
    return container;
  }

  setUp(() => repository = InMemorySettingsRepository());

  test('arranca con los valores por defecto', () {
    final container = newContainer();
    expect(container.read(settingProvider(AppSetting.shutterSound)), isTrue);
    expect(container.read(settingProvider(AppSetting.dateStamp)), isFalse);
    expect(container.read(captureAspectSettingProvider), CaptureAspect.native);
  });

  test('las preferencias se recuerdan en la sesión siguiente', () async {
    final first = newContainer();
    await first.read(settingProvider(AppSetting.dateStamp).notifier).toggle();
    await first
        .read(captureAspectSettingProvider.notifier)
        .select(CaptureAspect.square);
    final silver = kBuiltInPresets.firstWhere((p) => p.id == 'silver_400');
    first.read(activeLookProvider.notifier).select(silver);

    final next = newContainer();
    expect(next.read(settingProvider(AppSetting.dateStamp)), isTrue);
    expect(next.read(captureAspectSettingProvider), CaptureAspect.square);
    expect(next.read(activeLookProvider).id, 'silver_400');
  });
}
