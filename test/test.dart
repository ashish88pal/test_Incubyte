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

  test('Multiple numbers, comma separated', () {
    expect(StringCalculator.add('1,2'), equals(3));
    expect(StringCalculator.add('1,2,3'), equals(6));
    expect(StringCalculator.add('1,2,3,4,5'), equals(15));
  });

  test('Newlines should be treated as commas', () {
    expect(StringCalculator.add('1\n2,3'), equals(6));
    expect(StringCalculator.add('1,2\n3,4'), equals(10));
  });
}
