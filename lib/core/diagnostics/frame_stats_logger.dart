import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

/// Mide la fluidez de la app: cada [_window] escribe en el log el tiempo
/// medio y p90 de build y raster, y el porcentaje de cuadros lentos.
/// Solo corre si se compila con `--dart-define=FRAME_STATS=true`.
abstract final class FrameStatsLogger {
  static const bool _enabled = bool.fromEnvironment('FRAME_STATS');
  static const Duration _window = Duration(seconds: 2);

  /// Presupuesto de un cuadro a 60 fps.
  static const Duration _frameBudget = Duration(microseconds: 16667);

  static final List<FrameTiming> _timings = [];
  static DateTime _windowStart = DateTime.now();

  static void start() {
    if (!_enabled) return;
    SchedulerBinding.instance.addTimingsCallback(_onTimings);
  }

  static void _onTimings(List<FrameTiming> timings) {
    _timings.addAll(timings);
    if (DateTime.now().difference(_windowStart) < _window) return;
    _report();
    _timings.clear();
    _windowStart = DateTime.now();
  }

  static void _report() {
    if (_timings.isEmpty) return;
    List<int> sorted(Iterable<Duration> values) =>
        values.map((d) => d.inMicroseconds).toList()..sort();
    final build = sorted(_timings.map((t) => t.buildDuration));
    final raster = sorted(_timings.map((t) => t.rasterDuration));
    final slow = _timings.where((t) => t.totalSpan > _frameBudget).length;
    String ms(List<int> values, double percentile) =>
        (values[((values.length - 1) * percentile).round()] / 1000)
            .toStringAsFixed(1);
    final avgBuild = build.reduce((a, b) => a + b) / build.length / 1000;
    final avgRaster = raster.reduce((a, b) => a + b) / raster.length / 1000;
    debugPrint(
      'FRAME_STATS frames=${_timings.length} '
      'build_avg=${avgBuild.toStringAsFixed(1)} build_p90=${ms(build, 0.9)} '
      'raster_avg=${avgRaster.toStringAsFixed(1)} raster_p90=${ms(raster, 0.9)} '
      'slow=${(slow * 100 / _timings.length).toStringAsFixed(0)}%',
    );
  }
}
