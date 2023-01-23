class RosaryConfig {
  late String day;
  late String language;
  late List<PrayerType> prayerTypes;
  RosaryConfig(
      {required this.day, required this.language, required this.prayerTypes});
}

enum PrayerType { normal, mystere }
