import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/toast.dart';
import '../../data/services/store.dart';
import '../../dex/apis/auth_api.dart';
import '../../dex/apis/user_api.dart';
import '../../dex/models.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? emailOrUsername;
  String? password;

  /// 用户名
  var username = '';

  /// 登录状态
  final _loginState = false.obs;

  get loginState => _loginState.value;

  /// [LoginController] 单列
  static LoginController get to => Get.find();

  @override
  void onInit() {
    _loginState.value = StoreService().loginStatus;
    super.onInit();
  }

  /// 登录
  Future<void> login() async {
    formKey.currentState?.save();
    if (!_validate()) return;

    var login = emailOrUsername!.contains('@')
        ? Login(email: emailOrUsername, password: password!)
        : Login(username: emailOrUsername, password: password!);

    final loginResponse = await AuthApi.loginAsync(login);
    StoreService().sessionToken = loginResponse.token.session;
    StoreService().refreshToken = loginResponse.token.refresh;

    final userResponse = await UserApi.getUserDetailsAsync();
    username = userResponse.data.attributes.username;
    _loginState.value = true;
  }

  /// 登出
  Future<void> logout() async {
    StoreService().sessionToken = null;
    StoreService().refreshToken = null;
    await AuthApi.logoutAsync();

    username = '';
    _loginState.value = false;
  }

  /// 跳转浏览器
  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  /// 验证
  bool _validate() {
    if (emailOrUsername?.isEmpty ?? true) {
      showText(text: '账号不能为空');
      return false;
    }
    if (password?.isEmpty ?? true) {
      showText(text: '密码不能为空');
      return false;
    }
    if (password!.length < 8) {
      showText(text: '密码不能小于8位');
      return false;
    }
    if (password!.length > 1024) {
      showText(text: '密码不能大于1024位');
      return false;
    }

    return true;
  }
}
