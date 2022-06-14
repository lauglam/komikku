import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dto/manga_dto.dart';

class SubscribesController extends GetxController {
  final pagingController = PagingController<int, MangaDto>(firstPageKey: 0);
  static const _pageSize = 20;

  /// [SubscribesController]的单例
  static SubscribesController get to => Get.find();

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) async {
      await _getUserFollowedMangaList(pageKey);
    });

    super.onInit();
  }

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
