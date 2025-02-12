class StringCalculator {
  static int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    if (numbers.length < 2) {
      return int.parse(numbers);
    }

    // Replace newlines with commas for regular cases
    var numberString = numbers.replaceAll('\n', ',');
    return _sumOfNumbers(numberString);
  }

  static _sumOfNumbers(String numberString) {
    var regex = RegExp(r'\d+'); //regex for excluding symbols and chars
    List<int> numList = regex
        .allMatches(numberString)
        .map((match) => stringtoIntCast(match.group(0)!))
        .toList();

    int sum = numList.reduce((value, element) => value + element);
    return sum;
  }

  //string to int cast
  static int stringtoIntCast(String source) {
    return int.parse(source);
  }
}
