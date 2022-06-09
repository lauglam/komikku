import 'package:komikku/dex/models/response.dart';
import 'package:komikku/dex/models/tag.dart';
import 'package:komikku/dex/util.dart';
import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/dex/models/manga_list.dart';
import 'package:komikku/utils/http.dart';

class MangaApi {
  /// Get 漫画列表
  static Future<MangaListResponse> getMangaListAsync({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await HttpUtil().get(buildUri(
      path: '/manga',
      queryParameters: queryParameters,
    ));
    return MangaListResponse.fromJson(response);
  }

  /// Get 漫画章节
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

  /// 订阅漫画
  static Future<Response> followMangaAsync(String id) async {
    final response = await HttpUtil().post('/manga/$id/follow');
    return Response.fromJson(response);
  }

  /// 退订漫画
  static Future<Response> unfollowMangaAsync(String id) async {
    final response = await HttpUtil().delete('/manga/$id/follow');
    return Response.fromJson(response);
  }

  /// 获取标签列表
  static Future<TagListResponse> getTagListAsync() async {
    final response = await HttpUtil().get('/manga/tag');
    return TagListResponse.fromJson(response);
  }
}
