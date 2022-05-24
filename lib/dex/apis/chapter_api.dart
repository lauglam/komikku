import 'package:komikku/dex/util.dart';
import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/dex/models/query/chapter_list_query.dart';
import 'package:komikku/utils/http.dart';

class ChapterApi {
  static Future<ChapterListResponse> getChapterListAsync({
    ChapterListQuery? query,
    String? order,
  }) async {
    var response = await HttpUtil().get(buildUri(
      path: '/chapter',
      queryParameters: query?.toJson(),
      order: order,
    ));
    return ChapterListResponse.fromJson(response);
  }
}
