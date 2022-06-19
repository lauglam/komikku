import 'package:collection/collection.dart';
import 'package:get/get.dart';
import '../../data/services/store.dart';
import '../../dex/apis/chapter_api.dart';
import '../../dex/apis/manga_api.dart';
import '../../dex/models/chapter.dart';

import 'model.dart';

class ChapterController extends GetxController {
  final Rx<List<Entry>> data = Rx<List<Entry>>([]);

  static ChapterController get to => Get.find();

  @override
  void onInit() {
    data.value = Get.arguments;
    // fetchByManId(Get.arguments);
    super.onInit();
  }

  Future<void> fetchByIds(List<String> ids) async {
    final res = await ChapterApi.getChapterListAsync(queryParameters: _q2(ids));
    _to(res.data);
  }

  Future<void> fetchByManId(String mId) async {
    final res = await MangaApi.getMangaFeedAsync(mId, queryParameters: _q3);
    _to(res.data);
  }

  void _to(List<Chapter> c) {
    Entry _toEntry(List<Chapter> c) {
      if (c.length < 2) return Entry(c[0].attributes.title ?? _default);

      final children = c.map((e) => Entry(e.attributes.title ?? _default));
      return Entry(c[0].attributes.chapter ?? _default, children.toList());
    }

    final grouped = c.groupListsBy((e) => e.attributes.chapter);

    final data = <Entry>[];
    for (var value in grouped.values) {
      data.add(_toEntry(value));
    }

    this.data.value = data;
  }

  static const _default = '';
}

_q2(List<String> ids) => {
      'ids[]': ids,
      'contentRating[]': StoreService().contentRating,
      'translatedLanguage[]': StoreService().translatedLanguage,
      'includes[]': ["scanlation_group", "user"],

      // 切勿 readableAt: OrderMode.desc, 否则缺少章节
      'order[volume]': 'desc',
      'order[chapter]': 'desc',
    };

get _q3 => {
      'limit': '96',
      'offset': '0',
      'contentRating[]': StoreService().contentRating,
      'translatedLanguage[]': StoreService().translatedLanguage,
      'includes[]': ["scanlation_group", "user"],

      // 切勿 readableAt: OrderMode.desc, 否则缺少章节
      'order[volume]': 'desc',
      'order[chapter]': 'desc',
    };
