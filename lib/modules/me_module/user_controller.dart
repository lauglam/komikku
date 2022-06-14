import 'package:get/get.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/apis/user_api.dart';
import 'package:komikku/dex/models.dart';

class UserController extends GetxController {
  /// 用户名
  var username = '';

  /// 登录状态
  final _loginState = false.obs;

  get loginState => _loginState.value;

  /// [UserController] 单列
  static UserController get to => Get.find();

  @override
  void onInit() {
    _loginState.value = HiveDatabase.userLoginState;
    super.onInit();
  }

  /// 登录
  Future<void> login(String emailOrUsername, String password) async {
    var login = emailOrUsername.contains('@')
        ? Login(email: emailOrUsername, password: password)
        : Login(username: emailOrUsername, password: password);

    final loginResponse = await AuthApi.loginAsync(login);
    HiveDatabase.sessionToken = loginResponse.token.session;
    HiveDatabase.refreshToken = loginResponse.token.refresh;

    final userResponse = await UserApi.getUserDetailsAsync();
    username = userResponse.data.attributes.username;
    _loginState.value = true;
  }

  /// 登出
  Future<void> logout() async {
    HiveDatabase.removeSessionToken();
    HiveDatabase.removeRefreshToken();
    await AuthApi.logoutAsync();

    username = '';
    _loginState.value = false;
  }
}
