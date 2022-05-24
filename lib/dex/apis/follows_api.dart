import 'package:komikku/dex/apis/api_helper.dart';
import 'package:komikku/dex/models/manga_list.dart';
import 'package:komikku/dex/models/query/usual_query.dart';
import 'package:komikku/utils/http.dart';

class FollowsApi {
  /// 获取用户订阅的漫画列表
  static Future<MangaListResponse> getUserFollowedMangaListAsync({UsualQuery? query}) async {
    var response = await HttpUtil().get(buildUri(
      path: '/user/follows/manga',
      queryParameters: query?.toJson(),
    ));
    return MangaListResponse.fromJson(response);
  }

  /// 检测用户是否订阅某本漫画
  static Future<MangaListResponse> checkUserFollowsMangaAsync(String id) async {
    var response = await HttpUtil().get('/user/follows/manga/$id');
    return MangaListResponse.fromJson(response);
  }
}
