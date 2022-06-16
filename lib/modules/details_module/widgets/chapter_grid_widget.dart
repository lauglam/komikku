import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/timeago.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/global_widgets/bottom_modal_item.dart';
import 'package:komikku/data/dto/chapter_dto.dart';
import 'package:komikku/modules/details_module/controller.dart';

class ChapterGridWidget extends StatelessWidget {
  const ChapterGridWidget({
    Key? key,
    required this.ascChapters,
    required this.descChapters,
    required this.isDesc,
  }) : super(key: key);

  final Map<String, List<ChapterDto>> ascChapters;
  final Map<String, List<ChapterDto>> descChapters;
  final bool isDesc;

  @override
  Widget build(BuildContext context) {
    final itemsMap = isDesc ? descChapters : ascChapters;
    final ids = ascChapters.values.map((e) => e.first.id).toList();

    return GridView.builder(
      cacheExtent: 500,
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
        final values = itemsMap.values.elementAt(chapterIndex);
        final current = isDesc ? itemsMap.length - chapterIndex - 1 : chapterIndex;

        // 内部方法
        Future<void> _showBottomModal() async {
          await showBottomModal(
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

                        // 不等待
                        DetailsController.to.markMangaRead(values[index].id);

                        // 替换
                        ids[current] = values[index].id;

                        // 跳转到阅读页面
                        Get.toNamed('/details/reading', arguments: [
                          ids,
                          current,
                        ]);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }

        // 单独按钮
        if (values.length < 2) {
          return Obx(
            () {
              // 按钮颜色
              Color buttonColor = Colors.black54;
              ButtonStyle? buttonStyle = ButtonStyle(
                side: MaterialStateProperty.all(const BorderSide(color: Colors.grey)),
              );

              if (values.any((e) => DetailsController.to.chapterReadMarkers.contains(e.id))) {
                buttonColor = Colors.black38;
                buttonStyle = null;
              }

              return OutlinedButton(
                style: buttonStyle,
                // 长按
                onLongPress: () async => await _showBottomModal(),
                onPressed: () {
                  // 不等待
                  DetailsController.to.markMangaRead(values[0].id);

                  // 跳转
                  Get.toNamed('/details/reading', arguments: [
                    ids,
                    isDesc ? itemsMap.length - chapterIndex - 1 : chapterIndex,
                  ]);
                },
                child: Text(
                  '${values[0].chapter ?? (isDesc ? itemsMap.length - chapterIndex - 1 : chapterIndex)}',
                  style: TextStyle(color: buttonColor),
                ),
              );
            },
          );
        }

        // 弹出模态框按钮
        return Obx(
          () {
            // 按钮颜色
            Color buttonColor = Colors.black54;
            ButtonStyle? buttonStyle = ButtonStyle(
              side: MaterialStateProperty.all(const BorderSide(color: Colors.grey)),
            );

            if (values.any((e) => DetailsController.to.chapterReadMarkers.contains(e.id))) {
              buttonColor = Colors.black38;
              buttonStyle = null;
            }

            return OutlinedButton(
              style: buttonStyle,
              child: Text(
                '${values[0].chapter ?? (isDesc ? itemsMap.length - chapterIndex - 1 : chapterIndex)}',
                style: TextStyle(color: buttonColor),
              ),
              onPressed: () async => await _showBottomModal(),
            );
          },
        );
      },
    );
  }
}
