import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/global_widgets/widgets.dart';
import 'package:komikku/modules/subscribes_module/subscribes_controller.dart';
import 'package:komikku/modules/login_module/login_controller.dart';
import 'package:komikku/dto/manga_dto.dart';

class Subscribes extends StatelessWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // 必须使用一次GetBuilder<SubscribesController>
      // 否则SubscribesController将不会被创建
      child: GetBuilder<SubscribesController>(
        builder: (controller) => Obx(() {
          if (!LoginController.to.loginState) {
            return const Center(
              child: Text('请先登录'),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => controller.pagingController.refresh(),
            child: PagedGridView(
              cacheExtent: 500,
              // 永远滚动，即使在不满屏幕的情况下
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(15),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 0.75,
              ),
              pagingController: controller.pagingController,
              builderDelegate: PagedChildBuilderDelegate<MangaDto>(
                firstPageErrorIndicatorBuilder: (context) => TryAgainExceptionIndicator(
                  onTryAgain: () => controller.pagingController.retryLastFailedRequest(),
                ),
                newPageErrorIndicatorBuilder: (context) => TryAgainIconExceptionIndicator(
                  onTryAgain: () => controller.pagingController.retryLastFailedRequest(),
                ),
                noItemsFoundIndicatorBuilder: (context) => const Center(
                  child: Text('没有订阅的漫画'),
                ),
                itemBuilder: (context, item, index) {
                  return InkWell(
                    onTap: () => Get.toNamed('/details', arguments: item),
                    child: GridViewItem(
                      imageUrl: item.imageUrl256,
                      title: item.title,
                      subtitle: item.status,
                      titleStyle: TitleStyle.footer,
                    ),
                  );
                },
              ),
            ),
          );
        }),
      ),
    );
  }
}
