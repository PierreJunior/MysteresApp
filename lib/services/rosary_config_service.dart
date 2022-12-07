import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:mysteres/services/logging_service.dart';

class RosaryConfigService {
  RosaryConfigService() {
    _db = FirebaseFirestore.instance;
    _languageService = LanguageService();
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];
  late String _selectedLanguage;
  late String _defaultLanguage;
  late String? _selectedWeekDay;
  late final List<String> _weekDays = [];
  late final LanguageService _languageService;

  List<String> getWeekDays() => _weekDays.toSet().toList();
  String getDefaultLanguage() => _defaultLanguage;
  List<String> getLanguages() => _languages.toSet().toList();

  void initDefaultWeekDay() {
    _selectedWeekDay = getCurrentWeekDay();
  }

  void init() async {
    await _languageService.getDefaultLanguage().then((value) {
      if (value != null) {
        _selectedLanguage = value;
        _defaultLanguage = value;
      } else {
        String error = "Default language is not set.";
        LoggingService.message(error, level: LoggingLevel.fatal);
        throw Exception(error);
      }
    });
  }

  Future<String> load() async {
    return await loadLanguages().then((value) async {
      return loadWeekDays().then((val) {
        _selectedWeekDay = getCurrentWeekDay();
        return "Done";
      });
    });
  }

  Future<List<String>> loadWeekDays() async {
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

  Future<List<String>> loadLanguages() async {
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
