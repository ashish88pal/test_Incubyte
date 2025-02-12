import 'package:flutter_test/flutter_test.dart';
import 'package:incubyte/calculator.dart';

void main() {
  group('StringCalculator', () {
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

    test('Custom delimiter with "//" syntax', () {
      expect(StringCalculator.add('//;\n1;2;3'), equals(6));
    });

    test('Negative numbers should throw exception', () {
      expect(
          () => StringCalculator.add('1,-2,3'),
          throwsA(isA<FormatException>().having((e) => e.message, 'message',
              'Negative numbers not allowed: -2')));
      expect(
          () => StringCalculator.add('1,-2,-3,4'),
          throwsA(isA<FormatException>().having((e) => e.message, 'message',
              'Negative numbers not allowed: -2, -3')));
    });

    test('Numbers greater than 1000 should be ignored', () {
      expect(StringCalculator.add('2,1001'), equals(2));
      expect(StringCalculator.add('1000,1001,2'), equals(1002));
    });

    test('Multiple delimiters with length greater than one', () {
      expect(StringCalculator.add('//[***]\n1***2***3'), equals(6));
      expect(StringCalculator.add('//[*][%]\n1*2%3'), equals(6));
      expect(StringCalculator.add('//[***][%%]\n1***2%%3'), equals(6));
      expect(StringCalculator.add('//[a][bb]\n1a2bb3'), equals(6));
    });
  });
}
