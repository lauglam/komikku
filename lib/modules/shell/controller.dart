import 'package:get/get.dart';
import '../home/page.dart';
import '../me/page.dart';
import '../subscribes/page.dart';

class ShellController extends GetxController {
  /// 页面静态数组
  final pages = const [Home(), Subscribes(), Me()];

  /// 当前所在的页面
  final _currentIndex = 0.obs;

  /// 获取当前所在的页面
  get currentIndex => _currentIndex.value;

  /// 设置当前所在的页面
  set currentIndex(value) => _currentIndex.value = value;

  /// 最后尝试退出的时间
  DateTime? lastPop;

  /// [ShellController]的单例
  static ShellController get to => Get.find();
}
