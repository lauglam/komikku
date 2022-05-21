import 'dart:async';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/widgets/grid_items_layout.dart';

class LatestUpdate extends StatefulWidget {
  const LatestUpdate({Key? key}) : super(key: key);

  @override
  State<LatestUpdate> createState() => _LatestUpdateState();
}

class _LatestUpdateState extends State<LatestUpdate> {
  final _streamController = StreamController<List<MangaDto>>();
  final _scrollController = ScrollController();
  final _cacheMangaList = <MangaDto>[];
  int chapterLimit = 20;
  int chapterOffset = 0;

  @override
  void initState() {
    super.initState();
    sinkStream();

    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          // on top
        } else {
          // on bottom
          sinkStream();
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _streamController.close();
  }

  sinkStream() async {
    _cacheMangaList.addAll(await _getMangaList());
    _streamController.sink.add(_cacheMangaList);
    chapterOffset += chapterLimit;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MangaDto>>(
      stream: _streamController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.none) {
          return const Center(child: Text('无数据'));
        } else if (snapshot.hasError) {
          return Center(child: Text('出现错误${snapshot.error}'));
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(
            onRefresh: () {
              sinkStream();
              return Future.value();
            },
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 0.75,
              ),
              shrinkWrap: true,
              controller: _scrollController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GridItemsLayout(
                  dto: snapshot.data![index],
                  titleStyle: TitleStyle.footer,
                );
              },
            ),
          );
        }
      },
    );
  }

  /// 获取漫画列表
  Future<List<MangaDto>> _getMangaList() async {
    var distinctChapters = <Chapter>[];

    var chapterListResponse = await ChapterApi.getChapterListAsync(
      queryParameters: ChapterListQuery(
        limit: chapterLimit,
        offset: chapterOffset,
        includes: ['manga', 'scanlation_group'],
        translatedLanguage: ['zh', 'zh-hk'],
        contentRating: [
          ContentRating.safe,
          ContentRating.suggestive,
          ContentRating.erotica,
          ContentRating.pornographic
        ],
      ).toJson(),
      order: ChapterListOrder(readableAt: OrderMode.desc).build(),
    );

    /// NOTE: 必须含有 MangaAttributes
    var mangaIds = chapterListResponse.data
        .map((chapter) => chapter.relationships.firstType(EntityType.manga).id)
        .toSet();
    for (var id in mangaIds) {
      distinctChapters.add(chapterListResponse.data.firstWhere(
          (item) => item.relationships.firstType(EntityType.manga).id == id));
    }

    var mangaListResponse = await MangaApi.getMangaListAsync(
      queryParameters: MangaListQuery(
        // ids: mangaIds.toList(),
        limit: 20,
        offset: chapterOffset,
        includes: ['cover_art', 'author'],
        contentRating: [
          ContentRating.safe,
          ContentRating.suggestive,
          ContentRating.erotica,
          ContentRating.pornographic
        ],
      ).toJson(),
    );
    return mangaListResponse.data.map((e) => MangaDto.fromSource(e)).toList();
  }
}
