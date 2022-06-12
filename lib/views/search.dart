import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/provider/content_rating_provider.dart';
import 'package:komikku/provider/tag_provider.dart';
import 'package:komikku/provider/translated_language_provider.dart';
import 'package:komikku/utils/icons.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/chip.dart';
import 'package:komikku/widgets/indicator.dart';
import 'package:komikku/widgets/list_view_item.dart';
import 'package:komikku/widgets/paged_view/paged_list_view_extent.dart';
import 'package:komikku/widgets/search_bar.dart';
import 'package:provider/provider.dart';

part 'search_advanced.dart';

/// 搜索页面
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final _provider1 = Provider.of<TagProvider>(context, listen: false);
  late final _provider2 = Provider.of<ContentRatingProvider>(context, listen: false);
  late final _provider3 = Provider.of<TranslatedLanguageProvider>(context, listen: false);
  final _pagingController = PagingController<int, MangaDto>(firstPageKey: 0);
  static const _pageSize = 20;
  String _title = '';

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async => await _searchMangaList(pageKey));
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _provider1.clear();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: SearchAppBar(
          hintText: '搜索',
          onSubmitted: (value) {
            _title = value;
            _pagingController.refresh();
          },
        ),
        actions: [
          TextButton(
            child: const Text('取消', style: TextStyle(fontSize: 15, color: Colors.black)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      // 底部高级搜索
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FutureBuilder<void>(
        future: _provider1.get(),
        builder: (context, snapshot) => BuilderChecker(
          snapshot: snapshot,
          onWaiting: const SizedBox.shrink(),
          builder: (context) {
            return FloatingActionButton(
              clipBehavior: Clip.antiAlias,
              child: const Icon(TaoIcons.filter),
              onPressed: () async {
                // 键盘是否是弹起状态
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  FocusManager.instance.primaryFocus?.unfocus();
                }

                showAlertDialog(
                  title: '高级搜索',
                  insetPadding: const EdgeInsets.all(0),
                  onConfirm: () {
                    if (_provider1.selectedTags.isNotEmpty) _pagingController.refresh();
                  },
                  content: SingleChildScrollView(
                    child: AdvancedSearch(
                      tagsGrouped: _provider1.tagsGrouped,
                      selected: (value) => _provider1.selectedTags.values.contains(value),
                      onChanged: (flag, value) {
                        flag ? _provider1.addAll(value) : _provider1.removeValue(value.value);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),

      // 主内容
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 已选标签
            Consumer<TagProvider>(
              builder: (context, provider, child) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CanDeleteChipWarp(
                  values: provider.selectedTags.values.toList(),
                  onDeleted: (value) {
                    provider.removeValue(value);
                    _pagingController.refresh();
                  },
                ),
              ),
            ),

            // 列表内容
            Expanded(
              child: PagedListViewExtent(
                cacheExtent: 500,
                prototypeItem: const ListViewItem(imageUrl: '', title: '', subtitle: ''),
                physics: const AlwaysScrollableScrollPhysics(),
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<MangaDto>(
                  firstPageErrorIndicatorBuilder: (context) => TryAgainExceptionIndicator(
                    onTryAgain: () => _pagingController.retryLastFailedRequest(),
                  ),
                  newPageErrorIndicatorBuilder: (context) => TryAgainIconExceptionIndicator(
                    onTryAgain: () => _pagingController.retryLastFailedRequest(),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                    child: Text('没有找到符合条件的漫画'),
                  ),
                  itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Details(dto: item)),
                      ),
                      child: ListViewItem(
                        imageUrl: item.imageUrl256,
                        title: item.title,
                        subtitle: item.status,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 搜索漫画
  Future<void> _searchMangaList(int pageKey) async {
    _provider2.get();
    _provider3.get();

    final queryMap = {
      'title': _title,
      'limit': '$_pageSize',
      'offset': '$pageKey',
      'contentRating[]': _provider2.contentRating,
      'availableTranslatedLanguage[]': _provider3.translatedLanguage,
      'includes[]': ["cover_art", "author"],
      'includedTags[]': _provider1.selectedTags.keys,
      'order[relevance]': 'desc',
    };

    try {
      final response = await MangaApi.getMangaListAsync(queryParameters: queryMap);

      var newItems = response.data.map((e) => MangaDto.fromDex(e)).toList();
      if (newItems.length < _pageSize) {
        // Last
        _pagingController.appendLastPage(newItems);
      } else {
        var nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
      if (kDebugMode) rethrow;
    }
  }
}
