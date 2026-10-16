import 'package:filmcam/features/film/data/film_preset.dart';
import 'package:filmcam/features/film/rendering/white_balance.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('la temperatura neutra sin tint no cambia los colores', () {
    final (r, g, b) = whiteBalanceMultipliers(kNeutralTemperatureK, 0);
    expect(r, closeTo(1, 1e-9));
    expect(g, closeTo(1, 1e-9));
    expect(b, closeTo(1, 1e-9));
  });

  test('una temperatura mayor a la neutra calienta la imagen', () {
    final (r, _, b) = whiteBalanceMultipliers(8363, 0);
    expect(r, greaterThan(1));
    expect(b, lessThan(1));
  });

  test('una temperatura menor a la neutra enfría la imagen', () {
    final (r, _, b) = whiteBalanceMultipliers(3200, 0);
    expect(r, lessThan(1));
    expect(b, greaterThan(1));
  });

  test('el tint positivo saca verde (magenta)', () {
    final (_, neutralGreen, _) = whiteBalanceMultipliers(
      kNeutralTemperatureK,
      0,
    );
    final (_, magentaGreen, _) = whiteBalanceMultipliers(
      kNeutralTemperatureK,
      20,
    );
    expect(magentaGreen, lessThan(neutralGreen));
  });
}
