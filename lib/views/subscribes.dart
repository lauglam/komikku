import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/models/query/usual_query.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/provider/follow_provider.dart';
import 'package:komikku/provider/user_provider.dart';
import 'package:komikku/utils/auth.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/grid_view_item.dart';
import 'package:provider/provider.dart';

class Subscribes extends StatefulWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  State<Subscribes> createState() => _SubscribesState();
}

class _SubscribesState extends State<Subscribes> {
  final _pagingController = PagingController<int, MangaDto>(firstPageKey: 0);
  static const _pageSize = 20;

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
          Consumer2<UserProvider, FollowProvider>(
            builder: (context, userProvider, followProvider, child) => FutureBuilder<bool>(
              future: Auth.userLoginState,
              builder: (context, snapshot) {
                return BuilderChecker(
                  snapshot: snapshot,
                  builder: (context) {
                    // 未登录时，此控件会遮盖住[StreamBuilder]
                    if (!snapshot.data!) {
                      return Container(
                        color: Colors.white,
                        child: const Center(child: Text('请先登录')),
                      );
                    }

                    // 延后1秒钟执行refresh()
                    var delay = const Duration(seconds: 1);
                    (() async => await Future.delayed(delay, () => _pagingController.refresh()))();

                    return const SizedBox.shrink();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// 获取用户订阅的漫画
  Future<void> _getUserFollowedMangaList(int pageKey) async {
    if (!await Auth.userLoginState) {
      _pagingController.appendPage(<MangaDto>[], 0);
      return;
    }

    var response = await FollowsApi.getUserFollowedMangaListAsync(
      query: UsualQuery(limit: _pageSize, offset: pageKey, includes: ['cover_art', 'author']),
    );

    var newItems = response.data.map((e) => MangaDto.fromDex(e)).toList();

    if (newItems.length < _pageSize) {
      // Last
      _pagingController.appendLastPage(newItems);
    } else {
      var nextPageKey = pageKey + newItems.length;
      _pagingController.appendPage(newItems, nextPageKey);
    }
  }
}
