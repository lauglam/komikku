import 'dart:async';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/models/query/usual_query.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/views/details.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/manga_grid_view_item.dart';

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
    bus.on('login', (arg) => setState(() {}));
    bus.on('logout', (arg) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
    _scrollController.dispose();
  }

  /// 推入流中
  sinkStream({bool refresh = false}) async {
    if (refresh) {
      _cacheMangaList.clear();
      mangaOffset = 0;
    }

    _cacheMangaList.addAll(await _getUserFollowedMangaList());
    _streamController.sink.add(_cacheMangaList);

    /// 设置Chapter查询偏移
    mangaOffset += mangaLimit;
  }

  /// 滚动监听器
  void listener() {
    if (_scrollController.position.atEdge && _scrollController.position.pixels != 0) {
      // on bottom
      sinkStream();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: isLogin,
      builder: (context, snapshot) {
        return BuilderChecker(
          snapshot: snapshot,
          widget: () {
            if (!snapshot.data!) {
              // 未登录
              return const Center(child: Text('请先登录'));
            }

            // 加载数据
            sinkStream();

            // 监听滚动控制器
            _scrollController.removeListener(listener);
            _scrollController.addListener(listener);

            return StreamBuilder<List<MangaDto>>(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                return BuilderChecker(
                  snapshot: snapshot,
                  widget: () => RefreshIndicator(
                    onRefresh: () async {
                      await sinkStream(refresh: true);
                    },
                    child: GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
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
                          child: MangaGridViewItem(
                            dto: snapshot.data![index],
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
