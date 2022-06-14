import 'package:get/get.dart';

import 'shell_controller.dart';

class ShellBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ShellController());
  }
}