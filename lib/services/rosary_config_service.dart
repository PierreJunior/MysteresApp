import 'package:cloud_firestore/cloud_firestore.dart';

class RosaryConfigService {
  late FirebaseFirestore _db;

  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    initLang();
  }

  // final List<String> _lang = <String>['English', 'French', 'Portuguese'];
  late List<String> _lang = [];

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
  String getDefaultLanguage() => _lang.first;
  List<String> getLanguages() => _lang.toSet().toList();

  String getCurrentDay() {
    int weekdayNum = DateTime.now().weekday;
    return _daysofWeek[weekdayNum - 1];
  }

  void initLang() async {
    await _db.collection("languages").get().then((event) {
      for (var doc in event.docs) {
        print("${doc.id} => ${doc.data()['value']}");
        _lang ??= [];
        _lang.add(doc.data()['value']);
      }
    });
  }
}
