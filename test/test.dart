import 'package:flutter_test/flutter_test.dart';
import 'package:incubyte/calculator.dart';

void main() {
  test('Empty string should return 0', () {
    expect(StringCalculator.add(''), equals(0));
  });

  test('Single number should return that number', () {
    expect(StringCalculator.add('1'), equals(1));
    expect(StringCalculator.add('10'), equals(10));
  });
}
