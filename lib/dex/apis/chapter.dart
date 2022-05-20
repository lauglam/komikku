import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/utils/http.dart';

class ChapterApi {
  static Future<ChapterListResponse> getChapterListAsync() async {
    var response = await HttpUtil().get("/chapter");
    return ChapterListResponse.fromJson(response);
  }
}
