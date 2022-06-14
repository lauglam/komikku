import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/modules/reading_module/reading_controller.dart';
import 'package:komikku/dto/chapter_dto.dart';
import 'package:komikku/global_widgets/widgets.dart';

/// 阅读页
class Reading extends StatelessWidget {
  const Reading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // 主内容
          GetX<ReadingController>(
            initState: (state) {
              /// 当前的章节id
              /// 因为每个章节可能存在多个扫描组的内容，所以必须明确章节id
              ReadingController.to.currentChapterId = Get.arguments[0] as String;

              /// 当前所处在[chapters]中的位置
              ReadingController.to.currentIndex = Get.arguments[1] as int;

              /// 二维数组
              /// 章节与章节内多个扫描组的内容
              /// 当章节内只有一个扫描组内容时，List.length = 1
              ReadingController.to.chapters = List<Iterable<ChapterDto>>.from(Get.arguments[2]);

              /// 载入本章节图片
              ReadingController.to.getChapterPages();
            },
            builder: (controller) {
              if (controller.loading) {
                return const Center(child: CircularProgressIndicator());
              }
              return ListView.builder(
                controller: controller.scrollController,
                itemCount: controller.pages.length,
                itemBuilder: (context, index) => ExtendedNetworkImage(
                  imageUrl: controller.pages[index],
                  fit: BoxFit.fitWidth,
                  fadeOutDuration: const Duration(milliseconds: 1),
                  progressIndicatorBuilder: (context, url, progress) {
                    return CircularTitleProgressIndicator(
                      title: '${index + 1}',
                      progress: progress.progress,
                    );
                  },
                ),
              );
            },
          ),

          // 右下角显示（阅读进度、章节）
          Align(
            alignment: Alignment.bottomRight,
            child: Material(
              clipBehavior: Clip.antiAlias,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(2),
                topRight: Radius.circular(2),
              ),
              textStyle: const TextStyle(color: Colors.white),
              color: Colors.black54,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                child: Obx(
                  () => Text(
                    '${ReadingController.to.readingProgress} %    '
                    '第 ${ReadingController.to.chapters.elementAt(ReadingController.to.currentIndex).first.chapter ?? ReadingController.to.currentIndex} 章',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
