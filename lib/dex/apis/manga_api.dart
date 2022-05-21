import 'package:komikku/dex/models/manga_list.dart';

import '../../utils/http.dart';

class MangaApi {
  static Future<MangaListResponse> getMangaListAsync({
    Map<String, dynamic>? queryParameters,
    String? order,
  }) async {
    var uri = Uri(
      path: '/manga',
      queryParameters: queryParameters,
    );

    var path = uri.toString();
    if (order != null) {
      path = queryParameters == null ? '$path?$order' : '$path&$order';
    }

    var response = await HttpUtil().get(path);
    return MangaListResponse.fromJson(response);
  }
}
