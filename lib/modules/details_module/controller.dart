import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/chapter_read_marker_api.dart';
import 'package:komikku/dex/apis/manga_api.dart';
import 'package:komikku/modules/dto/chapter_dto.dart';

class DetailsController extends GetxController {
  /// 章节排序是否是倒序通知
  /// 默认为true
  final _chapterGridIsDesc = true.obs;

  /// 获取章节排序是否是倒序
  get chapterGridIsDesc => _chapterGridIsDesc.value;

  /// 设置章节排序是否是倒序
  set chapterGridIsDesc(value) => _chapterGridIsDesc.value = value;

  /// 章节阅读记录
  final chapterReadMarkers = <String>[].obs;

  /// 倒序排序字典
  final descChapters = <String, List<ChapterDto>>{};

  /// 正序排序字典
  final ascChapters = <String, List<ChapterDto>>{};

  /// [DetailsController]的单例
  static DetailsController get to => Get.find();

  /// 获取漫画章节
  Future<void> getMangaFeed(String id) async {
    final queryMap = {
      'limit': '96',
      'offset': '0',
      'contentRating[]': HiveDatabase.contentRating,
      'translatedLanguage[]': HiveDatabase.translatedLanguage,
      'includes[]': ["scanlation_group", "user"],

      // 切勿 readableAt: OrderMode.desc, 否则缺少章节
      'order[volume]': 'desc',
      'order[chapter]': 'desc',
    };

    final response = await MangaApi.getMangaFeedAsync(id, queryParameters: queryMap);

    final newItems = response.data.map((e) => ChapterDto.fromDex(e)).toList();

    if (!newItems
        .any((value) => value.chapter == null || double.tryParse(value.chapter!) == null)) {
      // 按章节排序
      descChapters.addAll(newItems
          .sortedByCompare(
            (value) => double.parse(value.chapter!),
            (double a, double b) => b.compareTo(a),
          )
          .groupListsBy(
            (e) => e.chapter!,
          ));

      ascChapters.addAll(newItems
          .sortedByCompare(
            (value) => double.parse(value.chapter!),
            (double a, double b) => a.compareTo(b),
          )
          .groupListsBy(
            (e) => e.chapter!,
          ));
    } else {
      // 没有章节，按readableAt排序
      descChapters.addAll(newItems
          .sortedByCompare(
            (value) => value.readableAt,
            (DateTime a, DateTime b) => b.compareTo(a),
          )
          .groupListsBy(
            (e) => '${e.readableAt}',
          ));

      ascChapters.addAll(newItems
          .sortedByCompare(
            (value) => value.readableAt,
            (DateTime a, DateTime b) => a.compareTo(b),
          )
          .groupListsBy(
            (e) => '${e.readableAt}',
          ));
    }
  }

  /// 获取漫画阅读记录
  Future<void> getMangaReadMarkers(String id) async {
    if (!HiveDatabase.userLoginState) return;
    final response = await ChapterReadMarkerApi.getMangaReadMarkersAsync(id);
    chapterReadMarkers.addAll(response.data);
  }

  /// 设置漫画已经阅读
  Future<void> markMangaRead(String id) async {
    if (!HiveDatabase.userLoginState) return;
    await ChapterReadMarkerApi.markChapterRead(id);
    chapterReadMarkers.add(id);
  }
}
