import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/services/language_service.dart';

class WeekDaysService {
  WeekDaysService() {
    _db = FirebaseFirestore.instance;
    _languageService = LanguageService();
  }

  late FirebaseFirestore _db;
  late final LanguageService _languageService;
  late List<String> _weekDays = [];

  Future<List<String>> loadWeekDays(String language) async {
    var languageRef = _languageService.loadLanguageReference(language);
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

  String getCurrentWeekDay() {
    int weekdayNum = DateTime.now().weekday;
    return _weekDays.isEmpty ? "" : _weekDays[weekdayNum];
  }
}