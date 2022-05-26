import 'package:komikku/utils/http.dart';

class PingApi {
  /// Ping
  static Future<String> pingAsync() async {
    var response = await HttpUtil().get('/ping');
    return response;
  }
}
