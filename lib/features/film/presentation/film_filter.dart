import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/motion.dart';
import '../data/film_preset.dart';
import '../rendering/film_shader_uniforms.dart';
import '../rendering/look_lerp.dart';
import 'film_providers.dart';

/// Aplica el look de película en vivo sobre [child] (por ejemplo, el preview
/// de la cámara). Mientras el shader carga, o si el motor no lo soporta,
/// muestra [child] sin filtro.
///
/// Con [animateChanges], al pasar a otro preset (otro id) el look se
/// transforma suavemente; los ajustes del mismo preset se aplican al toque.
class FilmFilter extends ConsumerStatefulWidget {
  const FilmFilter({
    super.key,
    required this.look,
    required this.child,
    this.animateChanges = false,
  });

  final FilmPreset look;
  final Widget child;
  final bool animateChanges;

  @override
  ConsumerState<FilmFilter> createState() => _FilmFilterState();
}

class _FilmFilterState extends ConsumerState<FilmFilter>
    with SingleTickerProviderStateMixin {
  ui.FragmentShader? _shader;
  late final AnimationController _transition = AnimationController(
    vsync: this,
    duration: Motion.slow,
  )..addListener(() => setState(() {}));
  FilmPreset? _from;
  late FilmPreset _displayed = widget.look;

  @override
  void didUpdateWidget(FilmFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animateChanges && oldWidget.look.id != widget.look.id) {
      _from = _displayed;
      _transition.forward(from: 0);
    }
  }

  @override
  void dispose() {
    _transition.dispose();
    _shader?.dispose();
    super.dispose();
  }

  FilmPreset _currentLook() {
    final from = _from;
    if (from == null || !_transition.isAnimating) return widget.look;
    final t = Motion.standard.transform(_transition.value);
    return lerpLook(from, widget.look, t);
  }

  @override
  Widget build(BuildContext context) {
    final look = _displayed = _currentLook();
    final program = ref.watch(filmProgramProvider).value;
    final lut = ref.watch(lutImageProvider(look.lutAsset)).value;
    if (program == null ||
        lut == null ||
        !ui.ImageFilter.isShaderFilterSupported) {
      return widget.child;
    }
    final shader = _shader ??= program.fragmentShader();
    // El motor completa el tamaño real del input al usarlo como filtro.
    applyFilmUniforms(
      shader,
      look,
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
