import 'package:get/get.dart';

import 'details_controller.dart';

class DetailsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DetailsController());
  }
}
