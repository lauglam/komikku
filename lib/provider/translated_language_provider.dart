import 'package:flutter/cupertino.dart';
import 'package:komikku/database/hive.dart';

class TranslatedLanguageProvider extends ChangeNotifier {
  var translatedLanguage = <String>[];

  void get() => translatedLanguage = HiveDatabase.translatedLanguage;

  void set(List<String> value) {
    HiveDatabase.translatedLanguage = value;
    translatedLanguage = value;

    notifyListeners();
  }
}
