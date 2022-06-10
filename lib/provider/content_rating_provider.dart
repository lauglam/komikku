import 'package:flutter/cupertino.dart';
import 'package:komikku/database/hive.dart' as hive;

class ContentRatingProvider extends ChangeNotifier {
  var contentRating = <String>[];

  void get() => contentRating = hive.contentRating;

  void set(List<String> value) {
    hive.contentRating = value;
    contentRating = value;

    notifyListeners();
  }
}
