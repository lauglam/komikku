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
    final response = await HttpUtil().get(buildUri(
      path: '/manga',
      queryParameters: queryParameters,
    ));
    return MangaListResponse.fromJson(response);
  }

  /// Get manga feed by [id].
  static Future<ChapterListResponse> getMangaFeedAsync(
    String id, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await HttpUtil().get(buildUri(
      path: '/manga/$id/feed',
      queryParameters: queryParameters,
    ));
    return ChapterListResponse.fromJson(response);
  }

  /// Followed a manga which id is [id].
  static Future<Response> followMangaAsync(String id) async {
    final response = await HttpUtil().post('/manga/$id/follow');
    return Response.fromJson(response);
  }

  /// Unfollow a manga which id is [id].
  static Future<Response> unfollowMangaAsync(String id) async {
    final response = await HttpUtil().delete('/manga/$id/follow');
    return Response.fromJson(response);
  }

  /// Get manga tag list.
  static Future<TagListResponse> getTagListAsync() async {
    final response = await HttpUtil().get('/manga/tag');
    return TagListResponse.fromJson(response);
  }
}
