import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mysteres/services/week_days_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:math';

import '../mock.dart';

void main() {
  setupFirebaseAuthMocks();
  final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
  const List<String> languages = ["English", "French"];
  const Map<String, List<String>> daysByLanguage = {
    "English": [
      "Sunday",
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday"
    ],
    "French": [
      "Dimanche",
      "Lundi",
      "Mardi",
      "Mercredi",
      "Jeudi",
      "Vendredi",
      "Samedi"
    ],
  };

  setUpAll(() async {
    await Firebase.initializeApp();
    SharedPreferences.setMockInitialValues({});
  });

  group('Has remote data', () {
    setUp(() async {
      CollectionReference<Map<String, dynamic>> languagesCollection =
          fakeFirestore.collection('languages');

      await languagesCollection
          .add({'language_code': 'en', 'value': 'English', 'status': 1});
      await languagesCollection
          .add({'language_code': 'fr', 'value': 'French', 'status': 0});
      await languagesCollection
          .add({'language_code': 'en', 'value': 'English', 'status': 1});
      await languagesCollection
          .add({'language_code': 'sw', 'value': 'Swahili', 'status': 1});
      await languagesCollection
          .add({'language_code': 'pt', 'value': 'Portuguese', 'status': 0});

      var weekDaysCollection = fakeFirestore.collection('week_days');
      await weekDaysCollection
          .doc('Sunday')
          .set({'language': 'English', 'order': 1, 'value': "Sunday"});
      await weekDaysCollection
          .doc('Monday')
          .set({'language': 'English', 'order': 2, 'value': "Monday"});
      await weekDaysCollection
          .doc('Tuesday')
          .set({'language': 'English', 'order': 3, 'value': "Tuesday"});
      await weekDaysCollection
          .doc('Wednesday')
          .set({'language': 'English', 'order': 4, 'value': "Wednesday"});
      await weekDaysCollection
          .doc('Thursday')
          .set({'language': 'English', 'order': 5, 'value': "Thursday"});
      await weekDaysCollection
          .doc('Friday')
          .set({'language': 'English', 'order': 6, 'value': "Friday"});
      await weekDaysCollection
          .doc('Saturday')
          .set({'language': 'English', 'order': 7, 'value': "Saturday"});
      await weekDaysCollection
          .doc('Dimanche')
          .set({'language': 'French', 'order': 1, 'value': "Dimanche"});
      await weekDaysCollection
          .doc('Lundi')
          .set({'language': 'French', 'order': 2, 'value': "Lundi"});
      await weekDaysCollection
          .doc('Mardi')
          .set({'language': 'French', 'order': 3, 'value': "Mardi"});
      await weekDaysCollection
          .doc('Mercredi')
          .set({'language': 'French', 'order': 4, 'value': "Mercredi"});
      await weekDaysCollection
          .doc('Jeudi')
          .set({'language': 'French', 'order': 5, 'value': "Jeudi"});
      await weekDaysCollection
          .doc('Vendredi')
          .set({'language': 'French', 'order': 6, 'value': "Vendredi"});
      await weekDaysCollection
          .doc('Samedi')
          .set({'language': 'French', 'order': 7, 'value': "Samedi"});
    });

    test('week days loaded', () async {
      int index = Random().nextInt(languages.length - 1);
      String language = languages[index];
      List<String> weekDays = daysByLanguage[language]!;

      WeekDaysService service = WeekDaysService(fakeFirestore);
      await service.loadWeekDays(language).then((value) {
        List<String> days = service.getWeekDays();
        expect(days, weekDays);
      });
    });

    test('valid week day is returned', () async {
      int index = Random().nextInt(languages.length - 1);
      String language = languages[index];
      List<String> weekDays = daysByLanguage[language]!;

      WeekDaysService service = WeekDaysService(fakeFirestore);
      await service.loadWeekDays(language).then((value) {
        String weekDay = service.getCurrentWeekDay();
        int weekdayNum = DateTime.now().weekday;
        expect(weekDay, weekDays[weekdayNum]);
      });
    });
  });

  group("Does not have remote data", () {
    test('Returns an empty string', () {
      WeekDaysService service = WeekDaysService(fakeFirestore);
      String weekDay = service.getCurrentWeekDay();
      expect(weekDay, "");
    });
  });
}
