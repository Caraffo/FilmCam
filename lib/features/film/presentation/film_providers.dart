import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/builtin_presets.dart';
import '../data/film_preset.dart';
import '../data/preset_repository.dart';

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

/// Presets de fábrica seguidos de los creados por el usuario.
@Riverpod(keepAlive: true)
class Presets extends _$Presets {
  @override
  Future<List<FilmPreset>> build() async {
    final userPresets = await ref
        .read(presetRepositoryProvider)
        .loadUserPresets();
    return [...kBuiltInPresets, ...userPresets];
  }

  /// Crea o reemplaza un preset de usuario.
  Future<void> save(FilmPreset preset) async {
    final userPresets = _userPresets();
    final index = userPresets.indexWhere((p) => p.id == preset.id);
    if (index == -1) {
      userPresets.add(preset);
    } else {
      userPresets[index] = preset;
    }
    await _persist(userPresets);
  }

  Future<void> delete(String id) =>
      _persist(_userPresets()..removeWhere((p) => p.id == id));

  List<FilmPreset> _userPresets() =>
      (state.value ?? []).where((p) => !p.isBuiltIn).toList();

  Future<void> _persist(List<FilmPreset> userPresets) async {
    await ref.read(presetRepositoryProvider).saveUserPresets(userPresets);
    state = AsyncData([...kBuiltInPresets, ...userPresets]);
  }
}

/// Look activo en la cámara: el preset elegido más los ajustes rápidos
/// (por ejemplo, el balance de blancos) que se hagan encima.
@Riverpod(keepAlive: true)
class ActiveLook extends _$ActiveLook {
  @override
  FilmPreset build() =>
      _selected = kBuiltInPresets.firstWhere((p) => p.id == kDefaultPresetId);

  /// Preset elegido, sin los ajustes rápidos.
  late FilmPreset _selected;

  void select(FilmPreset preset) => state = _selected = preset;

  void setWhiteBalance(double temperatureK, double tint) =>
      state = state.copyWith(temperatureK: temperatureK, tint: tint);

  void resetWhiteBalance() =>
      setWhiteBalance(_selected.temperatureK, _selected.tint);
}
