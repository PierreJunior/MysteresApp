import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RosaryConfigService {
  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    _initDefaultLangs();
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];
  late String _selectedLanguage;
  late String _defaultLanguage;
  late String? _selectedWeekDay;
  late final List<String> _weekDays = [];

  List<String> getWeekDays() => _weekDays.toSet().toList();
  String getDefaultLanguage() => _defaultLanguage;
  List<String> getLanguages() => _languages.toSet().toList();

  void _refreshWeekDays() {
    _weekDays.clear();
    getWeekDaysFuture().then((value) {
      initDefaultWeekDay();
    });
  }

  void initDefaultWeekDay() {
    _selectedWeekDay = getCurrentWeekDay();
  }

  void _initDefaultLangs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedLanguage =
        prefs.getString(GlobalValue.sharedPreferenceDefaultLanguageKey)!;
    _defaultLanguage = _selectedLanguage;
  }

  Future<String> load() async {
    return await getLanguagesFuture().then((value) async {
      return getWeekDaysFuture().then((val) {
        _selectedWeekDay = getCurrentWeekDay();
        return "Done";
      });
    });
  }

  Future<List<String>> getWeekDaysFuture() async {
    var languageRef = _db.collection('languages').doc(_selectedLanguage);
    return await _db
        .collection('week_days')
        .where('language_code', isEqualTo: languageRef)
        .orderBy('order')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        _weekDays.add(doc.data()['value']);
      }
      return _weekDays;
    });
  }

  Future<List<String>> getLanguagesFuture() async {
    return await _db.collection('languages').get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
      return _languages;
    });
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

  String? get selectedWeekDay {
    return _selectedWeekDay;
  }

  String get selectedLanguage {
    return _selectedLanguage;
  }

  void changeLanguage(String lang) {
    setSelectedLang(lang);
    _weekDays.clear();
  }
}
