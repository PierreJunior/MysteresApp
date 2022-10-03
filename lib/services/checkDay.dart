class CheckingDate {
  List<String> daysofWeek = <String>[
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

  int getDay() {
    var checkedDate = DateTime.now();
    var finalDate = checkedDate.weekday;
    var limit = finalDate;

    var calculateDate = finalDate - 1;
    return calculateDate;
  }

  String getMysteres(String limit) {
    var checkedDate = DateTime.now();
    int finalDate = checkedDate.weekday;
    int calculateDate = finalDate - 1;
    String mystereCheck = daysofWeek[calculateDate];
    String finalMystereCheck = mystereCheck;
    var indexDate =
        daysofWeek.indexWhere((date) => date.contains(finalMystereCheck));
    var todayMysteres = mysteres[calculateDate];
    return todayMysteres;
  }
}
