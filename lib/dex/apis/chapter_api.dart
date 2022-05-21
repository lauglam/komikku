import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/utils/http.dart';

class ChapterApi {
  static Future<ChapterListResponse> getChapterListAsync({
    Map<String, dynamic>? queryParameters,
    String? order,
  }) async {
    var uri = Uri(
      path: '/chapter',
      queryParameters: queryParameters,
    );

    var path = uri.toString();
    if (order != null) {
      path = queryParameters == null ? '$path?$order' : '$path&$order';
    }

    var response = await HttpUtil().get(path);
    return ChapterListResponse.fromJson(response);
  }
}
