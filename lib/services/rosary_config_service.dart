import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/screens/languagepreference_screen.dart';

class RosaryConfigService {
  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    _setLanguages();
    _setWeekDays();
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];
  late String _selectedLanguage = const LanguageSettings().getData3();
  late String _selectedWeekDay = "";
  late final List<String> _weekDays = [];

  String getDefaultWeekDay() => "";
  List<String> getWeekDays() => _weekDays.toSet().toList();
  String getDefaultLanguage() => const LanguageSettings().getData3();
  List<String> getLanguages() => _languages.toSet().toList();

  void _refreshWeekDays() {
    _weekDays.clear();
    _setWeekDays();
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

  void _setWeekDays() async {
    var languageRef = _db.collection('languages').doc(_selectedLanguage);
    await _db
        .collection('week_days')
        .where("language_code", isEqualTo: languageRef)
        .orderBy('order')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        _weekDays.add(doc.data()['value']);
      }
    });
    _selectedWeekDay = getCurrentWeekDay();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getWeekDaysFuture() {
    return _db.collection('week_days').get();
  }

  String getCurrentWeekDay() {
    int weekdayNum = DateTime.now().weekday;
    return _weekDays.isEmpty ? "" : _weekDays[weekdayNum];
  }

  void setSelectedLang(String lang) {
    _selectedLanguage = lang;
  }

  void setSelectedWeekDay(String dayOW) {
    _selectedWeekDay = dayOW;
  }

  String get selectedWeekDay {
    return _selectedWeekDay;
  }

  String get selectedLanguage {
    return _selectedLanguage;
  }

  void reset() {
    if (_selectedLanguage == getDefaultLanguage()) {
      // No need to fetch everything from the API
      _selectedWeekDay = getCurrentWeekDay();
    } else {
      setSelectedLang(getDefaultLanguage());
      _refreshWeekDays();
    }
  }

  void changeLanguage(String lang) {
    setSelectedLang(lang);
    _refreshWeekDays();
  }
}
