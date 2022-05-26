import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/dex/models/query/manga_feed_query.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/views/reading.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/chapter_list_view_item.dart';
import 'package:komikku/widgets/delay_pop.dart';
import 'package:komikku/widgets/tags_wrap.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:komikku/utils/toast.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.dto}) : super(key: key);
  final MangaDto dto;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _followIconFlag = ValueNotifier<bool>(false);

  // 是否正在执行关键任务
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    return DelayPop(
      flag: _isBusy,
      duration: const Duration(seconds: 1),
      child: Scaffold(
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
                  // TODO: 下载
                  showText(text: '功能暂未上线，敬请期待');
                },
              );
            }),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          clipBehavior: Clip.antiAlias,
          child: FutureBuilder<bool>(
            future: _checkUserFollow(),
            builder: (context, snapshot) {
              return BuilderChecker(
                snapshot: snapshot,
                indicator: false,
                child: () {
                  _followIconFlag.value = snapshot.data!;
                  return ValueListenableBuilder(
                    valueListenable: _followIconFlag,
                    builder: (context, value, child) {
                      if (_followIconFlag.value) {
                        // 已订阅
                        return const Icon(Icons.star_rounded);
                      }
                      // 未登录/未订阅
                      return const Icon(Icons.star_outline_rounded);
                    },
                  );
                },
              );
            },
          ),
          onPressed: () async {
            // 未登录
            if (!await isLogin) {
              showText(text: '请先登录');
              return;
            }

            // 已登录
            _isBusy = true;
            if (_followIconFlag.value) {
              // 取消订阅确认
              showAlertDialog(
                title: '是否取消订阅',
                cancelText: '再想想',
                onConfirm: () async {
                  showText(text: '已取消订阅');
                  _followIconFlag.value = !_followIconFlag.value;
                  await _unfollowManga();

                  // 刷新subscribes页面
                  bus.emit('refresh_subscribes');
                  _isBusy = false;
                },
              );
            } else {
              // 订阅
              showText(text: '已订阅');
              _followIconFlag.value = !_followIconFlag.value;
              await _followManga();

              // 刷新subscribes页面
              bus.emit('refresh_subscribes');
              _isBusy = false;
            }
          },
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
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.dto.title, style: const TextStyle(fontSize: 20)),
                    TagsWarp(tags: widget.dto.tags),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Text(widget.dto.status, style: const TextStyle(fontSize: 12)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
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
                    child: () => GroupedListView<ChapterDto, String>(
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
        ));

    return chapterListResponse.data.map((e) => ChapterDto.fromSource(e)).toList();
  }

  /// 检测漫画是否被订阅
  Future<bool> _checkUserFollow() async {
    // 未登录，直接返回false
    if (!await isLogin) {
      return false;
    }

    try {
      await FollowsApi.checkUserFollowsMangaAsync(widget.dto.id);
      return true;
    } catch (e) {
      // 返回404，为未订阅
      return false;
    }
  }

  /// 订阅漫画
  Future<void> _followManga() async {
    // 未登录，直接返回
    if (!await isLogin) return;
    await MangaApi.followMangaAsync(widget.dto.id);
  }

  /// 退订漫画
  Future<void> _unfollowManga() async {
    // 未登录，直接返回
    if (!await isLogin) return;

    await MangaApi.unfollowMangaAsync(widget.dto.id);
  }
}
