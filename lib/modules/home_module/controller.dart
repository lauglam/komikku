import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/manga_api.dart';
import 'package:komikku/dto/manga_dto.dart';

/// [Home]页面的控制器
class HomeController extends GetxController {
  /// 页面中[PagedGridView]的控制器
  /// 控制[PagedGridView]的刷新、附加数据、错误处理与重试
  final pagingController = PagingController<int, MangaDto>(
    firstPageKey: 0,
    invisibleItemsThreshold: 6,
  );

  /// [HomeController]的单例
  static HomeController get to => Get.find();

  @override
  void onInit() {
    pagingController.addPageRequestListener((pageKey) async => await _getMangaList(pageKey));
    super.onInit();
  }

  /// 每页数据的数据量
  static const _pageSize = 20;

  /// 获取漫画列表
  Future<void> _getMangaList(int pageKey) async {
    final queryMap = {
      'limit': '$_pageSize',
      'offset': '$pageKey',
      'contentRating[]': HiveDatabase.contentRating,
      'availableTranslatedLanguage[]': HiveDatabase.translatedLanguage,
      'includes[]': ["cover_art", "author"],
    };

    try {
      final mangaListResponse = await MangaApi.getMangaListAsync(queryParameters: queryMap);

      final newItems = mangaListResponse.data.map((e) => MangaDto.fromDex(e)).toList();
      if (newItems.length < _pageSize) {
        // Last
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
      if (kDebugMode) rethrow;
    }
  }
}
