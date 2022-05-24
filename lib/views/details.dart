import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/dex/models/query/manga_feed_query.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/views/reading.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/chapter_list_view_item.dart';
import 'package:komikku/widgets/tags_wrap.dart';
import 'package:grouped_list/grouped_list.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.dto}) : super(key: key);
  final MangaDto dto;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
              onPressed: () => Navigator.pop(context),
            );
          },
        ),
        actions: [
          Builder(builder: (context) {
            return IconButton(
              icon: const Icon(
                Icons.downloading,
                color: Colors.white,
              ),
              onPressed: () {
                // TODO: download
              },
            );
          }),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: widget.dto.imageUrlOriginal,
              fit: BoxFit.fitWidth,
              width: double.infinity,
              height: 220,
              errorWidget: (context, url, progress) =>
                  Image.asset('assets/images/image-failed.png'),
            ),
            Container(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.dto.title, style: const TextStyle(fontSize: 20)),
                  TagsWarp(tags: widget.dto.tags),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(widget.dto.status, style: const TextStyle(fontSize: 12)),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 5),
                    child: Text(widget.dto.author, style: const TextStyle(fontSize: 12)),
                  ),
                ],
              ),
            ),
            const Divider(
              thickness: 0.5,
              height: 1,
            ),
            FutureBuilder<List<ChapterDto>>(
              future: _getMangaFeed(),
              builder: (context, snapshot) {
                return BuilderChecker(
                  snapshot: snapshot,
                  widget: () => GroupedListView<ChapterDto, String>(
                    padding: const EdgeInsets.all(15),
                    shrinkWrap: true,
                    elements: snapshot.data!,
                    physics: const NeverScrollableScrollPhysics(),
                    groupBy: (element) => '${element.volume ?? '未成'} 卷',
                    groupSeparatorBuilder: (groupByValue) => Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        groupByValue,
                        textAlign: TextAlign.start,
                        style: const TextStyle(fontSize: 16, color: Colors.black26),
                      ),
                    ),
                    itemBuilder: (context, element) {
                      return InkWell(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Reading(id: element.id)),
                        ),
                        child: ChapterListViewItem(
                          dto: element,
                          imageUrl: widget.dto.imageUrl256,
                        ),
                      );
                    },
                    order: GroupedListOrder.DESC,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 获取漫画章节
  Future<List<ChapterDto>> _getMangaFeed() async {
    var chapterListResponse = await MangaApi.getMangaFeedAsync(widget.dto.id,
        query: MangaFeedQuery(
          limit: 96,
          offset: 0,
          includes: ['scanlation_group', 'user'],
          translatedLanguage: ['zh', 'zh-hk'],
          contentRating: [
            ContentRating.safe,
            ContentRating.suggestive,
            ContentRating.erotica,
            ContentRating.pornographic
          ],
        ),
        order: MangaFeedOrder(
          readableAt: OrderMode.asc,
          volume: OrderMode.desc,
          chapter: OrderMode.desc,
        ).build());

    return chapterListResponse.data.map((e) => ChapterDto.fromSource(e)).toList();
  }
}
