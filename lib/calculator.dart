class StringCalculator {
  static int add(String numbers) {
    if (numbers.isEmpty) {
      return 0;
    }
    if (numbers.length < 2) {
      return int.parse(numbers);
    }

    var regex = RegExp(r'\d+');

    List<int> numList = regex
        .allMatches(numbers)
        .map((match) => int.parse(match.group(0)!))
        .toList();

    return numList.reduce((value, element) => value + element);
  } .
}
