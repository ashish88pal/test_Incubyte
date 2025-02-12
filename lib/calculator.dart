class StringCalculator {
  static int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }

    if (numbers.startsWith('//')) {
      return _handleCustomDelimiter(numbers);
    }

    // Replace newlines with commas for regular cases
    var numberString = numbers.replaceAll('\n', ',');
    return _sumOfNumbers(numberString);
  }

  // Handle custom delimiters including multiple delimiters
  static int _handleCustomDelimiter(String numbers) {
    var numberString = numbers.substring(numbers.indexOf('\n') + 1);
    return _sumOfNumbers(numberString);
  }

  static int _sumOfNumbers(String numberString) {
    List<String> numbers = _getListOfNumbers(numberString);
    var sum = 0;

    List<int> negativeNumbers = [];

    for (var num in numbers) {
      var number = stringtoIntCast(num);
      // Collect negative numbers for exception handling
      if (number < 0) {
        negativeNumbers.add(number);
      } else if (number <= 1000) {
        // Ignore numbers greater than 1000
        sum += number;
      }
    }

    // Throw exception for negative numbers
    if (negativeNumbers.isNotEmpty) {
      throw FormatException(
          'Negative numbers not allowed: ${negativeNumbers.join(', ')}');
    }

    return sum;
  }

  static List<String> _getListOfNumbers(String numberString) {
    RegExp regex = RegExp(r'-?\d+');

    List<String> listOfNumbers = regex
        .allMatches(numberString)
        .map((match) => match.group(0)!) // Convert each match to an integer
        .toList();
    return listOfNumbers;
  }

  //string to int cast
  static int stringtoIntCast(String source) {
    return int.parse(source);
  }
}

void main() {
  // Test cases
  print(StringCalculator.add('')); // Output: 0
  print(StringCalculator.add('5')); // Output: 5
  print(StringCalculator.add('1,2,3')); // Output: 6
  print(StringCalculator.add('1\n3,5')); // Output: 9
  print(StringCalculator.add('//;\n1;2;3')); // Output: 6
  print(StringCalculator.add('1000,1001,2')); // Output: 1002
  print(StringCalculator.add('//[***]\n1***3***9')); // Output: 13
  print(StringCalculator.add('1,-2,3')); // Throws FormatException
}
