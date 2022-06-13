import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komikku/dex/apis.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/database/hive.dart';
import 'package:komikku/provider/provider.dart';
import 'package:komikku/utils/utils.dart';
import 'package:komikku/views/reading.dart';
import 'package:collection/collection.dart';
import 'package:komikku/widgets/widgets.dart';

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

  late final _followProvider = Provider.of<FollowProvider>(context, listen: false);

  bool _isBusy = false;

  @override
  Widget build(BuildContext context) {
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
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 上半部分-大图、漫画信息和追漫按钮
              Stack(
                children: [
                  // 下层-大图和漫画信息
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 上方大图
                      ExtendedNetworkImage(
                        imageUrl: widget.dto.imageUrlOriginal,
                        fit: BoxFit.fitWidth,
                        width: double.infinity,
                        height: 220,
                      ),

                      // 漫画信息
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 漫画名
                            Text(widget.dto.title, style: Theme.of(context).textTheme.titleLarge),

                            // 标签
                            ChipWarp(widget.dto.tags),

                            // 状态
                            const Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text(widget.dto.status, style: Theme.of(context).textTheme.bodySmall),

                            // 作者
                            const Padding(padding: EdgeInsets.only(bottom: 5)),
                            Text(widget.dto.author, style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // 上层-追漫按钮
                  Positioned(
                    top: 185,
                    right: 10,
                    child: Futuristic<bool>(
                      futureBuilder: () => _checkUserFollow(),
                      autoStart: true,
                      // 占位
                      busyBuilder: (context) =>
                          BeveledButton('', icon: const SizedBox.shrink(), onPressed: () {}),
                      dataBuilder: (context, value) {
                        _followIconValueNotifier.value = value;
                        return ValueListenableBuilder(
                          valueListenable: _followIconValueNotifier,
                          builder: (context, value, child) {
                            if (_followIconValueNotifier.value) {
                              // 已订阅
                              return BeveledButton(
                                '已追',
                                icon: const Icon(TaoIcons.favoriteAlreadyAdd),
                                backgroundColor: MaterialStateProperty.all(Colors.grey),
                                onPressed: () async => _handleOnPress(),
                              );
                            }

                            // 未登录/未订阅
                            return BeveledButton(
                              '追漫',
                              icon: const Icon(TaoIcons.favoriteAdd),
                              onPressed: () async => _handleOnPress(),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),

              // 分界线
              const Divider(thickness: 0.5, height: 1),

              // 主内容-章节栅格列表
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
    if (!HiveDatabase.userLoginState) {
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

  Future<void> _handleOnPress() async {
    // 未登录
    if (!HiveDatabase.userLoginState) {
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
          await _followProvider.unfollowManga(widget.dto.id);
          _isBusy = false;
        },
      );
    } else {
      // 订阅
      _isBusy = true;
      showText(text: '已订阅');
      _followIconValueNotifier.value = !_followIconValueNotifier.value;
      await _followProvider.followManga(widget.dto.id);
      _isBusy = false;
    }
  }
}
