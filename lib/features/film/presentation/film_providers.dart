import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' show WidgetRef;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/builtin_presets.dart';
import '../data/film_preset.dart';
import '../data/preset_repository.dart';
import '../../settings/data/app_setting.dart';
import '../../settings/presentation/settings_providers.dart';

part 'film_providers.g.dart';

const _filmShaderAsset = 'shaders/film.frag';

@Riverpod(keepAlive: true)
Future<ui.FragmentProgram> filmProgram(Ref ref) =>
    ui.FragmentProgram.fromAsset(_filmShaderAsset);

/// Imagen del LUT del preset; sin LUT se usa el identidad.
@Riverpod(keepAlive: true)
Future<ui.Image> lutImage(Ref ref, String? asset) async {
  final data = await rootBundle.load(asset ?? LutAssets.identity);
  final codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
  final frame = await codec.getNextFrame();
  return frame.image;
}

@Riverpod(keepAlive: true)
PresetRepository presetRepository(Ref ref) => PresetRepository();

/// Presets visibles: los de fábrica que no se borraron, seguidos de los
/// creados por el usuario.
@Riverpod(keepAlive: true)
class Presets extends _$Presets {
  List<FilmPreset> _userPresets = [];
  Set<String> _hiddenIds = {};

  /// Si hay presets de fábrica borrados que se pueden restaurar.
  bool get hasHiddenBuiltIns => _hiddenIds.isNotEmpty;

  @override
  Future<List<FilmPreset>> build() async {
    final repository = ref.read(presetRepositoryProvider);
    _userPresets = await repository.loadUserPresets();
    _hiddenIds = await repository.loadHiddenBuiltInIds();
    return _visible();
  }

  List<FilmPreset> _visible() => [
    for (final preset in kBuiltInPresets)
      if (!_hiddenIds.contains(preset.id)) preset,
    ..._userPresets,
  ];

  /// Crea o reemplaza un preset de usuario.
  Future<void> save(FilmPreset preset) async {
    final index = _userPresets.indexWhere((p) => p.id == preset.id);
    _userPresets = [..._userPresets];
    if (index == -1) {
      _userPresets.add(preset);
    } else {
      _userPresets[index] = preset;
    }
    await ref.read(presetRepositoryProvider).saveUserPresets(_userPresets);
    _publish();
  }

  /// Borra un preset del usuario u oculta uno de fábrica. "Original" no se
  /// puede borrar.
  Future<void> delete(FilmPreset preset) async {
    if (preset.id == kOriginalPresetId) return;
    final repository = ref.read(presetRepositoryProvider);
    if (preset.isBuiltIn) {
      _hiddenIds = {..._hiddenIds, preset.id};
      await repository.saveHiddenBuiltInIds(_hiddenIds);
    } else {
      _userPresets = _userPresets.where((p) => p.id != preset.id).toList();
      await repository.saveUserPresets(_userPresets);
    }
    _publish();
    ref.read(activeLookProvider.notifier).onPresetDeleted(preset.id);
  }

  /// Deshace el borrado de [preset].
  Future<void> restore(FilmPreset preset) async {
    if (preset.isBuiltIn) {
      _hiddenIds = {..._hiddenIds}..remove(preset.id);
      await ref.read(presetRepositoryProvider).saveHiddenBuiltInIds(_hiddenIds);
      _publish();
    } else {
      await save(preset);
    }
  }

  Future<void> restoreAllBuiltIns() async {
    _hiddenIds = {};
    await ref.read(presetRepositoryProvider).saveHiddenBuiltInIds(_hiddenIds);
    _publish();
  }

  void _publish() => state = AsyncData(_visible());
}

/// Look activo en la cámara: el preset elegido más los ajustes rápidos
/// (por ejemplo, el balance de blancos) que se hagan encima.
@Riverpod(keepAlive: true)
class ActiveLook extends _$ActiveLook {
  @override
  FilmPreset build() {
    final savedId = ref
        .read(settingsRepositoryProvider)
        .getChoice(StoredChoice.activePresetId);
    final builtIn = kBuiltInPresets.where((p) => p.id == savedId).firstOrNull;
    if (builtIn == null && savedId != null) _restoreUserPreset(savedId);
    return _selected =
        builtIn ?? kBuiltInPresets.firstWhere((p) => p.id == kDefaultPresetId);
  }

  /// Los filtros del usuario se cargan de un archivo: si el último elegido
  /// era uno de ellos, se vuelve a elegir cuando terminan de cargar.
  Future<void> _restoreUserPreset(String id) async {
    final presets = await ref.read(presetsProvider.future);
    final preset = presets.where((p) => p.id == id).firstOrNull;
    if (preset != null && ref.mounted) select(preset);
  }

  /// Preset elegido, sin los ajustes rápidos.
  late FilmPreset _selected;

  void select(FilmPreset preset) {
    state = _selected = preset;
    ref
        .read(settingsRepositoryProvider)
        .setChoice(StoredChoice.activePresetId, preset.id)
        .catchError(
          (Object error) => debugPrint('No se pudo guardar el filtro: $error'),
        );
  }

  void setWhiteBalance(double temperatureK, double tint) =>
      state = state.copyWith(temperatureK: temperatureK, tint: tint);

  void resetWhiteBalance() =>
      setWhiteBalance(_selected.temperatureK, _selected.tint);

  /// Si se borró el preset activo, la cámara vuelve a "Original".
  void onPresetDeleted(String id) {
    if (state.id == id) select(kOriginalPreset);
  }
}

/// Carga de antemano el shader y los LUTs de fábrica para que cambiar de
/// filtro no muestre un cuadro sin filtro mientras cargan.
Future<void> preloadFilmAssets(WidgetRef ref) async {
  await ref.read(filmProgramProvider.future);
  final assets = {null, for (final p in kBuiltInPresets) p.lutAsset};
  await Future.wait([
    for (final asset in assets) ref.read(lutImageProvider(asset).future),
  ]);
}
