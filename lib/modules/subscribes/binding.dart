import 'package:get/get.dart';

import 'controller.dart';

class SubscribesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscribesController());
  }
}
