import 'package:komikku/dex/models/response.dart';
import 'package:komikku/dex/util.dart';
import 'package:komikku/dex/models/manga_list.dart';
import 'package:komikku/core/utils/http.dart';

class FollowsApi {
  /// 获取用户订阅的漫画列表
  static Future<MangaListResponse> getUserFollowedMangaListAsync({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await HttpUtil().get(buildUri(
      path: '/user/follows/manga',
      queryParameters: queryParameters,
    ));
    return MangaListResponse.fromJson(response);
  }

  /// 检测用户是否订阅某本漫画
  static Future<Response> checkUserFollowsMangaAsync(String id) async {
    final response = await HttpUtil().get('/user/follows/manga/$id');
    return Response.fromJson(response);
  }
}
