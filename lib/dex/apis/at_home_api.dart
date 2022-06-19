import '../models/at_home.dart';
import '../../core/utils/http.dart';

class AtHomeApi {
  static Future<AtHome> getHomeServerUrlAsync(String chapterId) async {
    final response = await HttpUtil().get('/at-home/server/$chapterId');
    return AtHome.fromJson(response);
  }
}
