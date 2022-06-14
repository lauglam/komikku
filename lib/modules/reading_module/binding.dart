import 'package:get/get.dart';

import 'reading_controller.dart';

class ReadingBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ReadingController());
  }
}
