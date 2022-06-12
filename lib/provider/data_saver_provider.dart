import 'package:flutter/cupertino.dart';
import 'package:komikku/database/hive.dart';

class DataSaverProvider extends ChangeNotifier {
  var dataSaver = false;

  void get() => dataSaver = HiveDatabase.dataSaver;

  void set(bool value) {
    HiveDatabase.dataSaver = value;
    dataSaver = value;

    notifyListeners();
  }
}
