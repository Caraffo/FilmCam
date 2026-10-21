/// Preferencias de sí/no de la app, con su clave y valor por defecto.
enum AppSetting {
  shutterSound('shutter_sound_enabled', defaultValue: true),
  openPhotoAfterCapture('open_photo_after_capture', defaultValue: false),
  dateStamp('date_stamp_enabled', defaultValue: false);

  const AppSetting(this.key, {required this.defaultValue});

  final String key;
  final bool defaultValue;
}

/// Opciones de la cámara que se recuerdan entre sesiones, guardadas por
/// nombre (por ejemplo, el nombre del valor de un enum o el id de un filtro).
enum StoredChoice {
  captureAspect('capture_aspect'),
  flashMode('flash_mode'),
  activePresetId('active_preset_id');

  const StoredChoice(this.key);

  final String key;
}
