import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:mysteres/services/week_days_service.dart';

import '../mock.dart';
import '../test_helper.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  test('week days loaded', () async {
    await Firebase.initializeApp();

    final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
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

    await weekDaysCollection.doc('Sunday').set({
      'language_code': '/languages/English ',
      'order': 1,
      'value': "Sunday"
    });
    await weekDaysCollection.doc('Monday').set({
      'language_code': '/languages/English ',
      'order': 2,
      'value': "Monday"
    });
    await weekDaysCollection.doc('Tuesday').set({
      'language_code': '/languages/English ',
      'order': 3,
      'value': "Tuesday"
    });
    await weekDaysCollection.doc('Wednesday').set({
      'language_code': '/languages/English ',
      'order': 4,
      'value': "Wednesday"
    });
    await weekDaysCollection.doc('Thursday').set({
      'language_code': '/languages/English ',
      'order': 5,
      'value': "Thursday"
    });
    await weekDaysCollection.doc('Friday').set({
      'language_code': '/languages/English ',
      'order': 6,
      'value': "Friday"
    });
    await weekDaysCollection.doc('Saturday').set({
      'language_code': '/languages/English ',
      'order': 7,
      'value': "Saturday"
    });
    await weekDaysCollection.doc('Dimanche').set({
      'language_code': '/languages/French ',
      'order': 1,
      'value': "Dimanche"
    });
    await weekDaysCollection.doc('Lundi').set(
        {'language_code': '/languages/French ', 'order': 2, 'value': "Lundi"});
    await weekDaysCollection.doc('Mardi').set(
        {'language_code': '/languages/French ', 'order': 3, 'value': "Mardi"});
    await weekDaysCollection.doc('Mercredi').set({
      'language_code': '/languages/French ',
      'order': 4,
      'value': "Mercredi"
    });
    await weekDaysCollection.doc('Jeudi').set(
        {'language_code': '/languages/French ', 'order': 5, 'value': "Jeudi"});
    await weekDaysCollection.doc('Vendredi').set({
      'language_code': '/languages/French ',
      'order': 6,
      'value': "Vendredi"
    });
    await weekDaysCollection.doc('Samedi').set(
        {'language_code': '/languages/French ', 'order': 7, 'value': "Samedi"});

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await fakeFirestore.collection('week_days').doc('Samedi').get();
    final Map<String, dynamic> actualData = documentSnapshot.data()!;

    print(actualData);

    // LanguageService languageService = LanguageService(fakeFirestore);
    // var langRef = languageService.getLanguageReference("English");

    // WeekDaysService service = WeekDaysService(fakeFirestore);
    // await service.loadWeekDays(langRef).then((value) {
    //   List<String> weekDays = service.getWeekDays();
    //   expect(weekDays,
    //       ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Saturday"]);
    // });
  });
}
