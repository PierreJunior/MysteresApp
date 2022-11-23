import 'package:cloud_firestore/cloud_firestore.dart';

class RosaryPrayerService {
  late int _currentStep;
  late final String _selectedDay;
  late final String _selectedLanguage;

  RosaryPrayerService(String selectedDay, String selectedLanguage) {
    _db = FirebaseFirestore.instance;
    _currentStep = 15;
    _selectedDay = selectedDay;
    _selectedLanguage = selectedLanguage;
  }

  late FirebaseFirestore _db;
  late final List<Map<String, dynamic>> _rosarySteps = [];

  Future<List<Map<String, dynamic>>> loadPrayers() async {
    var dayRef = _db.collection('week_days').doc(_selectedDay);
    var languageRef = _db.collection('languages').doc(_selectedLanguage);
    return await _db
        .collection('prayers')
        .orderBy('step_number')
        .where('language_code', isEqualTo: languageRef)
        .where('week_days', arrayContains: dayRef)
        .get()
        .then((value) {
      for (var doc in value.docs) {
        // _rosarySteps.add(doc.data());
        var data = doc.data();
        _rosarySteps.add({
          "value": data['value'],
          "repeat": data['repeat'],
          "title": data['title'],
          "sub_title": data['sub_title'],
          "type": data['type'],
          "count": data['count'],
          "step_number": data['step_number'],
        });
      }
      if (_rosarySteps.isEmpty) {
        throw Exception('Some arbitrary error');
      }
      return _rosarySteps;
    }).catchError((e) {});
  }

  void setStep(int step) => _currentStep = step;

  int getCurrentStep() => _currentStep;

  void increaseStep() {
    _currentStep++;
  }

  void decreaseStep() {
    if (_currentStep > 1) {
      _currentStep--;
    }
  }

  int getTotalPrayerSteps() => _rosarySteps.length;

  Map<String, dynamic> getPrayer() {
    // Check step type.
    Map<String, dynamic> step =
        _rosarySteps.firstWhere((e) => e["step_number"] == _currentStep);

    return step;
  }

  bool isLastStep() {
    return _currentStep >= getTotalPrayerSteps();
  }

  bool isFirstStep() {
    return _currentStep <= 1;
  }
}
