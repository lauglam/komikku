import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dex/apis/follows_api.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/provider/chapter_read_marker_provider.dart';
import 'package:komikku/provider/follow_provider.dart';
import 'package:komikku/provider/content_rating_provider.dart';
import 'package:komikku/provider/translated_language_provider.dart';
import 'package:komikku/database/hive.dart';
import 'package:komikku/utils/timeago.dart';
import 'package:komikku/views/reading.dart';
import 'package:komikku/widgets/bottom_modal_item.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/delay_pop.dart';
import 'package:komikku/widgets/chip.dart';
import 'package:komikku/utils/toast.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';

part 'details.content.dart';

part 'details.grid.dart';

class Details extends StatefulWidget {
  const Details({Key? key, required this.dto}) : super(key: key);
  final MangaDto dto;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final _followIconValueNotifier = ValueNotifier(false);

  /// 是否正在执行关键任务
  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
    final followProvider = Provider.of<FollowProvider>(context, listen: false);
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
            if (!userLoginState) {
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
                    ChipWarp(widget.dto.tags),

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

              // 主内容
              _DetailsContent(widget.dto.id),
            ],
          ),
        ),
      ),
    );
  }

  /// 检测漫画是否被订阅
  Future<bool> _checkUserFollow() async {
    // 未登录，直接返回false
    if (!userLoginState) {
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
