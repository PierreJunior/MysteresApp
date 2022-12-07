import 'dart:math';

class TestHelper {
  static String generateRandomWord() {
    var random = Random();
    String randomWord = String.fromCharCodes(
        List.generate(5, (index) => random.nextInt(33) + 89));
    return randomWord;
  }
}
