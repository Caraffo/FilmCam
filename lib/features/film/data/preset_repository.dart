import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

import 'film_preset.dart';

/// Guarda los presets creados por el usuario en un JSON local.
class PresetRepository {
  static const _fileName = 'user_presets.json';

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$_fileName');
  }

  Future<List<FilmPreset>> loadUserPresets() async {
    final file = await _file();
    if (!await file.exists()) return [];
    final decoded = jsonDecode(await file.readAsString()) as List<dynamic>;
    return decoded
        .map((json) => FilmPreset.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveUserPresets(List<FilmPreset> presets) async {
    final file = await _file();
    final json = presets.map((preset) => preset.toJson()).toList();
    await file.writeAsString(jsonEncode(json));
  }
}
