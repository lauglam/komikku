import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/dto/tag_dto.dart';
import 'package:komikku/provider/local_setting_provider.dart';
import 'package:komikku/utils/icons.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/chip.dart';
import 'package:komikku/widgets/indicator.dart';
import 'package:komikku/widgets/list_view_item.dart';
import 'package:komikku/widgets/search_bar.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

part 'search_advanced.dart';

/// 搜索页面
class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late final _provider = Provider.of<LocalSettingProvider>(context, listen: false);
  final _pagingController = PagingController<int, MangaDto>(firstPageKey: 0);
  late final Future<List<TagDto>> _tagFuture = _getTagList();
  final _chipValueNotifier = ValueNotifier(false);
  final _includedTags = <String, String>{};
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
      floatingActionButton: FloatingActionButton(
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
              if (_includedTags.isNotEmpty) _pagingController.refresh();
            },
            content: FutureBuilder<List<TagDto>>(
              future: _tagFuture,
              builder: (context, snapshot) {
                return BuilderChecker(
                  snapshot: snapshot,
                  // 在等待时撑满整个搜索屏幕
                  onWaiting: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  builder: (context) {
                    return SingleChildScrollView(
                      child: AdvancedSearch(
                        tags: snapshot.data!,
                        selected: (value) => _includedTags.values.contains(value),
                        onChanged: (flag, value) {
                          flag
                              ? _includedTags.addAll({value.id: value.name})
                              : _includedTags.remove(value.id);
                          _chipValueNotifier.value = !_chipValueNotifier.value;
                        },
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),

      // 主内容
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 已选标签
            ValueListenableBuilder(
              valueListenable: _chipValueNotifier,
              builder: (context, value, child) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CanDeleteChipWarp(
                  values: _includedTags.values.toList(),
                  onDeleted: (value) {
                    if (_includedTags.values.contains(value)) {
                      _includedTags.removeWhere((k, v) => v == value);
                      _chipValueNotifier.value = !_chipValueNotifier.value;
                    }
                  },
                ),
              ),
            ),

            // 列表内容
            Expanded(
              child: PagedListView(
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
    await _provider.get();

    final queryMap = {
      'title': _title,
      'limit': '$_pageSize',
      'offset': '$pageKey',
      'contentRating[]': _provider.contentRating,
      'availableTranslatedLanguage[]': _provider.translatedLanguage,
      'includes[]': ["cover_art", "author"],
      'includedTags[]': _includedTags.keys,
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
    }
  }

  /// 获取标签列表
  Future<List<TagDto>> _getTagList() async {
    final response = await MangaApi.getTagListAsync();
    return response.data.map((e) => TagDto.fromDex(e)).toList();
  }
}
