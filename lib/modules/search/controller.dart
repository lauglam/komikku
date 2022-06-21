import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/widgets/paging_controller_extent.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../data/services/store.dart';
import '../../dex/apis/manga_api.dart';
import '../../dex/models.dart';
import '../../data/dto/manga_dto.dart';

class SearchController extends GetxController {
  /// The page key for first page.
  static const _firstPageKey = 0;

  /// Whether is loading data.
  static var _loading = false;

  /// The paging controller for [PagedListView]
  final pagingController = PagingControllerExtent<int, MangaDto>(
    firstPageKey: _firstPageKey,
    invisibleItemsThreshold: 6,
  );

  /// The refresh controller for [SmartRefresher].
  final RefreshController refreshController = RefreshController();

  /// GroupTags.
  /// [groupedName, <id, name>].
  final tagsGrouped = <String, Map<String, String>>{}.obs;

  /// Selected tags.
  /// <id, name>.
  final selectedTags = <String, String>{}.obs;

  /// The title for search manga.
  var searchTitle = _emptyChar;

  /// The Shortcut to get [SearchController].
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

  /// Add tag to select tags.
  void addAll(MapEntry<String, String> value) =>
      selectedTags.addEntries([value]);

  /// Remove tag from selected tags.
  void removeValue(String value) =>
      selectedTags.removeWhere((k, v) => v == value);

  /// The size of each page.
  static const _pageSize = 20;

  /// Search manga list.
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
        refreshController.loadNoData();
      } else {
        var nextPageKey = pageKey + items.length;
        pagingController.appendPage(items, nextPageKey);
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

  static const _emptyChar = '';
}
