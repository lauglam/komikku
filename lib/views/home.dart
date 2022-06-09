import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/provider/local_setting_provider.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/grid_view_item.dart';
import 'package:komikku/widgets/indicator.dart';
import 'package:komikku/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class LatestUpdate extends StatefulWidget {
  const LatestUpdate({Key? key}) : super(key: key);

  @override
  State<LatestUpdate> createState() => _LatestUpdateState();
}

class _LatestUpdateState extends State<LatestUpdate> {
  final _pagingController = PagingController<int, MangaDto>(firstPageKey: 0);
  late final _provider = Provider.of<LocalSettingProvider>(context, listen: false);
  static const _pageSize = 20;
  var _markNeedRefresh = false;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async => await _getMangaList(pageKey));
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
        titleSpacing: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SearchAppBarButton(
          hintText: '搜索',
          onTap: () => Navigator.pushNamed(context, '/search'),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _pagingController.refresh(),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Consumer<LocalSettingProvider>(
              builder: (context, provider, child) {
                if (_markNeedRefresh) {
                  // 延后1秒钟执行refresh()
                  var delay = const Duration(seconds: 1);
                  Future.delayed(delay, () => _pagingController.refresh());
                }

                _markNeedRefresh = true;
                return const SizedBox.shrink();
              },
            ),
            PagedGridView(
              // 永远滚动，即使在不满屏幕的情况下
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<MangaDto>(
                firstPageErrorIndicatorBuilder: (context) => TryAgainExceptionIndicator(
                  onTryAgain: () => _pagingController.retryLastFailedRequest(),
                ),
                newPageErrorIndicatorBuilder: (context) => TryAgainIconExceptionIndicator(
                  onTryAgain: () => _pagingController.retryLastFailedRequest(),
                ),
                noItemsFoundIndicatorBuilder: (context) => const Center(child: Text('没有漫画数据')),
                itemBuilder: (context, item, index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Details(dto: item)),
                    ),
                    child: GridViewItem(
                      imageUrl: item.imageUrl256,
                      title: item.title,
                      subtitle: item.status,
                      titleStyle: TitleStyle.footer,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 获取漫画列表
  Future<void> _getMangaList(int pageKey) async {
    await _provider.get();

    final queryMap = {
      'limit': '$_pageSize',
      'offset': '$pageKey',
      'contentRating[]': _provider.contentRating,
      'availableTranslatedLanguage[]': _provider.translatedLanguage,
      'includes[]': ["cover_art", "author"],
    };

    try {
      final mangaListResponse = await MangaApi.getMangaListAsync(queryParameters: queryMap);

      final newItems = mangaListResponse.data.map((e) => MangaDto.fromDex(e)).toList();
      if (newItems.length < _pageSize) {
        // Last
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + newItems.length;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }
}
