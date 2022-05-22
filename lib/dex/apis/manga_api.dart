import 'package:komikku/dex/apis/api_helper.dart';
import 'package:komikku/dex/models/manga_list.dart';

import '../../utils/http.dart';

class MangaApi {
  static Future<MangaListResponse> getMangaListAsync({
    Map<String, dynamic>? queryParameters,
    String? order,
  }) async {
    var response = await HttpUtil().get(buildUri(
      path: '/manga',
      queryParameters: queryParameters,
      order: order,
    ));
    return MangaListResponse.fromJson(response);
  }
}
