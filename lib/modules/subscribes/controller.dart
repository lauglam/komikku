import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/services/store.dart';
import '../../dex/apis/follows_api.dart';
import '../../dex/apis/manga_api.dart';
import '../../global_widgets/paging_controller_extent.dart';
import '../../data/dto/manga_dto.dart';

class SubscribesController extends GetxController {
  /// 第一页的[PageKeyType]
  static const _firstPageKey = 0;

  /// 是否正在加载数据
  /// true: 数据正在加载，别的加载请求应该拒绝
  /// false: 没有数据正在加载，可以接受加载请求
  static var _loading = false;

  /// 页面中[SmartRefresher]的控制器
  /// 控制[PagedGridView]的下拉刷新
  final refreshController = RefreshController();

  /// 页面中[PagedGridView]的控制器
  /// 控制[PagedGridView]的刷新、附加数据、错误处理与重试
  final pagingController = PagingControllerExtent<int, MangaDto>(
    firstPageKey: _firstPageKey,
    invisibleItemsThreshold: 6,
  );

  /// 订阅的漫画的id集合
  final RxList<String> followedMangaIds = <String>[].obs;

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
    await MangaApi.unfollowMangaAsync(id);
    refreshController.requestRefresh();
  }

  /// 取消订阅一本漫画
  Future<void> followManga(String id) async {
    followedMangaIds.add(id);
    await MangaApi.followMangaAsync(id);
    refreshController.requestRefresh();
  }

  /// 每页数据的数据量
  static const _pageSize = 20;

  /// 获取用户订阅的漫画
  Future<void> _getUserFollowedMangaList(int pageKey) async {
    if (!StoreService().userLoginState) {
      pagingController.appendPage(<MangaDto>[], 0);
      return;
    }

    try {
      if (_loading) return;
      _loading = true;

      final queryMap = {
        'limit': '$_pageSize',
        'offset': '$pageKey',
        'includes[]': ["cover_art", "author"],
      };

      final response = await FollowsApi.getUserFollowedMangaListAsync(
          queryParameters: queryMap);
      var newItems = response.data.map((e) => MangaDto.fromDex(e)).toList();

      // /user/follows/manga 端点没有contentRating参数，所以需要手动过滤掉
      newItems.removeWhere(
          (e) => !StoreService().contentRating.contains(e.contentRating));

      if (newItems.length < _pageSize) {
        // Last
        pagingController.appendLastPage(newItems);
        refreshController.loadNoData();
      } else {
        var nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
        refreshController.loadComplete();
      }

      refreshController.refreshCompleted();
    } catch (e) {
      pagingController.error = e;
      refreshController.refreshFailed();
      refreshController.loadFailed();
      if (kDebugMode) rethrow;
    } finally {
      _loading = false;
    }
  }
}
