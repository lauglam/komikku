import 'package:get/get.dart';

import 'subscribes_controller.dart';

class SubscribesBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubscribesController());
  }
}
