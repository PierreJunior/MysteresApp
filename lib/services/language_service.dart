import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  LanguageService() {
    _db = FirebaseFirestore.instance;
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];

  void clearLanguagesPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  List<String> getLanguages() => _languages.toSet().toList();

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
    return await _db.collection('languages').get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
      return _languages;
    });
  }

  Future<DocumentReference<Map<String, dynamic>>> loadLanguageReference(String language) async {
    return _db.collection('languages').doc(language);
  }
}
