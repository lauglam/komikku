import 'package:flutter/cupertino.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/models/login.dart';
import 'package:komikku/database/local_storage.dart';

class UserProvider extends ChangeNotifier {
  /// 登录
  Future<void> login(String emailOrUsername, String password) async {
    var login = emailOrUsername.contains('@')
        ? Login(email: emailOrUsername, password: password)
        : Login(username: emailOrUsername, password: password);

    final response = await AuthApi.loginAsync(login);
    await LocalStorage.setRefresh(response.token.refresh);
    await LocalStorage.setSession(response.token.session);

    notifyListeners();
  }

  /// 登出
  Future<void> logout() async {
    await LocalStorage.removeSession();
    await LocalStorage.removeRefresh();
    await AuthApi.logoutAsync();

    notifyListeners();
  }
}
