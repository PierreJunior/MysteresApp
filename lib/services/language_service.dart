import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  LanguageService(FirebaseFirestore db) {
    _db = db;
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];
  final String collection = 'languages';

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

  Future<List<String>> loadLanguages({List<String>? languageCode}) async {
    _languages.clear();
    var query = _db.collection(collection).where('status', isEqualTo: 1);
    if (languageCode != null) {
      query = query.where('language_code', whereIn: languageCode);
    }

    return await query.get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
      return _languages;
    });
  }

  Future<String?> getLanguageCode(String language) async {
    return await _db
        .collection(collection)
        .where('status', isEqualTo: 1)
        .where('value', isEqualTo: language)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        var doc = event.docs[0];
        return doc.data()['language_code'];
      }

      return null;
    });
  }
}
