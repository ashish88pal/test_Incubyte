// Interface for delimiter handling
abstract class DelimiterHandler {
  String handle(String numbers);
}

// Default delimiter handler (handles basic cases)
class DefaultDelimiterHandler implements DelimiterHandler {
  @override
  String handle(String numbers) {
    return numbers.replaceAll('\n', ','); // Replaces newlines with commas
  }
}

// Custom delimiter handler (handles cases with custom delimiters)
class CustomDelimiterHandler implements DelimiterHandler {
  @override
  String handle(String numbers) {
    var numberString = numbers.substring(numbers.indexOf('\n') + 1);
    return numberString;
  }
}

// Number parsing utility to handle sum logic and validation
class NumberParser {
  List<int> parseNumbers(String numberString) {
    var regex = RegExp(r'-?\d+');
    return regex
        .allMatches(numberString)
        .map((match) => int.parse(match.group(0)!))
        .toList();
  }

  int sum(List<int> numbers) {
    int sum = 0;
    List<int> negativeNumbers = [];

    for (var num in numbers) {
      if (num < 0) {
        negativeNumbers.add(num); // Collect negative numbers
      } else if (num <= 1000) {
        sum += num; // Ignore numbers greater than 1000
      }
    }

    if (negativeNumbers.isNotEmpty) {
      throw FormatException(
          'Negative numbers not allowed: ${negativeNumbers.join(', ')}');
    }

    return sum;
  }
}

// StringCalculator class that uses Dependency Injection for delimiter handling
class StringCalculatorWithSOILD {
  final DelimiterHandler delimiterHandler;
  final NumberParser numberParser;

  // Constructor with dependency injection
  StringCalculatorWithSOILD(
      {DelimiterHandler? delimiterHandler, NumberParser? numberParser})
      : delimiterHandler = delimiterHandler ?? DefaultDelimiterHandler(),
        numberParser = numberParser ?? NumberParser();

  int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    // If it starts with "//", we handle custom delimiters
    if (numbers.startsWith('//')) {
      return _handleCustomDelimiter(numbers);
    }

    // Otherwise, use the default handler
    var numberString = delimiterHandler.handle(numbers);
    return numberParser.sum(numberParser.parseNumbers(numberString));
  }

  // Handle custom delimiter
  int _handleCustomDelimiter(String numbers) {
    var delimiterHandler = CustomDelimiterHandler();
    var numberString = delimiterHandler.handle(numbers);
    return numberParser.sum(numberParser.parseNumbers(numberString));
  }
}

void main() {
  StringCalculatorWithSOILD calculator = StringCalculatorWithSOILD();

  // Test cases
  print(calculator.add('')); // Output: 0
  print(calculator.add('5')); // Output: 5
  print(calculator.add('1,2,3')); // Output: 6
  print(calculator.add('1\n3,5')); // Output: 9
  print(calculator.add('//;\n1;2;3')); // Output: 6
  print(calculator.add('1000,1001,2')); // Output: 1002
  print(calculator.add('//[***]\n1***3***9')); // Output: 13
  print(calculator.add('1,-2,3')); // Throws FormatException
}
