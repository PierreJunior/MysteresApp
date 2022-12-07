import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mysteres/services/language_service.dart';
import 'mock.dart';

void main() {
  setupFirebaseAuthMocks();

  group('default languages', () {
    test('default language service String should be null', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      Future<String?> result = language.getDefaultLanguage();

      await result.then((value) {
        expect(value, null);
      });
      // language.clearLanguagesPrefs();
    });
  });

  group('default a', () {
    test('default a', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      Future<int> result = language.defaultLanguageIsInit();

      await result.then((value) {
        expect(value, 0);
      });
      // language.clearLanguagesPrefs();
    });
  });

  group('default b', () {
    test('default b', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      language.setDefaultLanguage('French');
      var r = language.defaultLanguageIsInit();

      await r.then((value) {
        expect(value, 1);
      });
      // language.clearLanguagesPrefs();
    });

    test('set language', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      language.clearLanguagesPrefs();
      var r = language.getDefaultLanguage();

      await r.then((value) {
        expect(value, null);
      });
    });
  });

  group('default c', () {
    test('default c', () async {
      await Firebase.initializeApp();
      LanguageService language = LanguageService();

      language.setDefaultLanguage('English');
      var r = language.getDefaultLanguage();

      await r.then((value) {
        expect(value, 'English');
      });
      // language.clearLanguagesPrefs();
    });
  });
}
