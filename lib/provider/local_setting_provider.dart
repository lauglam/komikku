import 'package:flutter/cupertino.dart';
import 'package:komikku/database/local_storage.dart';

class LocalSettingProvider extends ChangeNotifier {
  var contentRating = <String>[];
  var translatedLanguage = <String>[];

  /// 获取
  Future<void> get() async {
    contentRating = await LocalStorage.contentRating;
    translatedLanguage = await LocalStorage.translatedLanguage;
  }

  /// 插入或更新
  Future<void> set({List<String>? contentRating, List<String>? translatedLanguage}) async {
    if (contentRating == null && translatedLanguage == null) {
      throw Exception('Invalid operation');
    }

    if (contentRating != null) {
      await LocalStorage.setContentRating(contentRating);
      this.contentRating = contentRating;
    }

    if (translatedLanguage != null) {
      await LocalStorage.setContentRating(translatedLanguage);
      this.translatedLanguage = translatedLanguage;
    }

    notifyListeners();
  }
}
