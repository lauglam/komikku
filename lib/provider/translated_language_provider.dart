import 'package:flutter/cupertino.dart';
import 'package:komikku/database/hive.dart' as hive;

class TranslatedLanguageProvider extends ChangeNotifier {
  var translatedLanguage = <String>[];

  void get() => translatedLanguage = hive.translatedLanguage;

  void set(List<String> value) {
    hive.translatedLanguage = translatedLanguage;
    translatedLanguage = value;

    notifyListeners();
  }
}
