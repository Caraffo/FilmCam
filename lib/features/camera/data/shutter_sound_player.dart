import 'package:audioplayers/audioplayers.dart';

/// Reproduce el clic del obturador sin cortar la música que esté sonando.
class ShutterSoundPlayer {
  static const _asset = 'sounds/shutter.wav';
  static const _maxSimultaneous = 3;

  Future<AudioPool>? _pool;

  Future<AudioPool> _load() => AudioPool.create(
    source: AssetSource(_asset),
    maxPlayers: _maxSimultaneous,
    playerMode: PlayerMode.lowLatency,
    audioContext: AudioContextConfig(
      focus: AudioContextConfigFocus.mixWithOthers,
      respectSilence: true,
    ).build(),
  );

  /// Carga el sonido de antemano para que el primer disparo no tenga demora.
  Future<void> preload() => _pool ??= _load();

  Future<void> play() async {
    final pool = await (_pool ??= _load());
    await pool.start();
  }

  Future<void> dispose() async => (await _pool)?.dispose();
}
