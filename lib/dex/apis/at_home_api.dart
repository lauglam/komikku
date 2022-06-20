import '../models/at_home.dart';
import '../../core/utils/http.dart';

class AtHomeApi {
  static Future<AtHome> getHomeServerUrlAsync(String chapterId) async {
    final res = await HttpUtil().get('/at-home/server/$chapterId');
    return AtHome.fromJson(res);
  }
}
