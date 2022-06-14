import 'package:collection/collection.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/subscribes_module/subscribes_controller.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/chapter_read_marker_api.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/apis/manga_api.dart';
import 'package:komikku/dto/chapter_dto.dart';

class DetailsController extends GetxController {
  /// 是否订阅漫画
  /// 更改[_followed]的值，会重建[Obx]中使用了[_followed]的对象
  final _followed = false.obs;

  /// 获取是否订阅漫画
  get followed => _followed.value;

  /// 是否在忙
  var busy = false;

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

  /// 检测漫画是否被订阅
  Future<void> checkUserFollow(String id) async {
    // 未登录，直接返回false
    if (!HiveDatabase.userLoginState) {
      _followed.value = false;
    }

    try {
      await FollowsApi.checkUserFollowsMangaAsync(id);
      _followed.value = true;
    } catch (e) {
      // 返回404，为未订阅
      _followed.value = false;
    }
  }

  /// 处理按钮点击事件
  Future<void> handleOnPress(String id) async {
    // 未登录
    if (!HiveDatabase.userLoginState) {
      showText(text: '请先登录');
      return;
    }

    // 已登录
    if (_followed.value) {
      // 取消订阅确认
      showAlertDialog(
        title: '是否取消订阅',
        cancelText: '再想想',
        onConfirm: () async {
          busy = true;
          showText(text: '已取消订阅');
          _followed.value = !_followed.value;
          await MangaApi.unfollowMangaAsync(id);
          busy = false;

          // 刷新订阅页
          SubscribesController.to.pagingController.refresh();
        },
      );
    } else {
      // 订阅
      busy = true;
      showText(text: '已订阅');
      await MangaApi.followMangaAsync(id);
      _followed.value = !_followed.value;
      busy = false;

      // 刷新订阅页
      SubscribesController.to.pagingController.refresh();
    }
  }

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

    // 此处通知GetX已经加载好了数据
    update();
  }

  /// 获取漫画阅读记录
  Future<void> getMangaReadMarkers(String id) async {
    if (!HiveDatabase.userLoginState) return;
    final response = await ChapterReadMarkerApi.getMangaReadMarkersAsync(id);
    chapterReadMarkers.addAll(response.data);

    // 此处通知GetX已经加载好了数据
    update();
  }

  /// 设置漫画已经阅读
  Future<void> markMangaRead(String id) async {
    if (!HiveDatabase.userLoginState) return;
    await ChapterReadMarkerApi.markChapterRead(id);
    chapterReadMarkers.add(id);
  }
}
