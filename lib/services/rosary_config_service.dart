import 'package:cloud_firestore/cloud_firestore.dart';

class RosaryConfigService {
  late FirebaseFirestore _db;

  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    setLanguages();
  }
  late final List<String> _languages = [];

  final List<String> _daysofWeek = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final Map<String, String> _mysteresMap = {
    'Monday': 'Joyeux',
    'Tuesday': 'Douloureux',
    'Wednesday': 'Glorieux',
    'Thursday': 'Lumineux',
    'Friday': 'Douloureux',
    'Saturday': 'Joyeux',
    'Sunday': 'Glorieux',
  };

  List<String> getDays() => _daysofWeek;
  List<String> getMysteres() => _mysteresMap.values.toSet().toList();
  String getMystere(String day) => _mysteresMap[day] ?? "";
  String getDefaultLanguage() => _languages.first;
  List<String> getLanguages() => _languages.toSet().toList();

  String getCurrentDay() {
    int weekdayNum = DateTime.now().weekday;
    return _daysofWeek[weekdayNum - 1];
  }

  void setLanguages() async {
    await _db.collection("languages").get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
    });
  }
}
