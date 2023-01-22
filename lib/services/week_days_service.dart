import 'package:cloud_firestore/cloud_firestore.dart';

class WeekDaysService {
  WeekDaysService(FirebaseFirestore db) {
    _db = db;
  }

  late FirebaseFirestore _db;
  late final List<String> _weekDays = [];

  List<String> getWeekDays() => _weekDays.toSet().toList();

  String getCurrentWeekDay() {
    int weekdayNum = DateTime.now().weekday;
    return _weekDays.isEmpty ? "" : _weekDays[weekdayNum - 1];
  }

  Future<List<String>> loadWeekDays(String language) async {
    _weekDays.clear();
    return await _db
        .collection('week_days')
        .where('language', isEqualTo: language)
        .orderBy('order')
        .get()
        .then((value) {
      for (var doc in value.docs) {
        _weekDays.add(doc.data()['value']);
      }
      return _weekDays;
    });
  }
}
