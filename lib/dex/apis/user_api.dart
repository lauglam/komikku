import 'package:komikku/dex/models/user.dart';
import 'package:komikku/utils/http.dart';

class UserApi {
  /// 获取用户信息
  static Future<UserResponse> getUserDetailsAsync() async {
    final response = await HttpUtil().get('/user/me');
    return UserResponse.fromJson(response);
  }
}
