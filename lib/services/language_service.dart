import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  LanguageService(FirebaseFirestore db) {
    _db = db;
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];

  void clearLanguagesPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  List<String> getLanguages({bool includeEmpty = false}) {
    List<String> languages = _languages.toSet().toList();
    if (includeEmpty) {
      languages.insert(0, "--");
    }

    return languages;
  }

  Future<bool> setDefaultLanguage(String defaultLanguage) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(GlobalValue.sharedPreferenceLanguageSetKey, 1);
    return prefs.setString(
        GlobalValue.sharedPreferenceDefaultLanguageKey, defaultLanguage);
  }

  Future<int> defaultLanguageIsInit() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var prefValue = prefs.getInt(GlobalValue.sharedPreferenceLanguageSetKey);
    if (prefValue == null) {
      return 0;
    }
    return prefValue;
  }

  Future<String?> getDefaultLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(GlobalValue.sharedPreferenceDefaultLanguageKey);
  }

  Future<List<String>> loadLanguages() async {
    return await _db
        .collection('languages')
        .where('status', isEqualTo: 1)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
      return _languages;
    });
  }
}
