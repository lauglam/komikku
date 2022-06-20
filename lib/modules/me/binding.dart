import 'package:get/get.dart';
import 'controller.dart';

class MeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MeController());
  }
}
