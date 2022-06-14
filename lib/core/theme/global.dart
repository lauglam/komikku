import 'package:get/get.dart';

import 'theme.dart';

/// 全局[GetxService]服务
class GlobalService extends GetxService {
  /// 是否是暗色主题的观察者
  /// 更改[_isDarkModel]的值，会重建[Obx]中使用了[_isDarkModel]的对象
  final _isDarkModel = Get.isDarkMode.obs;

  /// 初始化
  Future<GlobalService> init() async {
    return this;
  }

  /// 获取当前实例
  static GlobalService get to => Get.find();

  /// 判断当前主题是否是暗色主题
  get isDarkModel => _isDarkModel.value;

  /// 设置当前主题是否是暗色主题
  set isDarkModel(value) => _isDarkModel.value = value;

  /// 切换到与当前主题相反的主题
  void switchThemeModel() {
    _isDarkModel.value = !_isDarkModel.value;
    Get.changeTheme(_isDarkModel.value ? AppTheme.dark : AppTheme.light);
  }
}
