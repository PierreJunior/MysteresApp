class RosaryConfigService {
  final List<String> _lang = <String>['English', 'French', 'Portuguese'];

  final List<String> _daysofWeek = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final Map<String, String> _mysteresMap = {
    'Monday': 'Joyeux',
    'Tuesday': 'Douloureux',
    'Wednesday': 'Glorieux',
    'Thursday': 'Lumineux',
    'Friday': 'Douloureux',
    'Saturday': 'Joyeux',
    'Sunday': 'Glorieux',
  };

  List<String> getDays() => _daysofWeek;
  List<String> getMysteres() => _mysteresMap.values.toSet().toList();
  String getMystere(String day) => _mysteresMap[day] ?? "";
  String getDefaultLanguage() => _lang.first;
  List<String> getLanguages() => _lang.toSet().toList();

  String getCurrentDay() {
    int weekdayNum = DateTime.now().weekday;
    return _daysofWeek[weekdayNum - 1];
  }
}
