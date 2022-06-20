import 'package:collection/collection.dart';
import 'package:get/get.dart';
import '../../data/services/store.dart';
import '../../dex/apis/chapter_read_marker_api.dart';
import '../../dex/apis/manga_api.dart';
import '../../data/dto/chapter_dto.dart';
import '../../data/dto/manga_dto.dart';

class DetailsController extends GetxController {
  /// Argument from other page - home, search, subscribes
  late final MangaDto data = Get.arguments;

  /// 倒序排序字典
  final Map<String, List<ChapterDto>> descChapters = <String, List<ChapterDto>>{};

  /// 正序排序字典
  final Map<String, List<ChapterDto>> ascChapters = <String, List<ChapterDto>>{};

  /// 章节排序是否是倒序通知
  /// 默认为true
  final RxBool _chapterGridIsDesc = true.obs;

  /// 获取章节排序是否是倒序
  get chapterGridIsDesc => _chapterGridIsDesc.value;

  /// 设置章节排序是否是倒序
  set chapterGridIsDesc(value) => _chapterGridIsDesc.value = value;

  /// 章节阅读记录
  final List<String> chapterReadMarkers = <String>[].obs;

  /// 是否正在加载
  final RxBool loading = false.obs;

  /// [DetailsController]的单例
  static DetailsController get to => Get.find();

  @override
  void onInit() async {
    super.onInit();
    try {
      loading.value = true;
      await Future.wait([_getMangaFeed(), _getMangaReadMarkers()]);
    } finally {
      loading.value = false;
    }
  }

  /// 获取漫画章节
  Future<void> _getMangaFeed() async {
    final queryMap = {
      'limit': '96',
      'offset': '0',
      'contentRating[]': StoreService().contentRating,
      'translatedLanguage[]': StoreService().translatedLanguage,
      'includes[]': ["scanlation_group", "user"],

      // 切勿 readableAt: OrderMode.desc, 否则缺少章节
      'order[volume]': 'desc',
      'order[chapter]': 'desc',
    };

    final res = await MangaApi.getMangaFeedAsync(data.id, queryParameters: queryMap);

    final newItems = res.data.map((e) => ChapterDto.fromDex(e)).toList();

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
  Future<void> _getMangaReadMarkers() async {
    if (!StoreService().loginStatus) return;
    final res = await ChapterReadMarkerApi.getMangaReadMarkersAsync(data.id);
    chapterReadMarkers.addAll(res.data);
  }
}
