import '../models/chapter_read_marker.dart';
import '../models/response.dart';
import '../util.dart';
import '../../core/utils/http.dart';

class ChapterReadMarkerApi {
  /// Get the chapter read marker.
  static Future<ChapterReadMarkerResponse> getMangaReadMarkersAsync(String id) async {
    final response = await HttpUtil().get('/manga/$id/read');
    return ChapterReadMarkerResponse.fromJson(response);
  }

  /// Get the chapter read marker by [ids].
  /// grouped is true: return [GroupedChapterReadMarkerResponse]
  /// grouped is false: return [ChapterReadMarkerResponse]
  static Future<dynamic> getMangasReadMarkersAsync(List<String> ids, {bool grouped = false}) async {
    final response = await HttpUtil().get(buildUri(
      path: '/manga/read',
      queryParameters: {'ids[]': ids, 'grouped': grouped},
    ));
    if (grouped) return GroupedChapterReadMarkerResponse.fromJson(response);

    return ChapterReadMarkerResponse.fromJson(response);
  }

  /// Batch mark chapter read.
  static Future<Response> batchMangaReadMarkersAsync(
    String id,
    ChapterReadMarkerBatch batch,
  ) async {
    final response = await HttpUtil().post('/manga/$id/read', params: batch.toJson());
    return ChapterReadMarkerResponse.fromJson(response);
  }

  /// Mark chapter is read which id is [id].
  static Future<Response> markChapterRead(String id) async {
    final response = await HttpUtil().post('/chapter/$id/read');
    return Response.fromJson(response);
  }

  /// Mark chapter is unread which id is [id].
  static Future<Response> markChapterUnread(String id) async {
    final response = await HttpUtil().delete('/chapter/$id/read');
    return Response.fromJson(response);
  }
}
