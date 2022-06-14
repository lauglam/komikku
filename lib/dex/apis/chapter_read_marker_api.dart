import 'package:komikku/dex/models/chapter_read_marker.dart';
import 'package:komikku/dex/models/response.dart';
import 'package:komikku/dex/util.dart';
import 'package:komikku/core/utils/http.dart';

class ChapterReadMarkerApi {
  /// 获取漫画阅读记录
  static Future<ChapterReadMarkerResponse> getMangaReadMarkersAsync(String id) async {
    final response = await HttpUtil().get('/manga/$id/read');
    return ChapterReadMarkerResponse.fromJson(response);
  }

  /// 根据ids，获取漫画阅读记录
  /// grouped为true时，返回[GroupedChapterReadMarkerResponse]
  /// grouped为false，时返回[ChapterReadMarkerResponse]
  static Future<dynamic> getMangasReadMarkersAsync(List<String> ids, {bool grouped = false}) async {
    final response = await HttpUtil().get(buildUri(
      path: '/manga/read',
      queryParameters: {'ids[]': ids, 'grouped': grouped},
    ));
    if (grouped) return GroupedChapterReadMarkerResponse.fromJson(response);

    return ChapterReadMarkerResponse.fromJson(response);
  }

  /// 批量上传漫画阅读记录
  static Future<Response> batchMangaReadMarkersAsync(
    String id,
    ChapterReadMarkerBatch batch,
  ) async {
    final response = await HttpUtil().post('/manga/$id/read', params: batch.toJson());
    return ChapterReadMarkerResponse.fromJson(response);
  }

  /// 将章节设为已阅读状态
  static Future<Response> markChapterRead(String id) async {
    final response = await HttpUtil().post('/chapter/$id/read');
    return Response.fromJson(response);
  }

  /// 将章节设为未阅读状态
  static Future<Response> markChapterUnread(String id) async {
    final response = await HttpUtil().delete('/chapter/$id/read');
    return Response.fromJson(response);
  }
}
