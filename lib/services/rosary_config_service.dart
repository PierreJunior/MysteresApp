import 'package:mysteres/services/language_service.dart';
import 'package:mysteres/services/logging_service.dart';
import 'package:mysteres/services/week_days_service.dart';

class RosaryConfigService {
  RosaryConfigService() {
    _languageService = LanguageService();
    _weekDaysService = WeekDaysService();
  }

  late String _selectedLanguage;
  late String _defaultLanguage;
  late String? _selectedWeekDay;
  late List<String> _weekDays = [];
  late final LanguageService _languageService;
  late final WeekDaysService _weekDaysService;

  List<String> getWeekDays() => _weekDays.toSet().toList();
  String getDefaultLanguage() => _defaultLanguage;
  List<String> getLanguages() => _languageService.getLanguages();

  void reset() {
    _weekDays.clear();
    _selectedWeekDay = _weekDaysService.getCurrentWeekDay();
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
    return await _languageService.loadLanguages().then((value) async {
      return _weekDaysService.loadWeekDays(_selectedLanguage).then((value) {
        _selectedWeekDay = _weekDaysService.getCurrentWeekDay();
        return "Done";
      });
    });
  }

  // Future<List<String>> loadWeekDays() async {
  //   return _weekDaysService.loadWeekDays(_selectedLanguage).then((value) {
  //     _weekDays = value;
  //     return value;
  //   });
  // }

  // String getCurrentWeekDay() {
  //   int weekdayNum = DateTime.now().weekday;
  //   return _weekDays.isEmpty ? "" : _weekDays[weekdayNum];
  // }

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
}
