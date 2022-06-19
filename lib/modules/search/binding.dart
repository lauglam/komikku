import 'package:get/get.dart';

import 'controller.dart';

class SearchBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
