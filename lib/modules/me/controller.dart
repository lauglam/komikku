import 'package:get/get.dart';

import '../../dex/apis/user_api.dart';
import '../login/controller.dart';

class MeController extends GetxController {
  /// The user name.
  final _username = _emptyChar.obs;

  get username => _username.value;

  @override
  void onInit() async {
    final controller = Get.put(LoginController());
    ever(controller.loginStateObs, (callback) async => await _getUsername());
    await _getUsername();
    super.onInit();
  }

  /// Get user name.
  Future<void> _getUsername() async {
    final controller = Get.put(LoginController());
    if (!controller.loginState) {
      _username.value = '  未登录';
      return;
    }

    final res = await UserApi.getUserDetailsAsync();
    _username.value = res.data.attributes.username;
  }

  static const _emptyChar = '';
}
