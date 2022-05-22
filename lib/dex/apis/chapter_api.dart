import 'package:komikku/dex/apis/api_helper.dart';
import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/utils/http.dart';

class ChapterApi {
  static Future<ChapterListResponse> getChapterListAsync({
    Map<String, dynamic>? queryParameters,
    String? order,
  }) async {
    var response = await HttpUtil().get(buildUri(
      path: '/chapter',
      queryParameters: queryParameters,
      order: order,
    ));
    return ChapterListResponse.fromJson(response);
  }
}
