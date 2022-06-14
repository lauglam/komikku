import 'package:komikku/core/utils/http.dart';
import 'package:komikku/dex/util.dart';
import 'package:komikku/dex/models/chapter_list.dart';

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
}
