import 'package:komikku/dex/models/at_home.dart';
import 'package:komikku/utils/http.dart';

class AtHomeApi {
  static Future<AtHome> getHomeServerUrlAsync(String chapterId) async {
    var response = await HttpUtil().get('/at-home/server/$chapterId');
    return AtHome.fromJson(response);
  }
}
