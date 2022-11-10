import 'package:cloud_firestore/cloud_firestore.dart';

class RosaryConfigService {
  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    setLanguages();
    setDaysOfWeek();
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];
  late String _selectedLanguage = "English";
  late String _selectedDay = "";
  late final List<String> _daysofWeek = [];

  List<String> getDays() => _daysofWeek.toSet().toList();
  String getDefaultLanguage() => "English";
  List<String> getLanguages() => _languages.toSet().toList();

  void rebuildWeekDays() {
    _daysofWeek.clear();
    setDaysOfWeek();
  }

  void setLanguages() async {
    await _db.collection("languages").get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
    });
  }

  void setDaysOfWeek() async {
    var languageRef = _db.collection('languages').doc(_selectedLanguage);
    await _db
        .collection('week_days')
        .where("language_code", isEqualTo: languageRef)
        .orderBy('order')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        _daysofWeek.add(doc.data()['value']);
      }
    });
    _selectedDay = getCurrentDay();
  }

  String getCurrentDay() {
    int weekdayNum = DateTime.now().weekday;
    return _daysofWeek[weekdayNum];
  }

  void setSelectedLang(String lang) {
    _selectedLanguage = lang;
  }

  void setSelectedDay(String dayOW) {
    _selectedDay = dayOW;
  }

  String get selectedDay {
    return _selectedDay;
  }

  String get selectedLanguage {
    return _selectedLanguage;
  }
}
