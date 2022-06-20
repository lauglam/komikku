import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/services/store.dart';
import '../../dex/apis/manga_api.dart';
import '../../dex/models.dart';
import '../../data/dto/manga_dto.dart';

class SearchController extends GetxController {
  /// 第一页的[PageKeyType]
  static const _firstPageKey = 0;

  /// 是否正在加载数据
  /// true: 数据正在加载，别的加载请求应该拒绝
  /// false: 没有数据正在加载，可以接受加载请求
  static var _loading = false;

  /// 页面中[PagedGridView]的控制器
  /// 控制[PagedGridView]的刷新、附加数据、错误处理与重试
  final pagingController = PagingController<int, MangaDto>(
    firstPageKey: _firstPageKey,
    invisibleItemsThreshold: 6,
  );

  /// 标签组
  /// 标签所属组名、标签id、标签名
  final tagsGrouped = <String, Map<String, String>>{};

  /// 已选的标签
  /// 标签id、标签名
  final selectedTags = <String, String>{}.obs;

  /// 搜索漫画标题
  var searchTitle = '';

  /// [SearchController]的单例
  static SearchController get to => Get.find();

  @override
  void onInit() async {
    pagingController.addPageRequestListener((pageKey) async {
      await _searchMangaList(pageKey);
    });

    final res = await MangaApi.getTagListAsync();
    tagsGrouped.addAll(
        groupBy<Tag, String>(res.data, (p0) => p0.attributes.group)
            .map((key, value) => MapEntry(key, _to(value))));
    super.onInit();
  }

  /// 添加标签
  void addAll(MapEntry<String, String> value) =>
      selectedTags.addEntries([value]);

  /// 移除标签
  void removeValue(String value) =>
      selectedTags.removeWhere((k, v) => v == value);

  /// 每页数据的数据量
  static const _pageSize = 20;

  /// 搜索漫画
  Future<void> _searchMangaList(int pageKey) async {
    try {
      if (_loading) return;
      _loading = true;

      final queryMap = {
        'title': searchTitle,
        'limit': '$_pageSize',
        'offset': '$pageKey',
        'contentRating[]': StoreService().contentRating,
        'availableTranslatedLanguage[]': StoreService().translatedLanguage,
        'includes[]': ["cover_art", "author"],
        'includedTags[]': selectedTags.keys,
        'order[relevance]': 'desc',
      };
      final res = await MangaApi.getMangaListAsync(queryParameters: queryMap);

      var items = res.data.map((e) => MangaDto.fromDex(e)).toList();
      if (items.length < _pageSize) {
        // Last
        pagingController.appendLastPage(items);
      } else {
        var nextPageKey = pageKey + items.length;
        pagingController.appendPage(items, nextPageKey);
      }
    } catch (e) {
      pagingController.error = e;
      if (kDebugMode) rethrow;
    } finally {
      _loading = false;
    }
  }

  Map<String, String> _to(List<Tag> tags) {
    var value = <String, String>{};
    for (var tag in tags) {
      final nameMap = tag.attributes.name.toJson();
      var name = nameMap.values.first;
      for (var entry in nameMap.entries) {
        if (!StoreService().translatedLanguage.contains(entry.key)) continue;
        name = entry.value;
      }
      value.addAll({tag.id: name});
    }

    return value;
  }
}
