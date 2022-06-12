import 'package:flutter/cupertino.dart';
import 'package:komikku/database/hive.dart';

class ContentRatingProvider extends ChangeNotifier {
  var contentRating = <String>[];

  void get() => contentRating = HiveDatabase.contentRating;

  void set(List<String> value) {
    HiveDatabase.contentRating = value;
    contentRating = value;

    notifyListeners();
  }
}
