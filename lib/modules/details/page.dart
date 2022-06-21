import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/icons.dart';
import '../../core/utils/message.dart';
import '../../widgets/widgets.dart';
import '../subscribes/controller.dart';
import '../login/controller.dart';

import 'controller.dart';
import 'widgets/chapter_grid_widget.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final detail = Get.put(DetailsController());
    final sub = Get.put(SubscribesController());
    final data = detail.data;

    /// App bar on top.
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      actions: [
        // TODO: 下载
        IconButton(
          icon: const Icon(Icons.downloading, color: Colors.white),
          onPressed: () => toast('功能暂未上线，敬请期待'),
        ),
      ],
    );

    /// Big image on top.
    final bigImg = ExtendedNetworkImage(
      imageUrl: data.imageUrlOriginal,
      fit: BoxFit.fitWidth,
      width: double.infinity,
      height: 220,
    );

    /// Manga summary - title, tags, state, author.
    final summary = Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 漫画名
          Text(data.title, style: Theme.of(context).textTheme.titleLarge),

          // 标签
          ChipWarp(data.tags),

          // 状态
          const Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(data.status, style: Theme.of(context).textTheme.bodySmall),

          // 作者
          const Padding(padding: EdgeInsets.only(bottom: 5)),
          Text(data.author, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );

    /// Button of follow/unfollow.
    final floatButton = Obx(
      () => sub.followedMangaIds.contains(data.id)
          ? BeveledButton(
              '已追',
              icon: const Icon(TaoIcons.favoriteAlreadyAdd),
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              onPressed: () async {
                // 取消订阅确认
                dialog(
                  '是否取消订阅',
                  cancelText: '再想想',
                  onConfirm: () async {
                    toast('已取消订阅');
                    await sub.unfollowManga(data.id);
                  },
                );
              },
            )
          : BeveledButton(
              '追漫',
              icon: const Icon(TaoIcons.favoriteAdd),
              onPressed: () async {
                if (!LoginController.to.loginState) {
                  toast('请先登录');
                  return;
                }

                toast('已订阅');
                await sub.followManga(data.id);
              },
            ),
    );

    /// Button of sort - asc, desc.
    final sortButton = Obx(
      () => Directionality(
        textDirection: TextDirection.rtl,
        child: TextButton.icon(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            foregroundColor: MaterialStateProperty.all(Colors.black54),
          ),
          label: const Text('排序'),
          icon: detail.chapterGridIsDesc
              ? const Icon(Icons.arrow_downward_rounded, size: 18)
              : const Icon(Icons.arrow_upward_rounded, size: 18),
          onPressed: () {
            detail.chapterGridIsDesc = !detail.chapterGridIsDesc;
          },
        ),
      ),
    );

    /// Grid of chapters.
    final chapterGrid = Obx(
      () {
        if (detail.loading.value) return _defaultIndicator;
        return ChapterGridWidget(
          ascChapters: detail.ascChapters,
          descChapters: detail.descChapters,
          isDesc: detail.chapterGridIsDesc,
        );
      },
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [bigImg, summary],
                ),
                Positioned(top: 185, right: 10, child: floatButton),
              ],
            ),
            const Divider(thickness: 0.5, height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: sortButton,
              ),
            ),
            chapterGrid,
          ],
        ),
      ),
    );
  }

  static const _defaultIndicator = ThinProgressIndicator();
}