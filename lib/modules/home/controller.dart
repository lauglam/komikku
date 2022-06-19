import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/services/store.dart';
import '../../dex/apis/manga_api.dart';
import '../../global_widgets/paging_controller_extent.dart';
import '../../data/dto/manga_dto.dart';

/// [Home]页面的控制器
class HomeController extends GetxController {
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

  /// [HomeController]的单例
  static HomeController get to => Get.find();

  @override
  void onInit() {
    pagingController.addPageRequestListener(
        (pageKey) async => await _getMangaList(pageKey));
    super.onInit();
  }

  /// 每页数据的数据量
  static const _pageSize = 20;

  /// 获取漫画列表
  Future<void> _getMangaList(int pageKey) async {
    try {
      if (_loading) return;
      _loading = true;

      final queryMap = {
        'limit': '$_pageSize',
        'offset': '$pageKey',
        'contentRating[]': StoreService().contentRating,
        'availableTranslatedLanguage[]': StoreService().translatedLanguage,
        'includes[]': ["cover_art", "author"],
      };
      final mangaListResponse =
          await MangaApi.getMangaListAsync(queryParameters: queryMap);

      final newItems =
          mangaListResponse.data.map((e) => MangaDto.fromDex(e)).toList();
      if (newItems.length < _pageSize) {
        // Last
        pagingController.appendLastPage(newItems);
        refreshController.loadNoData();
      } else {
        final nextPageKey = pageKey + newItems.length;
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
