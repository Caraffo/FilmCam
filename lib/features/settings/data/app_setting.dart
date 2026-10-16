/// Preferencias de sí/no de la app, con su clave y valor por defecto.
enum AppSetting {
  shutterSound('shutter_sound_enabled', defaultValue: true),
  openPhotoAfterCapture('open_photo_after_capture', defaultValue: false);

  const AppSetting(this.key, {required this.defaultValue});

  final String key;
  final bool defaultValue;
}
