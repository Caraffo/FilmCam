import 'dart:typed_data';

import 'package:filmcam/features/gallery/presentation/widgets/before_after_view.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as img;

Uint8List _solidPng(int r, int g, int b) {
  final image = img.Image(width: 4, height: 4);
  img.fill(image, color: img.ColorRgb8(r, g, b));
  return img.encodePng(image);
}

void main() {
  Future<void> pumpView(WidgetTester tester) => tester.pumpWidget(
    MaterialApp(
      home: BeforeAfterView(
        original: _solidPng(255, 0, 0),
        filtered: _solidPng(0, 0, 255),
        decodeWidth: 100,
      ),
    ),
  );

  testWidgets('muestra las dos etiquetas para comparar', (tester) async {
    await pumpView(tester);
    expect(find.text('Original'), findsOneWidget);
    expect(find.text('Con filtro'), findsOneWidget);
  });

  testWidgets('mantener apretado muestra solo el original', (tester) async {
    await pumpView(tester);
    final gesture = await tester.startGesture(
      tester.getCenter(find.byType(BeforeAfterView)),
    );
    await tester.pump(kLongPressTimeout + const Duration(milliseconds: 50));
    expect(find.text('Con filtro'), findsNothing);

    await gesture.up();
    await tester.pump();
    expect(find.text('Con filtro'), findsOneWidget);
  });
}
