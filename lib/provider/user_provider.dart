import 'package:flutter/cupertino.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/login.dart';
import 'package:komikku/utils/user.dart';

class UserProvider extends ChangeNotifier {
  /// 登录
  Future<void> login(String emailOrUsername, String password) async {
    var login = emailOrUsername.contains('@')
        ? Login(email: emailOrUsername, password: password)
        : Login(username: emailOrUsername, password: password);

    var response = await AuthApi.loginAsync(login);
    await setRefresh(response.token.refresh);
    await setSession(response.token.session);

    notifyListeners();
  }

  /// 登出
  Future<void> logout() async {
    await removeSession();
    await removeRefresh();
    await AuthApi.logoutAsync();

    notifyListeners();
  }
}
