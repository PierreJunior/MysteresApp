class CheckingDate {
  List<String> daysofWeek = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
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
  String todaysDate = '';

  String getDate(String dropdownValue) {
    //finds Todays day
    var checkedDate = DateTime.now();
    var finalCheck = checkedDate.weekday;

    var calculateDate = finalCheck - 1;
    todaysDate = daysofWeek[calculateDate];
    return todaysDate;
  }

  String getMysteres(String finalDate) {
    //finds Les mysteres when the first builds up using todays day
    String day = getDate(finalDate);
    String work = day;
    var indexDate = daysofWeek.indexWhere((date) => date.contains(work));
    var todayMysteres = mysteres[indexDate];
    return todayMysteres;
  }

  String updating(String todayrewrite) {
    //updates todays mysteres when the user changes the day
    var indexDate =
        daysofWeek.indexWhere((element) => element.contains(todayrewrite));
    print('lll $indexDate');
    var todayMysteres = mysteres[indexDate];
    return todayMysteres;
  }
}
