import '../models/response.dart';
import '../models/tag.dart';
import '../util.dart';
import '../models/chapter_list.dart';
import '../models/manga_list.dart';
import '../../core/utils/http.dart';

class MangaApi {
  /// Get manga list.
  static Future<MangaListResponse> getMangaListAsync({
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await HttpUtil().get(buildUri(
      path: '/manga',
      queryParameters: queryParameters,
    ));
    return MangaListResponse.fromJson(res);
  }

  /// Get manga feed by [id].
  static Future<ChapterListResponse> getMangaFeedAsync(
    String id, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await HttpUtil().get(buildUri(
      path: '/manga/$id/feed',
      queryParameters: queryParameters,
    ));
    return ChapterListResponse.fromJson(res);
  }

  /// Followed a manga which id is [id].
  static Future<Response> followMangaAsync(String id) async {
    final res = await HttpUtil().post('/manga/$id/follow');
    return Response.fromJson(res);
  }

  /// Unfollow a manga which id is [id].
  static Future<Response> unfollowMangaAsync(String id) async {
    final res = await HttpUtil().delete('/manga/$id/follow');
    return Response.fromJson(res);
  }

  /// Get manga tag list.
  static Future<TagListResponse> getTagListAsync() async {
    final res = await HttpUtil().get('/manga/tag');
    return TagListResponse.fromJson(res);
  }
}
