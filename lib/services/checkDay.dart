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
    return todaysDate;
  }

  String getMysteres(String work) {
    String finalDate = '';
    String day = getDate(finalDate);
    String work = day;
    print(work);
    // int finaldate = checkedDate.weekday;
    // int calculateDate = finaldate - 1;
    // String mystereCheck = daysofWeek[calculateDate];
    // String finalMystereCheck = mystereCheck;
    var indexDate = daysofWeek.indexWhere((date) => date.contains(work));
    var todayMysteres = mysteres[indexDate];
    return todayMysteres;
  }
}
