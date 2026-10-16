import 'package:filmcam/features/film/data/builtin_presets.dart';
import 'package:filmcam/features/film/data/film_preset.dart';
import 'package:filmcam/features/film/data/preset_repository.dart';
import 'package:filmcam/features/film/presentation/film_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _InMemoryPresetRepository implements PresetRepository {
  List<FilmPreset> stored = [];

  @override
  Future<List<FilmPreset>> loadUserPresets() async => stored;

  @override
  Future<void> saveUserPresets(List<FilmPreset> presets) async =>
      stored = presets;
}

void main() {
  late _InMemoryPresetRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _InMemoryPresetRepository();
    container = ProviderContainer(
      overrides: [presetRepositoryProvider.overrideWithValue(repository)],
    );
  });

  tearDown(() => container.dispose());

  test('el preset sobrevive a JSON ida y vuelta', () {
    final preset = kBuiltInPresets.firstWhere((p) => p.lutAsset != null);
    expect(FilmPreset.fromJson(preset.toJson()), preset);
  });

  test('los ids de los presets de fábrica son únicos', () {
    final ids = kBuiltInPresets.map((p) => p.id).toSet();
    expect(ids.length, kBuiltInPresets.length);
    expect(ids, contains(kDefaultPresetId));
  });

  test('guardar, reemplazar y borrar presets de usuario', () async {
    final notifier = container.read(presetsProvider.notifier);
    await container.read(presetsProvider.future);

    const mine = FilmPreset(id: 'user_1', name: 'Mío', grain: 0.1);
    await notifier.save(mine);
    expect(repository.stored, [mine]);

    await notifier.save(mine.copyWith(name: 'Renombrado'));
    expect(repository.stored.single.name, 'Renombrado');
    expect(
      container.read(presetsProvider).value!.length,
      kBuiltInPresets.length + 1,
    );

    await notifier.delete('user_1');
    expect(repository.stored, isEmpty);
  });

  test('el balance rápido se resetea al del preset elegido', () {
    final look = container.read(activeLookProvider.notifier);
    final selected = container.read(activeLookProvider);
    look.setWhiteBalance(3000, 10);
    expect(container.read(activeLookProvider).temperatureK, 3000);
    look.resetWhiteBalance();
    expect(
      container.read(activeLookProvider).temperatureK,
      selected.temperatureK,
    );
    expect(container.read(activeLookProvider).tint, selected.tint);
  });
}
