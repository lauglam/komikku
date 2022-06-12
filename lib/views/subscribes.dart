import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/database/hive.dart';
import 'package:komikku/provider/provider.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/view_item.dart';
import 'package:komikku/widgets/indicator.dart';
import 'package:komikku/utils/set_state_complain.dart';

class Subscribes extends StatefulWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  State<Subscribes> createState() => _SubscribesState();
}

class _SubscribesState extends State<Subscribes> {
  late final _provider = Provider.of<ContentRatingProvider>(context, listen: false);
  final _pagingController = PagingController<int, MangaDto>(firstPageKey: 0);
  static const _pageSize = 20;
  var _markNeedRefresh = false;

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) async {
      await _getUserFollowedMangaList(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: [
          // 登录后的内容（处于底层）
          RefreshIndicator(
            onRefresh: () async => _pagingController.refresh(),
            child: PagedGridView(
              cacheExtent: 500,
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
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text('没有订阅的漫画'),
                ),
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
          ),

          // 遮盖的内容（处于上层）
          Consumer3<UserProvider, FollowProvider, ContentRatingProvider>(
            builder: (context, provider1, provider2, provider3, child) {
              // 未登录时，此控件会遮盖住[StreamBuilder]
              if (!HiveDatabase.userLoginState) {
                _markNeedRefresh = true;
                return child!;
              }

              if (_markNeedRefresh) {
                noComplain(() => _pagingController.refresh());
              }

              _markNeedRefresh = true;
              return const SizedBox.shrink();
            },
            child: Container(
              color: Colors.white,
              child: const Center(child: Text('请先登录')),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取用户订阅的漫画
  Future<void> _getUserFollowedMangaList(int pageKey) async {
    if (!HiveDatabase.userLoginState) {
      _pagingController.appendPage(<MangaDto>[], 0);
      return;
    }

    final queryMap = {
      'limit': '$_pageSize',
      'offset': '$pageKey',
      'includes[]': ["cover_art", "author"],
    };

    try {
      _provider.get();
      final response = await FollowsApi.getUserFollowedMangaListAsync(queryParameters: queryMap);
      var newItems = response.data.map((e) => MangaDto.fromDex(e)).toList();

      // /user/follows/manga 端点没有contentRating参数，所以需要手动过滤掉
      newItems.removeWhere((e) => !_provider.contentRating.contains(e.contentRating));

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
