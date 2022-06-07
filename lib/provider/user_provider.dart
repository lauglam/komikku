import 'package:flutter/cupertino.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/login.dart';
import 'package:komikku/utils/auth.dart';

class UserProvider extends ChangeNotifier {
  /// 登录
  Future<void> login(String emailOrUsername, String password) async {
    var login = emailOrUsername.contains('@')
        ? Login(email: emailOrUsername, password: password)
        : Login(username: emailOrUsername, password: password);

    var response = await AuthApi.loginAsync(login);
    await Auth.setRefresh(response.token.refresh);
    await Auth.setSession(response.token.session);

    notifyListeners();
  }

  /// 登出
  Future<void> logout() async {
    await Auth.removeSession();
    await Auth.removeRefresh();
    await AuthApi.logoutAsync();

    notifyListeners();
  }
}
