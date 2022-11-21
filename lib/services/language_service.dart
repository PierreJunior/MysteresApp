import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mysteres/global_variable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageService {
  LanguageService() {
    _db = FirebaseFirestore.instance;
  }

  late FirebaseFirestore _db;
  late final List<String> _languages = [];

  List<String> getLanguages() => _languages.toSet().toList();

  Future<String> getDefaultLanguage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(GlobalValue.sharedPreferenceDefaultLanguageKey)!;
  }

  Future<List<String>> loadLanguages() async {
    return await _db.collection('languages').get().then((event) {
      for (var doc in event.docs) {
        _languages.add(doc.data()['value']);
      }
      return _languages;
    });
  }
}
