import '../models/user.dart';
import '../../core/utils/http.dart';

class UserApi {
  /// 获取用户信息
  static Future<UserResponse> getUserDetailsAsync() async {
    final response = await HttpUtil().get('/user/me');
    return UserResponse.fromJson(response);
  }
}
