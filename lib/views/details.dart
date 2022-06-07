import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dex/models.dart';
import 'package:komikku/dex/models/chapter_list.dart';
import 'package:komikku/dex/models/query/manga_feed_query.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/provider/follow_provider.dart';
import 'package:komikku/utils/timeago.dart';
import 'package:komikku/utils/auth.dart';
import 'package:komikku/views/reading.dart';
import 'package:komikku/widgets/bottom_modal_item.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/delay_pop.dart';
import 'package:komikku/widgets/chip.dart';
import 'package:komikku/utils/toast.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.dto}) : super(key: key);
  final MangaDto dto;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _followIconValueNotifier = ValueNotifier(false);
  final _orderValueNotifier = ValueNotifier(OrderMode.desc);

  /// 因为需要排序，所以将响应内容缓存
  Future<ChapterListResponse>? _getMangaFeedFuture;

  /// 是否正在执行关键任务
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    var followProvider = Provider.of<FollowProvider>(context, listen: false);

    return DelayPop(
      flag: () => _isBusy,
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
                builder: (context) {
                  _followIconValueNotifier.value = snapshot.data!;
                  return ValueListenableBuilder(
                    valueListenable: _followIconValueNotifier,
                    builder: (context, value, child) {
                      if (_followIconValueNotifier.value) {
                        // 已订阅
                        return const Icon(Icons.star_rounded, size: 25);
                      }
                      // 未登录/未订阅
                      return const Icon(Icons.star_outline_rounded, size: 25);
                    },
                  );
                },
              );
            },
          ),
          onPressed: () async {
            // 未登录
            if (!await Auth.userLoginState) {
              showText(text: '请先登录');
              return;
            }

            // 已登录
            if (_followIconValueNotifier.value) {
              // 取消订阅确认
              showAlertDialog(
                title: '是否取消订阅',
                cancelText: '再想想',
                onConfirm: () async {
                  _isBusy = true;
                  showText(text: '已取消订阅');
                  _followIconValueNotifier.value = !_followIconValueNotifier.value;
                  await followProvider.unfollowManga(widget.dto.id);
                  _isBusy = false;
                },
              );
            } else {
              // 订阅
              _isBusy = true;
              showText(text: '已订阅');
              _followIconValueNotifier.value = !_followIconValueNotifier.value;
              await followProvider.followManga(widget.dto.id);
              _isBusy = false;
            }
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 上方大图
              CachedNetworkImage(
                imageUrl: widget.dto.imageUrlOriginal,
                fit: BoxFit.fitWidth,
                width: double.infinity,
                height: 220,
                errorWidget: (context, url, progress) =>
                    Image.asset('assets/images/image-failed.png'),
              ),

              // 漫画信息
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 漫画名
                    Text(widget.dto.title, style: const TextStyle(fontSize: 20)),

                    // 标签
                    ChipWarp(widget.dto.tags.map((e) => e.name).toList()),

                    // 状态
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Text(widget.dto.status, style: const TextStyle(fontSize: 12)),

                    // 作者
                    const Padding(padding: EdgeInsets.only(bottom: 5)),
                    Text(widget.dto.author, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              const Divider(thickness: 0.5, height: 1),

              // 排序
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: ValueListenableBuilder(
                      valueListenable: _orderValueNotifier,
                      builder: (context, value, child) => TextButton.icon(
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          foregroundColor: MaterialStateProperty.all(Colors.black54),
                        ),
                        label: const Text('排序'),
                        icon: _orderValueNotifier.value == OrderMode.asc
                            ? const Icon(Icons.arrow_upward_rounded, size: 18)
                            : const Icon(Icons.arrow_downward_rounded, size: 18),
                        onPressed: () {
                          if (_orderValueNotifier.value == OrderMode.desc) {
                            _orderValueNotifier.value = OrderMode.asc;
                          } else {
                            _orderValueNotifier.value = OrderMode.desc;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),

              // 内容
              ValueListenableBuilder(
                valueListenable: _orderValueNotifier,
                builder: (context, value, child) => FutureBuilder<List<ChapterDto>>(
                  future: _getMangaFeed(),
                  builder: (context, snapshot) => BuilderChecker(
                    snapshot: snapshot,
                    waiting: const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    builder: (context) => _DetailsGrid(snapshot.data!),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 获取漫画章节
  Future<List<ChapterDto>> _getMangaFeed() async {
    var response = await (_getMangaFeedFuture ??= MangaApi.getMangaFeedAsync(widget.dto.id,
        query: MangaFeedQuery(
          limit: 96,
          offset: 0,
          includes: ['scanlation_group', 'user'],
          translatedLanguage: ['zh', 'zh-hk'],
          contentRating: [
            ContentRating.safe,
            ContentRating.suggestive,
            ContentRating.erotica,
            ContentRating.pornographic,
          ],
        ),
        // 切勿 readableAt: OrderMode.desc, 否则缺少章节
        order: MangaFeedOrder(volume: OrderMode.desc, chapter: OrderMode.desc)));

    var newItems = response.data.map((e) => ChapterDto.fromDex(e)).toList();

    if (!newItems
        .any((value) => value.chapter == null || double.tryParse(value.chapter!) == null)) {
      // 按章节排序
      if (_orderValueNotifier.value == OrderMode.desc) {
        newItems.sortByCompare(
          (value) => double.parse(value.chapter!),
          (double a, double b) => b.compareTo(a),
        );
      } else {
        newItems.sortByCompare(
          (value) => double.parse(value.chapter!),
          (double a, double b) => a.compareTo(b),
        );
      }
    } else {
      // 没有章节，按readableAt排序
      if (_orderValueNotifier.value == OrderMode.desc) {
        newItems.sortByCompare(
          (value) => value.readableAt,
          (DateTime a, DateTime b) => b.compareTo(a),
        );
      } else {
        newItems.sortByCompare(
          (value) => value.readableAt,
          (DateTime a, DateTime b) => a.compareTo(b),
        );
      }
    }

    return newItems;
  }

  /// 检测漫画是否被订阅
  Future<bool> _checkUserFollow() async {
    // 未登录，直接返回false
    if (!await Auth.userLoginState) {
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
}

/// 漫画栅格
class _DetailsGrid extends StatelessWidget {
  const _DetailsGrid(this.chapters, {Key? key}) : super(key: key);

  final List<ChapterDto> chapters;

  @override
  Widget build(BuildContext context) {
    var itemsMap = chapters.groupListsBy((value) => value.chapter);

    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 2,
      ),
      itemCount: itemsMap.length,
      // 必须设置shrinkWrap & physics
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, chapterIndex) {
        var values = itemsMap.values.elementAt(chapterIndex);

        // 因为排序的原因，所以要明确上一章到底位于数组的前一个还是后一个
        // 如果是倒序，则反转
        var ascIndex = chapterIndex;
        var ascArrays = itemsMap.values;
        if (chapters.length > 2 && chapters[0].readableAt.isAfter(chapters[1].readableAt)) {
          ascIndex = itemsMap.length - chapterIndex - 1;
          ascArrays = itemsMap.values.toList().reversed.toList();
        }

        // 弹出模态框按钮
        if (values.length > 1) {
          return OutlinedButton(
            child: Text(
              '${values[0].chapter ?? chapterIndex}',
              style: const TextStyle(color: Colors.black54),
            ),
            onPressed: () async => await showBottomModal(
              context: context,
              title: '第 ${values[0].chapter ?? chapterIndex} 章',
              child: ListView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: values.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Material(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black12,
                      clipBehavior: Clip.antiAlias,
                      child: BottomModalItem(
                        title: '${values[index].title ?? index}',
                        subtitle1: timeAgo(values[index].readableAt),
                        subtitle2: values[index].scanlationGroup ?? '',
                        subtitle3: values[index].uploader ?? '',
                        subtitle4: '共 ${values[index].pages} 页',
                        onTap: () {
                          // 先关闭模态框
                          Navigator.pop(context);

                          // 跳转到阅读页面
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Reading(
                                id: values[index].id,
                                index: ascIndex,
                                arrays: ascArrays,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }

        // 单独按钮
        return OutlinedButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Reading(
                id: values[0].id,
                index: ascIndex,
                arrays: ascArrays,
              ),
            ),
          ),
          child: Text(
            '${values[0].chapter ?? chapterIndex}',
            style: const TextStyle(color: Colors.black54),
          ),
        );
      },
    );
  }
}
