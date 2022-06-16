import 'package:get/get.dart';

import 'controller.dart';

class DetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChapterController());
  }
}
