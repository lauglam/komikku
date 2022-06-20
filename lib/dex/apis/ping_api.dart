import '../../core/utils/http.dart';

class PingApi {
  /// Ping
  static Future<String> pingAsync() async {
    final res = await HttpUtil().get('/ping');
    return res;
  }
}
