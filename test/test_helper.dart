import 'dart:math';

class TestHelper {
  static const List<String> languages = [
    "English",
    "French",
    "Swahili",
    "Portuguese"
  ];
  static const Map<String, String> languageCodes = {
    "English": "en",
    "French": "fr",
    "Swahili": "sw",
    "Portuguese": "pt"
  };

  static String generateRandomWord() {
    var random = Random();
    String randomWord = String.fromCharCodes(
        List.generate(5, (index) => random.nextInt(33) + 89));
    return randomWord;
  }

  static List<Map<String, dynamic>> generateLanguageData() {
    List<Map<String, dynamic>> data = [];
    bool positiveSet = false;
    bool zeroSet = false;
    for (var element in languages) {
      int random = Random().nextInt(2);
      positiveSet = random == 1;
      zeroSet = random == 0;
      data.add({
        "language_code": languageCodes[element],
        "value": element,
        "status": random
      });
    }

    if (!positiveSet) {
      data[0]['status'] = 1;
    }

    if (!zeroSet) {
      data[0]['status'] = 0;
    }

    return data;
  }
}
