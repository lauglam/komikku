import '../../core/utils/http.dart';
import '../models/chapter.dart';
import '../util.dart';
import '../models/chapter_list.dart';

class ChapterApi {
  /// 获取章节列表
  static Future<ChapterListResponse> getChapterListAsync({
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await HttpUtil().get(buildUri(
      path: '/chapter',
      queryParameters: queryParameters,
    ));
    return ChapterListResponse.fromJson(response);
  }

  /// 根据id获取章节
  static Future<ChapterResponse> getChapterAsync(
    String id, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await HttpUtil().get(
      buildUri(path: '/chapter/$id', queryParameters: queryParameters),
    );

    return ChapterResponse.fromJson(response);
  }
}
