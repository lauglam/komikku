import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/paged_grid_view_widget.dart';
import '../../widgets/widgets.dart';
import '../../data/dto/manga_dto.dart';

import 'controller.dart';
import 'widgets/grid_view_item_widget.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: SearchAppBarButton(
          hintText: '搜索',
          onTap: () => Get.toNamed('/search'),
        ),
      ),
      body: PagedGridViewWidget<MangaDto>(
        controller: HomeController.to.refreshController,
        onRefresh: () =>
            HomeController.to.pagingController.refresh(background: true),
        pagingController: HomeController.to.pagingController,
        onTryAgain: () =>
            HomeController.to.pagingController.retryLastFailedRequest(),
        noItemsFoundText: '没有漫画数据',
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
      ),
    );
  }
}
