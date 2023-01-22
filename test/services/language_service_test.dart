import 'dart:math';

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
  final List<Map<String, dynamic>> languageData =
      TestHelper.generateLanguageData();
  const List<String> languages = TestHelper.languages;

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
    setUp(() async {
      CollectionReference<Map<String, dynamic>> db =
          fakeFirestore.collection('languages');

      for (Map<String, dynamic> element in languageData) {
        await db.add(element);
      }
    });

    test('load and fetch languages where status == 1', () async {
      LanguageService service = LanguageService(fakeFirestore);
      Future<List<String>> future = service.loadLanguages();
      List<String> matcher = [];
      for (var i in languageData) {
        if (i["status"] == 1) {
          matcher.add(i["value"]);
        }
      }

      await future.then((value) {
        var actual = service.getLanguages();
        expect(actual, matcher);
      });
    });

    test('-- is the first item in the list', () async {
      LanguageService service = LanguageService(fakeFirestore);
      Future<List<String>> future = service.loadLanguages();
      await future.then((value) {
        List<String> langs = service.getLanguages(includeEmpty: true);
        expect(langs[0], "--");
      });
    });

    test('valid language code is returned', () async {
      int index = Random().nextInt(languageData.length);
      String language = languages[index];

      LanguageService service = LanguageService(fakeFirestore);
      await service.loadLanguages().then((value) {
        service.getLanguageCode(language).then((languageCode) {
          expect(TestHelper.languageCodes[languageCode], languageCode);
        });
      });
    });

    test('null languade code is returned when an invalid language is provided',
        () async {
      LanguageService service = LanguageService(fakeFirestore);
      await service.loadLanguages().then((value) {
        service
            .getLanguageCode(TestHelper.generateRandomWord())
            .then((languageCode) {
          expect(languageCode, null);
        });
      });
    });

    test('null languade code is returned when a disabled language is provided',
        () async {
      LanguageService service = LanguageService(fakeFirestore);
      Map<String, dynamic> disbaledLanguage =
          languageData.firstWhere((element) => element['status'] == 0);

      await service.loadLanguages().then((value) {
        service.getLanguageCode(disbaledLanguage["value"]).then((languageCode) {
          expect(languageCode, null);
        });
      });
    });

    test('with language code filter', () async {
      LanguageService service = LanguageService(fakeFirestore);
      List<String> langCodes =
          languageData.map((e) => e['language_code'] as String).toList();

      await service.loadLanguages(languageCode: langCodes).then((value) {
        List<String> matcher = languageData
            .where((element) => element['status'] == 1)
            .where((element) => langCodes.contains(element['language_code']))
            .map((e) => e['value'] as String)
            .toList();
        expect(value, matcher);
      });
    });
  });
}
