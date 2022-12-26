import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'test_helper.dart';
import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
  });

  group('default languages', () {
    test('default language service String should be null', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      Future<String?> result = language.getDefaultLanguage();

      await result.then((value) {
        expect(value, null);
      });
    });
  });

  group('language service without being initialized', () {
    test('default language init should be 0', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      Future<int> result = language.defaultLanguageIsInit();

      await result.then((value) {
        expect(value, 0);
      });
    });
  });

  group('language service after default language is set', () {
    test('default language init when language is set should be 1', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      String randomWord = TestHelper.generateRandomWord();

      language.setDefaultLanguage(randomWord);
      var r = language.defaultLanguageIsInit();

      await r.then((value) {
        expect(value, 1);
      });
    });

    test('set language after clearing SharedPreferences should be null',
        () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      language.clearLanguagesPrefs();
      var r = language.getDefaultLanguage();

      await r.then((value) {
        expect(value, null);
      });
    });
  });

  group('language service after being initialized', () {
    test('Default language should be equal to language set', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      String randomWord = TestHelper.generateRandomWord();

      language.setDefaultLanguage(randomWord);
      var r = language.getDefaultLanguage();

      await r.then((value) {
        expect(value, randomWord);
      });
    });
  });

  group('fetch data from firestore', () {
    setupFirebaseAuthMocks();
    test('fetch languages and store in a list', () async {
      await Firebase.initializeApp();
      final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();
      List<String> mockList = [];
      CollectionReference<Map<String, dynamic>> db =
          fakeFirestore.collection('languages');

      db.add({'language_code': 'en', 'value': 'English'});
      db.add({'language_code': 'fr', 'value': 'French'});
      db.add({'language_code': 'en', 'value': 'English'});
      db.add({'language_code': 'sw', 'value': 'Swahili'});
      db.add({'language_code': 'pt', 'value': 'Portuguese'});

      await fakeFirestore.collection('languages').get().then((event) {
        for (var doc in event.docs) {
          mockList.add(doc.data()['value']);
        }
        return mockList;
      });
      expect(mockList, isNotEmpty);
    });
  });
}
