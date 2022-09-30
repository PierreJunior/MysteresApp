class CheckingDate {
  List<String> daysofWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Sunday'
  ];
  List<String> mysteres = [
    'Joyeux',
    'Douloureux',
    'Glorieux',
    'Lumineux',
    'Douloureux',
    'Joyeux',
    'Glorieux',
  ];

  String getDate(String finalDate) {
    var checkedDate = DateTime.now();
    var finalCheck = checkedDate.weekday;

    var calculateDate = finalCheck - 1;
    var todaysDate = daysofWeek[calculateDate];
    var indexDate = daysofWeek.indexWhere((date) => date.contains(todaysDate));
    var finalDate = daysofWeek[indexDate];
    var todaysMystere = mysteres[calculateDate];
    return todaysDate;
  }

  String updateDate() {
    var checkedDate = DateTime.now();
    var finalCheck = checkedDate.weekday;

    var calculateDate = finalCheck - 1;
    var todaysDate = daysofWeek[calculateDate];
    var indexDate = daysofWeek.indexWhere((date) => date.contains(todaysDate));
    var finalDate = daysofWeek[indexDate];
    var todaysMystere = mysteres[calculateDate];
    return todaysDate;
  }

  String getMysteres(String mystereCheck) {
    var checkedDate = DateTime.now();
    var finalDate = checkedDate.weekday;

    var calculateDate = finalDate - 1;
    var todaysDate = daysofWeek[calculateDate];
    var indexDate = daysofWeek.indexWhere((date) => date.contains(todaysDate));
    var todaysMystere = mysteres[indexDate];
    print(todaysMystere);
    return todaysMystere;
  }
}
