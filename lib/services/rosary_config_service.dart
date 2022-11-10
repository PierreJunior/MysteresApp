import 'package:cloud_firestore/cloud_firestore.dart';

class RosaryConfigService {
  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    _setLanguages();
    _setDaysOfWeek();
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];
  late String _selectedLanguage = "English";
  late String _selectedDay = "";
  late final List<String> _daysofWeek = [];

  String getDefaultDay() => "";
  List<String> getDays() => _daysofWeek.toSet().toList();
  String getDefaultLanguage() => "English";
  List<String> getLanguages() => _languages.toSet().toList();

  void _refreshDays() {
    _daysofWeek.clear();
    _setDaysOfWeek();
  }

  void _setLanguages() async {
    await _db.collection("languages").get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
    });
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLanguagesFuture() {
    return _db.collection('languages').get();
  }

  void _setDaysOfWeek() async {
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

  Future<QuerySnapshot<Map<String, dynamic>>> getDaysOfWeekFuture() {
    return _db.collection('week_days').get();
  }

  String getCurrentDay() {
    int weekdayNum = DateTime.now().weekday;
    return _daysofWeek.isEmpty ? "" : _daysofWeek[weekdayNum];
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

  void reset() {
    if (_selectedLanguage == getDefaultLanguage()) {
      // No need to fetch everything from the API
      _selectedDay = getCurrentDay();
    } else {
      setSelectedLang(getDefaultLanguage());
      _refreshDays();
    }
  }

  void changeLanguage(String lang) {
    setSelectedLang(lang);
    _refreshDays();
  }
}
