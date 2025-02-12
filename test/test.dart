import 'package:flutter_test/flutter_test.dart';
import 'package:incubyte/calculator.dart';

void main() {
  test('Empty string should return 0', () {
    expect(StringCalculator.add(''), equals(0));
  });
}
