import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/dto/manga_dto.dart';
import 'package:komikku/global_widgets/widgets.dart';
import 'package:komikku/modules/login_module/controller.dart';
import 'package:komikku/modules/subscribes_module/controller.dart';

import 'controller.dart';
import 'widgets/chapter_grid_widget.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dto = Get.arguments as MangaDto;

    final floatButton = GetBuilder<SubscribesController>(
      builder: (controller) => controller.followedMangaIds.contains(dto.id)
          ? BeveledButton(
              '已追',
              icon: const Icon(TaoIcons.favoriteAlreadyAdd),
              backgroundColor: MaterialStateProperty.all(Colors.grey),
              onPressed: () async {
                // 取消订阅确认
                showAlertDialog(
                  title: '是否取消订阅',
                  cancelText: '再想想',
                  onConfirm: () async {
                    showText(text: '已取消订阅');
                    await controller.unfollowManga(dto.id);
                  },
                );
              },
            )
          : BeveledButton(
              '追漫',
              icon: const Icon(TaoIcons.favoriteAdd),
              onPressed: () async {
                if (!LoginController.to.loginState) {
                  showText(text: '请先登录');
                  return;
                }

                showText(text: '已订阅');
                await controller.followManga(dto.id);
              },
            ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.downloading,
              color: Colors.white,
            ),
            onPressed: () {
              // TODO: 下载
              showText(text: '功能暂未上线，敬请期待');
            },
          ),
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
                      imageUrl: dto.imageUrlOriginal,
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
                          Text(dto.title, style: Theme.of(context).textTheme.titleLarge),

                          // 标签
                          ChipWarp(dto.tags),

                          // 状态
                          const Padding(padding: EdgeInsets.only(bottom: 5)),
                          Text(dto.status, style: Theme.of(context).textTheme.bodySmall),

                          // 作者
                          const Padding(padding: EdgeInsets.only(bottom: 5)),
                          Text(dto.author, style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),

                // 上层-追漫按钮
                Positioned(top: 185, right: 10, child: floatButton),
              ],
            ),

            // 分界线
            const Divider(thickness: 0.5, height: 1),

            // 主内容-章节栅格列表
            Column(
              children: [
                // 排序
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Obx(
                      () => Directionality(
                        textDirection: TextDirection.rtl,
                        child: TextButton.icon(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            foregroundColor: MaterialStateProperty.all(Colors.black54),
                          ),
                          label: const Text('排序'),
                          icon: DetailsController.to.chapterGridIsDesc
                              ? const Icon(Icons.arrow_downward_rounded, size: 18)
                              : const Icon(Icons.arrow_upward_rounded, size: 18),
                          onPressed: () {
                            DetailsController.to.chapterGridIsDesc =
                                !DetailsController.to.chapterGridIsDesc;
                          },
                        ),
                      ),
                    ),
                  ),
                ),

                // 内容
                Futuristic(
                  autoStart: true,
                  futureBuilder: () => Future.wait([
                    DetailsController.to.getMangaFeed(dto.id),
                    DetailsController.to.getMangaReadMarkers(dto.id)
                  ]),
                  errorBuilder: (context, error, execute) {
                    if (kDebugMode) {
                      throw error;
                    }
                    return TryAgainExceptionIndicator(onTryAgain: execute);
                  },
                  dataBuilder: (context, data) => Obx(
                    () => ChapterGridWidget(
                      ascChapters: DetailsController.to.ascChapters,
                      descChapters: DetailsController.to.descChapters,
                      isDesc: DetailsController.to.chapterGridIsDesc,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
