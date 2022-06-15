import 'package:get/get.dart';

import 'controller.dart';

class ShellBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShellController());
  }
}