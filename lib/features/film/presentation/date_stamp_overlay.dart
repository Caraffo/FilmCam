import 'package:flutter/widgets.dart';

import '../rendering/date_stamp.dart';

/// Muestra la fecha sobre una foto o el visor tal como saldrá en el JPEG.
/// Ocupa todo el espacio de su padre, que debe tener el tamaño de la foto.
class DateStampOverlay extends StatelessWidget {
  const DateStampOverlay({super.key, required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(child: CustomPaint(painter: _DateStampPainter(date)));
  }
}

class _DateStampPainter extends CustomPainter {
  const _DateStampPainter(this.date);

  final DateTime date;

  @override
  void paint(Canvas canvas, Size size) => paintDateStamp(canvas, size, date);

  @override
  bool shouldRepaint(_DateStampPainter old) => old.date != date;
}
