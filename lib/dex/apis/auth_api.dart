import 'package:dio/dio.dart';
import '../models/login.dart';
import '../models/logout.dart';
import '../models/refresh_token.dart';
import '../../core/utils/http.dart';

class AuthApi {
  /// Login.
  static Future<LoginResponse> loginAsync(Login login) async {
    final res =
        await HttpUtil().post('/auth/login', data: login.toJson());
    return LoginResponse.fromJson(res);
  }

  /// Refresh the token.
  static Future<RefreshResponse> refreshAsync(RefreshToken refresh) async {
    final res = await HttpUtil().post(
      '/auth/refresh',
      data: refresh.toJson(),
      // 新建 Options 防止循环调用
      options: Options(),
    );
    return RefreshResponse.fromJson(res);
  }

  /// Logout.
  static Future<LogoutResponse> logoutAsync() async {
    final res = await HttpUtil().post('/auth/logout');
    return LogoutResponse.fromJson(res);
  }
}
