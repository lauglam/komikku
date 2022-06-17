import 'dart:async';

import 'package:get/get.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/retrieving.dart';
import 'package:komikku/modules/details_module/controller.dart';

class ReadingController extends GetxController {
  /// 章节名和id
  final List<String> data = Get.arguments[0];

  /// 当前所处在[chapters]中的位置
  final int current = Get.arguments[1];

  /// 阅读进度
  final RxInt _readingProgress = 0.obs;

  get readingProgress => _readingProgress.value;

  /// [ReadingController]的单例
  static ReadingController get to => Get.find();

  /// 获取章节图片
  Future<List<String>> getChapterPages(int pageKey) async {
    final id = data[pageKey];
    final atHome = await AtHomeApi.getHomeServerUrlAsync(id);

    _markMangaRead(id);

    if (HiveDatabase.dataSaver) {
      return Retrieving.getChapterPagesOnSaver(
        atHome.baseUrl,
        atHome.chapter.hash,
        atHome.chapter.dataSaver,
      );
    } else {
      return Retrieving.getChapterPages(
        atHome.baseUrl,
        atHome.chapter.hash,
        atHome.chapter.data,
      );
    }
  }

  /// 设置漫画已经阅读
  Future<void> _markMangaRead(String id) async {
    if (!HiveDatabase.userLoginState) return;

    final controller = Get.put(DetailsController());
    controller.chapterReadMarkers.add(id);
    await ChapterReadMarkerApi.markChapterRead(id);
  }
}
