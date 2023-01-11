import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysteres/services/language_service.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mock.dart';
import '../test_helper.dart';

void main() {
  setupFirebaseAuthMocks();
  final FakeFirebaseFirestore fakeFirestore = FakeFirebaseFirestore();

  setUpAll(() async {
    await Firebase.initializeApp();
    SharedPreferences.setMockInitialValues({});
  });

  group('language service without being initialized', () {
    test('default language should be null', () async {
      LanguageService service = LanguageService(fakeFirestore);

      Future<String?> result = service.getDefaultLanguage();

      await result.then((value) {
        expect(value, null);
      });
    });

    test('default language init should be 0', () async {
      LanguageService service = LanguageService(fakeFirestore);

      Future<int> result = service.defaultLanguageIsInit();

      await result.then((value) {
        expect(value, 0);
      });
    });

    test('getLanguages returns empty list', () async {
      LanguageService service = LanguageService(fakeFirestore);

      List<String> languages = service.getLanguages();
      expect([], languages);
    });

    test('getLanguages returns -- as single entry', () async {
      LanguageService service = LanguageService(fakeFirestore);

      List<String> languages = service.getLanguages(includeEmpty: true);
      expect(["--"], languages);
    });
  });

  group('language service after default language is set', () {
    test('default language init when language is set should be 1', () async {
      LanguageService service = LanguageService(fakeFirestore);

      String randomWord = TestHelper.generateRandomWord();

      service.setDefaultLanguage(randomWord);
      Future<int> r = service.defaultLanguageIsInit();

      await r.then((value) {
        expect(value, 1);
      });
    });

    test('set language after clearing SharedPreferences should be null',
        () async {
      LanguageService service = LanguageService(fakeFirestore);

      service.clearLanguagesPrefs();
      Future<String?> r = service.getDefaultLanguage();

      await r.then((value) {
        expect(value, null);
      });
    });
  });

  group('language service after being initialized', () {
    test('Default language should be equal to language set', () async {
      LanguageService service = LanguageService(fakeFirestore);

      String randomWord = TestHelper.generateRandomWord();

      service.setDefaultLanguage(randomWord);
      Future<String?> r = service.getDefaultLanguage();

      await r.then((value) {
        expect(value, randomWord);
      });
    });
  });

  group('fetch data from firestore', () {
    test('load and fetch languages', () async {
      CollectionReference<Map<String, dynamic>> db =
          fakeFirestore.collection('languages');

      await db.add({'language_code': 'en', 'value': 'English', 'status': 1});
      await db.add({'language_code': 'fr', 'value': 'French', 'status': 0});
      await db.add({'language_code': 'en', 'value': 'English', 'status': 1});
      await db.add({'language_code': 'sw', 'value': 'Swahili', 'status': 1});
      await db.add({'language_code': 'pt', 'value': 'Portuguese', 'status': 0});

      LanguageService service = LanguageService(fakeFirestore);
      Future<List<String>> future = service.loadLanguages();
      await future.then((value) {
        var langs = service.getLanguages();
        expect(langs, ["English", "Swahili"]);
      });
    });

    test('-- is the first item in the list', () async {
      CollectionReference<Map<String, dynamic>> db =
          fakeFirestore.collection('languages');

      await db.add({'language_code': 'en', 'value': 'English', 'status': 1});
      await db.add({'language_code': 'fr', 'value': 'French', 'status': 0});
      await db.add({'language_code': 'en', 'value': 'English', 'status': 1});
      await db.add({'language_code': 'sw', 'value': 'Swahili', 'status': 1});
      await db.add({'language_code': 'pt', 'value': 'Portuguese', 'status': 0});

      LanguageService service = LanguageService(fakeFirestore);
      Future<List<String>> future = service.loadLanguages();
      await future.then((value) {
        List<String> langs = service.getLanguages(includeEmpty: true);
        expect(langs[0], "--");
      });
    });
  });
}
