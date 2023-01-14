import 'package:cloud_firestore/cloud_firestore.dart';

class RosaryPrayerService {
  RosaryPrayerService(String selectedDay, String selectedLanguage) {
    _db = FirebaseFirestore.instance;
    _currentStep = 1;
    _selectedDay = selectedDay;
    _selectedLanguage = selectedLanguage;
  }

  late int _currentStep;
  late final String _selectedDay;
  late final String _selectedLanguage;
  late FirebaseFirestore _db;
  late final List<Map<String, dynamic>> _rosarySteps = [];

  Future<List<Map<String, dynamic>>> loadPrayers() async {
    return await _db
        .collection('prayers')
        .orderBy('step_number')
        .where('language', isEqualTo: _selectedLanguage)
        .where('week_days', arrayContains: _selectedDay)
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
        throw Exception(
            'Business logic error. Rosary steps are empty for the selected configuration');
      }
      return _rosarySteps;
    });
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
