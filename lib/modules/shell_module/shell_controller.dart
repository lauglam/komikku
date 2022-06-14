import 'package:get/get.dart';
import 'package:komikku/modules/home_module/home.dart';
import 'package:komikku/modules/me_module/me.dart';
import 'package:komikku/modules/subscribes_module/subscribes.dart';

class ShellController extends GetxController {
  final pages = const [Home(), Subscribes(), Me()];

  /// 当前所在页数组位置
  final _currentIndex = 0.obs;

  get currentIndex => _currentIndex.value;

  set currentIndex(value) => _currentIndex.value = value;

  /// 最后弹出时间
  final _lastPop = Rx<DateTime?>(null);

  get lastPop => _lastPop.value;

  set lastPop(value) => _lastPop.value = value;

  /// [ShellController]的单例
  static ShellController get to => Get.find();
}
