import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/message.dart';
import '../../data/services/store.dart';
import '../../dex/apis/auth_api.dart';
import '../../dex/models.dart';

class LoginController extends GetxController {
  /// The form key of login.
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  /// The user email/username.
  String? emailOrUsername;

  /// The user password.
  String? password;

  /// Login state.
  final _loginState = false.obs;

  get loginState => _loginState.value;

  get loginStateObs => _loginState;

  /// [LoginController] 单列
  static LoginController get to => Get.find();

  @override
  void onInit() {
    _loginState.value = StoreService().loginStatus;
    super.onInit();
  }

  /// Login.
  Future<void> login() async {
    formKey.currentState?.save();
    if (!_validate()) return;

    var login = emailOrUsername!.contains('@')
        ? Login(email: emailOrUsername, password: password!)
        : Login(username: emailOrUsername, password: password!);

    final res = await AuthApi.loginAsync(login);
    StoreService().sessionToken = res.token.session;
    StoreService().refreshToken = res.token.refresh;

    _loginState.value = true;
  }

  /// Logout.
  Future<void> logout() async {
    StoreService().sessionToken = null;
    StoreService().refreshToken = null;
    await AuthApi.logoutAsync();

    _loginState.value = false;
  }

  /// Launch in browser.
  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  /// Validate.
  bool _validate() {
    if (emailOrUsername?.isEmpty ?? true) {
      toast('账号不能为空');
      return false;
    }
    if (password?.isEmpty ?? true) {
      toast('密码不能为空');
      return false;
    }
    if (password!.length < 8) {
      toast('密码不能小于8位');
      return false;
    }
    if (password!.length > 1024) {
      toast('密码不能大于1024位');
      return false;
    }

    return true;
  }
}
