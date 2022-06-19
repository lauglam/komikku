import 'package:dio/dio.dart';
import '../models/login.dart';
import '../models/logout.dart';
import '../models/refresh_token.dart';
import '../../core/utils/http.dart';

class AuthApi {
  /// Login.
  static Future<LoginResponse> loginAsync(Login login) async {
    final response =
        await HttpUtil().post('/auth/login', params: login.toJson());
    return LoginResponse.fromJson(response);
  }

  /// Refresh the token.
  static Future<RefreshResponse> refreshAsync(RefreshToken refresh) async {
    final response = await HttpUtil().post(
      '/auth/refresh',
      params: refresh.toJson(),
      // 新建 Options 防止循环调用
      options: Options(),
    );
    return RefreshResponse.fromJson(response);
  }

  /// Logout.
  static Future<LogoutResponse> logoutAsync() async {
    final response = await HttpUtil().post('/auth/logout');
    return LogoutResponse.fromJson(response);
  }
}
