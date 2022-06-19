import '../models/user.dart';
import '../../core/utils/http.dart';

class UserApi {
  /// Get logged user info.
  static Future<UserResponse> getUserDetailsAsync() async {
    final response = await HttpUtil().get('/user/me');
    return UserResponse.fromJson(response);
  }
}
