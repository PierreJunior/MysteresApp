import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/global_variable.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:mysteres/services/week_days_service.dart';

class RosaryConfigService {
  RosaryConfigService() {
    FirebaseFirestore db = FirebaseFirestore.instance;
    _languageService = LanguageService(db);
    _weekDaysService = WeekDaysService(db);
  }

  late String _selectedLanguage;
  late String _defaultLanguage;
  String? _selectedWeekDay;
  late final List<String> _weekDays = [];
  late LanguageService _languageService;
  late WeekDaysService _weekDaysService;

  List<String> getWeekDays() => _weekDaysService.getWeekDays();
  String getDefaultLanguage() => _defaultLanguage;
  List<String> getLanguages() => _languageService.getLanguages();

  void initDefaultWeekDay() {
    _selectedWeekDay = _weekDaysService.getCurrentWeekDay();
  }

  Future<String> load() async {
    return await _languageService
        .getDefaultLanguage()
        .then((defaultLang) async {
      _selectedLanguage = defaultLang!;
      _defaultLanguage = _selectedLanguage;
      return await _languageService
          .loadLanguages(languageCodes: GlobalValue.supportedLocales.toList())
          .then((languages) async {
        return _weekDaysService.loadWeekDays(_selectedLanguage).then((val) {
          _selectedWeekDay = _weekDaysService.getCurrentWeekDay();
          return "Done";
        });
      });
    });
  }

  Future<List<String>> loadWeekDays() async {
    _weekDays.clear();
    return _weekDaysService.loadWeekDays(_selectedLanguage).then((value) {
      return value;
    });
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
