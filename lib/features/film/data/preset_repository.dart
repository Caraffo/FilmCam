import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'film_preset.dart';

/// Guarda en JSON locales los presets creados por el usuario y los de
/// fábrica que borró (ocultos).
class PresetRepository {
  static const _userPresetsFile = 'user_presets.json';
  static const _hiddenPresetsFile = 'hidden_presets.json';

  Future<File> _file(String name) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$name');
  }

  Future<List<dynamic>> _readList(String name) async {
    final file = await _file(name);
    if (!await file.exists()) return [];
    return jsonDecode(await file.readAsString()) as List<dynamic>;
  }

  Future<void> _writeList(String name, List<Object> values) async =>
      (await _file(name)).writeAsString(jsonEncode(values));

  Future<List<FilmPreset>> loadUserPresets() async => [
    for (final json in await _readList(_userPresetsFile))
      FilmPreset.fromJson(json as Map<String, dynamic>),
  ];

  Future<void> saveUserPresets(List<FilmPreset> presets) => _writeList(
    _userPresetsFile,
    [for (final preset in presets) preset.toJson()],
  );

  Future<Set<String>> loadHiddenBuiltInIds() async =>
      (await _readList(_hiddenPresetsFile)).cast<String>().toSet();

  Future<void> saveHiddenBuiltInIds(Set<String> ids) =>
      _writeList(_hiddenPresetsFile, ids.toList());
}
