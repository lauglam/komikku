import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/apis/manga_api.dart';
import 'package:komikku/dto/manga_dto.dart';

class SubscribesController extends GetxController {
  /// 页面中[PagedGridView]的控制器
  /// 控制[PagedGridView]的刷新、附加数据、错误处理与重试
  final pagingController = PagingController<int, MangaDto>(
    firstPageKey: 0,
    invisibleItemsThreshold: 6,
  );

  /// 订阅的漫画的id集合
  final followedMangaIds = <String>[];

  /// [SubscribesController]的单例
  static SubscribesController get to => Get.find();

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) async {
      await _getUserFollowedMangaList(pageKey);

      // Refresh
      if (pageKey == 0) {
        followedMangaIds.clear();
      }

      followedMangaIds.addAll(pagingController.itemList!.map((e) => e.id));
    });

    super.onInit();
  }

  /// 订阅一本漫画
  Future<void> unfollowManga(String id) async {
    followedMangaIds.remove(id);
    update();

    await MangaApi.unfollowMangaAsync(id);
    pagingController.refresh();
  }

  /// 取消订阅一本漫画
  Future<void> followManga(String id) async {
    followedMangaIds.add(id);
    update();

    await MangaApi.followMangaAsync(id);
    pagingController.refresh();
  }

  /// 每页数据的数据量
  static const _pageSize = 20;

  /// 获取用户订阅的漫画
  Future<void> _getUserFollowedMangaList(int pageKey) async {
    if (!HiveDatabase.userLoginState) {
      pagingController.appendPage(<MangaDto>[], 0);
      return;
    }

    final queryMap = {
      'limit': '$_pageSize',
      'offset': '$pageKey',
      'includes[]': ["cover_art", "author"],
    };

    try {
      final response = await FollowsApi.getUserFollowedMangaListAsync(queryParameters: queryMap);
      var newItems = response.data.map((e) => MangaDto.fromDex(e)).toList();

      // /user/follows/manga 端点没有contentRating参数，所以需要手动过滤掉
      newItems.removeWhere((e) => !HiveDatabase.contentRating.contains(e.contentRating));

      if (newItems.length < _pageSize) {
        // Last
        pagingController.appendLastPage(newItems);
      } else {
        var nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
      if (kDebugMode) rethrow;
    }
  }
}
