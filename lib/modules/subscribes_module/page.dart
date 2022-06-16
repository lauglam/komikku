import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/global_widgets/paged_grid_view_widget.dart';
import 'package:komikku/modules/login_module/controller.dart';
import 'package:komikku/modules/dto/manga_dto.dart';

import 'controller.dart';
import 'widgets/grid_view_item_widget.dart';

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
          return PagedGridViewWidget<MangaDto>(
            controller: controller.refreshController,
            onRefresh: () => controller.pagingController.refresh(background: true),
            pagingController: controller.pagingController,
            onTryAgain: () => controller.pagingController.retryLastFailedRequest(),
            noItemsFoundText: '没有订阅的漫画',
            itemBuilder: (context, item, index) {
              return InkWell(
                onTap: () => Get.toNamed('/details', arguments: item),
                child: GridViewItemWidget(
                  imageUrl: item.imageUrl256,
                  title: item.title,
                  subtitle: item.status,
                  titleStyle: TitleStyle.footer,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
