import 'package:komikku/dex/models/login.dart';
import 'package:komikku/dex/models/logout.dart';
import 'package:komikku/dex/models/refresh_token.dart';
import 'package:komikku/utils/http.dart';

class AuthApi {
  /// 登录
  static Future<LoginResponse> loginAsync(Login login) async {
    var response = await HttpUtil().post('/auth/login', params: login.toJson());
    return LoginResponse.fromJson(response);
  }

  /// 刷新令牌
  static Future<RefreshResponse> refreshAsync(RefreshToken refresh) async {
    var response = await HttpUtil().post('/auth/refresh', params: refresh.toJson());
    return RefreshResponse.fromJson(response);
  }

  /// 刷新令牌
  static Future<LogoutResponse> logoutAsync() async {
    var response = await HttpUtil().post('/auth/logout');
    return LogoutResponse.fromJson(response);
  }
}
