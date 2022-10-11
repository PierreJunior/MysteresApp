class RosaryConfigService {
  final List<String> _daysofWeek = <String>[
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche',
  ];

  final Map<String, String> _mysteresMap = {
    'Lundi': 'Joyeux',
    'Mardi': 'Douloureux',
    'Mercredi': 'Glorieux',
    'Jeudi': 'Lumineux',
    'Vendredi': 'Douloureux',
    'Samedi': 'Joyeux',
    'Dimanche': 'Glorieux',
  };

  List<String> getDays() => _daysofWeek;
  List<String> getMysteres() => _mysteresMap.values.toSet().toList();
  String getMystere(String day) => _mysteresMap[day] ?? "";

  String getCurrentDay() {
    int weekdayNum = DateTime.now().weekday;
    return _daysofWeek[weekdayNum - 1];
  }
}
