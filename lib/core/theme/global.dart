import 'package:get/get.dart';

import 'theme.dart';

/// Global [GetxService]
class GlobalService extends GetxService {
  /// Is it a dark mode observer.
  final _isDarkModel = Get.isDarkMode.obs;

  /// Get the instance of this.
  static GlobalService get to => Get.find();

  /// Whether is dark mode.
  get isDarkModel => _isDarkModel.value;

  /// Set the mode to dark or not.
  set isDarkModel(value) => _isDarkModel.value = value;

  /// Switch to the opposite theme.
  void switchModel() {
    _isDarkModel.value = !_isDarkModel.value;
    Get.changeTheme(_isDarkModel.value ? AppTheme.dark : AppTheme.light);
  }
}
