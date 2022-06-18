import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/global_widgets/widgets.dart';

import 'controller.dart';
import 'widgets/bidirectional_list_view.dart';

/// 阅读页
class Reading extends StatelessWidget {
  const Reading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentIndex = ReadingController.to.current;

    final getPages = ReadingController.to.getChapterPages;

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BidirectionalListView<String>(
        enableReplayUp: currentIndex > 0,
        firstReplyUpPageKey: currentIndex - 1 < 0 ? 0 : currentIndex - 1,
        firstReplyDownPageKey: currentIndex,
        onReplyUp: (pageKey, append) async {
          var newItems = await getPages(pageKey);

          newItems = newItems.reversed.toList();
          append(pageKey - 1, newItems, pageKey == 0);
        },
        onReplyDown: (pageKey, append) async {
          final data = ReadingController.to.data;

          final newItems = await getPages(pageKey);
          append(pageKey + 1, newItems, pageKey == data.length - 1);
        },
        itemBuilder: (context, item, index) => ExtendedNetworkImage(
          imageUrl: item,
          fit: BoxFit.fitWidth,
          fadeOutDuration: const Duration(milliseconds: 1),
          progressIndicatorBuilder: (context, url, progress) => SizedBox(
            width: Get.width,
            height: Get.height * 0.5,
            child: Center(
              child: CircularProgressIndicator(
                value: progress.progress,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
