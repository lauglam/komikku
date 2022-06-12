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
    HiveDatabase.sessionToken = response.token.session;
    HiveDatabase.refreshToken = response.token.refresh;

    notifyListeners();
  }

  /// 登出
  Future<void> logout() async {
    HiveDatabase.removeSessionToken();
    HiveDatabase.removeRefreshToken();
    await AuthApi.logoutAsync();

    notifyListeners();
  }
}
