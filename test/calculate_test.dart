import 'package:spawnuri_client/calculate.dart';
import 'package:test/test.dart';

void main() {
  test('calculate 6 * 7', () {
    expect(calculate(6, 7), 42);
  });

  test('calculate -1 * 7', () {
    expect(calculate(-1, 7), -7);
  });
}
