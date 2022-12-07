import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysteres/services/language_service.dart';
import 'test_helper.dart';
import 'mock.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  SharedPreferences.setMockInitialValues({});
  setupFirebaseAuthMocks();

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
}
