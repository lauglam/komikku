import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final LocalStorage _instance = LocalStorage._internal();

  factory LocalStorage() => _instance;

  static SharedPreferences? prefs;

  LocalStorage._internal() {
    _initSP();
  }

  _initSP() async {
    prefs = await SharedPreferences.getInstance();
  }

  save(String key, String value) {
    prefs?.setString(key, value);
  }

  get(String key) {
    return prefs?.get(key);
  }

  remove(String key) {
    prefs?.remove(key);
  }
}
