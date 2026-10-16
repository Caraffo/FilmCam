/// Relación de aspecto de la foto, en vertical (ancho / alto).
enum CaptureAspect {
  /// La del sensor: no recorta.
  native('3:4', 3 / 4),
  square('1:1', 1),
  tall('9:16', 9 / 16);

  const CaptureAspect(this.label, this.ratio);

  final String label;
  final double ratio;
}
