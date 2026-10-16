import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/film_preset.dart';
import '../rendering/film_shader_uniforms.dart';
import 'film_providers.dart';

/// Aplica el look de película en vivo sobre [child] (por ejemplo, el preview
/// de la cámara). Mientras el shader carga, o si el motor no lo soporta,
/// muestra [child] sin filtro.
class FilmFilter extends ConsumerStatefulWidget {
  const FilmFilter({super.key, required this.look, required this.child});

  final FilmPreset look;
  final Widget child;

  @override
  ConsumerState<FilmFilter> createState() => _FilmFilterState();
}

class _FilmFilterState extends ConsumerState<FilmFilter> {
  ui.FragmentShader? _shader;

  @override
  void dispose() {
    _shader?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final program = ref.watch(filmProgramProvider).value;
    final lut = ref.watch(lutImageProvider(widget.look.lutAsset)).value;
    if (program == null ||
        lut == null ||
        !ui.ImageFilter.isShaderFilterSupported) {
      return widget.child;
    }
    final shader = _shader ??= program.fragmentShader();
    // El motor completa el tamaño real del input al usarlo como filtro.
    applyFilmUniforms(
      shader,
      widget.look,
      size: ui.Size.zero,
      lut: lut,
      isFilter: true,
    );
    return ImageFiltered(
      imageFilter: ui.ImageFilter.shader(shader),
      child: widget.child,
    );
  }
}
