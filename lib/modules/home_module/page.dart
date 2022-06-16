import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/global_widgets/widgets.dart';
import 'package:komikku/modules/home_module/controller.dart';
import 'package:komikku/modules/dto/manga_dto.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
      body: SmartRefresher(
        enablePullUp: true,
        controller: HomeController.to.refreshController,
        onRefresh: () =>
            Future.sync(() => HomeController.to.pagingController.refresh(background: true)),
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
          pagingController: HomeController.to.pagingController,
          builderDelegate: PagedChildBuilderDelegate<MangaDto>(
            newPageProgressIndicatorBuilder: (context) => const SizedBox.shrink(),
            firstPageErrorIndicatorBuilder: (context) => TryAgainExceptionIndicator(
              onTryAgain: () => HomeController.to.pagingController.retryLastFailedRequest(),
            ),
            newPageErrorIndicatorBuilder: (context) => TryAgainIconExceptionIndicator(
              onTryAgain: () => HomeController.to.pagingController.retryLastFailedRequest(),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(child: Text('没有漫画数据')),
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
        ),
      ),
    );
  }
}
