import 'package:flutter_test/flutter_test.dart';
import 'package:incubyte/calculator.dart';
import 'package:incubyte/calculator_TDD_with_SOLID.dart';

void main() {
  StringCalculator calculator = StringCalculator();

  StringCalculatorWithSOILD calWithSOILD = StringCalculatorWithSOILD();

  group('StringCalculatorWithTDD=>\t', () {
    test('Empty string should return 0', () {
      expect(calculator.add(''), equals(0));
    });

    test('Single number should return that number', () {
      expect(calculator.add('1'), equals(1));
      expect(calculator.add('10'), equals(10));
    });

    test('Multiple numbers, comma separated', () {
      expect(calculator.add('1,2'), equals(3));
      expect(calculator.add('1,2,3'), equals(6));
      expect(calculator.add('1,2,3,4,5'), equals(15));
    });

    test('Newlines should be treated as commas', () {
      expect(calculator.add('1\n2,3'), equals(6));
      expect(calculator.add('1,2\n3,4'), equals(10));
    });

    test('Custom delimiter with "//" syntax', () {
      expect(calculator.add('//;\n1;2;3'), equals(6));
    });

    test('Negative numbers should throw exception', () {
      expect(
          () => calculator.add('1,-2,3'),
          throwsA(isA<FormatException>().having((e) => e.message, 'message',
              'Negative numbers not allowed: -2')));
      expect(
          () => calculator.add('1,-2,-3,4'),
          throwsA(isA<FormatException>().having((e) => e.message, 'message',
              'Negative numbers not allowed: -2, -3')));
    });

    test('Numbers greater than 1000 should be ignored', () {
      expect(calculator.add('2,1001'), equals(2));
      expect(calculator.add('1000,1001,2'), equals(1002));
    });

    test('Multiple delimiters with length greater than one', () {
      expect(calculator.add('//[***]\n1***2***3'), equals(6));
      expect(calculator.add('//[*][%]\n1*2%3'), equals(6));
      expect(calculator.add('//[***][%%]\n1***2%%3'), equals(6));
      expect(calculator.add('//[a][bb]\n1a2bb3'), equals(6));
    });
  });

  group('StringCalculatorWithSOILDandTDD=>\t', () {
    test('Empty string should return 0', () {
      expect(calWithSOILD.add(''), equals(0));
    });

    test('Single number should return that number', () {
      expect(calWithSOILD.add('1'), equals(1));
      expect(calWithSOILD.add('10'), equals(10));
    });

    test('Multiple numbers, comma separated', () {
      expect(calWithSOILD.add('1,2'), equals(3));
      expect(calWithSOILD.add('1,2,3'), equals(6));
      expect(calWithSOILD.add('1,2,3,4,5'), equals(15));
    });

    test('Newlines should be treated as commas', () {
      expect(calWithSOILD.add('1\n2,3'), equals(6));
      expect(calWithSOILD.add('1,2\n3,4'), equals(10));
    });

    test('Custom delimiter with "//" syntax', () {
      expect(calWithSOILD.add('//;\n1;2;3'), equals(6));
    });

    test('Negative numbers should throw exception', () {
      expect(
          () => calWithSOILD.add('1,-2,3'),
          throwsA(isA<FormatException>().having((e) => e.message, 'message',
              'Negative numbers not allowed: -2')));
      expect(
          () => calWithSOILD.add('1,-2,-3,4'),
          throwsA(isA<FormatException>().having((e) => e.message, 'message',
              'Negative numbers not allowed: -2, -3')));
    });

    test('Numbers greater than 1000 should be ignored', () {
      expect(calWithSOILD.add('2,1001'), equals(2));
      expect(calWithSOILD.add('1000,1001,2'), equals(1002));
    });

    test('Multiple delimiters with length greater than one', () {
      expect(calWithSOILD.add('//[***]\n1***2***3'), equals(6));
      expect(calWithSOILD.add('//[*][%]\n1*2%3'), equals(6));
      expect(calWithSOILD.add('//[***][%%]\n1***2%%3'), equals(6));
      expect(calWithSOILD.add('//[a][bb]\n1a2bb3'), equals(6));
    });
  });
}
