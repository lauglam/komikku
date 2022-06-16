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
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: BidirectionalListView<String>(
        enableReplayUp: ReadingController.to.current > 0,
        firstReplyUpPageKey:
            ReadingController.to.current - 1 < 0 ? 0 : ReadingController.to.current - 1,
        firstReplyDownPageKey: ReadingController.to.current,
        onReplyUp: (pageKey, append) async {
          var newItems = await ReadingController.to.getChapterPages(pageKey);
          newItems = newItems.reversed.toList();
          append(pageKey - 1, newItems, pageKey == 0);
        },
        onReplyDown: (pageKey, append) async {
          final newItems = await ReadingController.to.getChapterPages(pageKey);
          final isLastPage = pageKey == ReadingController.to.data.length - 1;
          append(pageKey + 1, newItems, isLastPage);
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
