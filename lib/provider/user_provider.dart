import 'package:flutter/cupertino.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/login.dart';
import 'package:komikku/database/hive.dart';

class UserProvider extends ChangeNotifier {
  /// 登录
  Future<void> login(String emailOrUsername, String password) async {
    var login = emailOrUsername.contains('@')
        ? Login(email: emailOrUsername, password: password)
        : Login(username: emailOrUsername, password: password);

    final response = await AuthApi.loginAsync(login);
    sessionToken = response.token.session;
    refreshToken = response.token.refresh;

    notifyListeners();
  }

  /// 登出
  Future<void> logout() async {
    removeSessionToken();
    removeRefreshToken();
    await AuthApi.logoutAsync();

    notifyListeners();
  }
}
