import '../../core/utils/http.dart';
import '../models/chapter.dart';
import '../util.dart';
import '../models/chapter_list.dart';

class ChapterApi {
  /// Get chapter list.
  static Future<ChapterListResponse> getChapterListAsync({
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await HttpUtil().get(buildUri(
      path: '/chapter',
      queryParameters: queryParameters,
    ));
    return ChapterListResponse.fromJson(res);
  }

  /// Get chapter by [id].
  static Future<ChapterResponse> getChapterAsync(
    String id, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final res = await HttpUtil().get(
      buildUri(path: '/chapter/$id', queryParameters: queryParameters),
    );

    return ChapterResponse.fromJson(res);
  }
}
