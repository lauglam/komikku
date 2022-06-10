import 'package:flutter/cupertino.dart';
import 'package:komikku/database/hive.dart' as hive;

class DataSaverProvider extends ChangeNotifier {
  var dataSaver = false;

  void get() => dataSaver = hive.dataSaver;

  void set(bool value) {
    hive.dataSaver = value;
    dataSaver = value;

    notifyListeners();
  }
}
