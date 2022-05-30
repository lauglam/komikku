import 'dart:async';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/models/query/usual_query.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/grid_view_item.dart';

class Subscribes extends StatefulWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  State<Subscribes> createState() => _SubscribesState();
}

class _SubscribesState extends State<Subscribes> {
  // 在FutureBuilder中包裹StreamBuilder时必须多播
  final _streamController = StreamController<List<MangaDto>>.broadcast();
  final _scrollController = ScrollController();
  final _cacheMangaList = <MangaDto>[];
  int mangaLimit = 40;
  int mangaOffset = 0;

  @override
  void initState() {
    super.initState();

    // 订阅事件
    bus.on('login', (arg) => setState(() => _clear()));
    bus.on('logout', (arg) => setState(() => _clear()));
    bus.on('refresh_subscribes', (arg) => setState(() => _clear()));
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _scrollController.dispose();
  }

  /// 推入流中
  Future<void> _addMangaListToSink({bool refresh = false}) async {
    if (refresh) _clear();

    _cacheMangaList.addAll(await _getUserFollowedMangaList());
    _streamController.sink.add(_cacheMangaList);

    /// 设置Chapter查询偏移
    mangaOffset += mangaLimit;
  }

  /// 滚动监听器
  void listener() {
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
      // on bottom
      _addMangaListToSink();
    }
  }

  /// 清理(登录、登出、刷新时使用)
  void _clear() {
    _cacheMangaList.clear();
    mangaOffset = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureBuilder<bool>(
        future: isLogin,
        builder: (context, snapshot) {
          return BuilderChecker(
            snapshot: snapshot,
            builder: (context) {
              // 未登录
              if (!snapshot.data!) return const Center(child: Text('请先登录'));

              // 加载数据
              _addMangaListToSink();
              // 监听滚动控制器
              _scrollController.removeListener(listener);
              _scrollController.addListener(listener);

              return StreamBuilder<List<MangaDto>>(
                stream: _streamController.stream,
                builder: (context, snapshot) {
                  return BuilderChecker(
                    snapshot: snapshot,
                    builder: (context) => RefreshIndicator(
                      onRefresh: () async {
                        await _addMangaListToSink(refresh: true);
                      },
                      child: GridView.builder(
                        // 永远滚动，即使在不满屏幕的情况下
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(15),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 15,
                          childAspectRatio: 0.75,
                        ),
                        controller: _scrollController,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              /// 在刷新时点击可能会出现index > snapshot.data!.length的情况
                              if (index < snapshot.data!.length) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Details(dto: snapshot.data![index]),
                                  ),
                                );
                              }
                            },
                            child: GridViewItem(
                              imageUrl: snapshot.data![index].imageUrl256,
                              title: snapshot.data![index].title,
                              subtitle: snapshot.data![index].status,
                              titleStyle: TitleStyle.footer,
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  /// 获取用户订阅的漫画
  Future<List<MangaDto>> _getUserFollowedMangaList() async {
    var response = await FollowsApi.getUserFollowedMangaListAsync(
      query: UsualQuery(limit: mangaLimit, offset: mangaOffset, includes: ['cover_art', 'author']),
    );

    return response.data.map((e) => MangaDto.fromSource(e)).toList();
  }
}
