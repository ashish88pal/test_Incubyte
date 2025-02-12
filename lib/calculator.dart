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
    return _sumOfNumbers(
      numberString,
    );
  }

  // Handle custom delimiters including multiple delimiters
  static int _handleCustomDelimiter(String numbers) {
    var numberString = numbers.substring(numbers.indexOf('\n') + 1);

    return _sumOfNumbers(
      numberString,
    );
  }

  static int _sumOfNumbers(String numberString) {
    List<String> numbers = _getListOfNumbers(numberString);
    var sum = 0;
    // print("numbers + $numbers  length ${numbers.length}");

    List<int> negativeNumbers = [];

    for (var num in numbers) {
      // print(num);
      var number = stringtoIntCast(num);
      // print(number);

      // Collect negative numbers for exception handling
      if (number < 0) {
        negativeNumbers.add(number);
      }
      sum += number;
    }

    // Throw exception for negative numbers
    if (negativeNumbers.isNotEmpty) {
      throw FormatException(
          'Negative numbers not allowed: ${negativeNumbers.join(', ')}');
    }

    return sum;
  }

  static List<String> _getListOfNumbers(
    String numberString,
  ) {
    var regex = RegExp(r'-?\d+');

    return regex
        .allMatches(numberString)
        .map((match) => match.group(0)!) // Convert each match to an integer
        .toList();
  }

  //string to int cast
  static int stringtoIntCast(String source) {
    return int.parse(source);
  }
}
