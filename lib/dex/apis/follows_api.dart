import '../models/response.dart';
import '../util.dart';
import '../models/manga_list.dart';
import '../../core/utils/http.dart';

class FollowsApi {
  /// Get the logged user followed manga list.
  static Future<MangaListResponse> getUserFollowedMangaListAsync({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await HttpUtil().get(buildUri(
      path: '/user/follows/manga',
      queryParameters: queryParameters,
    ));
    return MangaListResponse.fromJson(response);
  }

  /// Check if logged user is follow to a manga.
  /// 404 exception: the logged user is unfollow.
  static Future<Response> checkUserFollowsMangaAsync(String id) async {
    final response = await HttpUtil().get('/user/follows/manga/$id');
    return Response.fromJson(response);
  }
}
