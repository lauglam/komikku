import 'package:komikku/dex/util.dart';
import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/dex/models/manga_list.dart';
import 'package:komikku/dex/models/query/manga_feed_query.dart';
import 'package:komikku/dex/models/query/manga_list_query.dart';
import 'package:komikku/utils/http.dart';

class MangaApi {
  /// Get 漫画列表
  static Future<MangaListResponse> getMangaListAsync({
    MangaListQuery? query,
    String? order,
  }) async {
    var response = await HttpUtil().get(buildUri(
      path: '/manga',
      queryParameters: query?.toJson(),
      order: order,
    ));
    return MangaListResponse.fromJson(response);
  }

  /// Get 漫画章节
  static Future<ChapterListResponse> getMangaFeedAsync(
    String id, {
    MangaFeedQuery? query,
    String? order,
  }) async {
    var response = await HttpUtil().get(buildUri(
      path: '/manga/$id/feed',
      queryParameters: query?.toJson(),
      order: order,
    ));
    return ChapterListResponse.fromJson(response);
  }
}
