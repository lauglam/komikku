import 'package:flutter/cupertino.dart';
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
    final controller = Get.put(HomeController());
    final paging = controller.pagingController;

    /// The search bar for go to search.
    final search = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: CupertinoSearchTextField(
        placeholder: 'Search',
        onTap: () => Get.toNamed('/search'),
        focusNode: AlwaysDisabledFocusNode(),
      ),
    );

    /// App bar.
    final appBar = AppBar(
      titleSpacing: 0,
      elevation: 0,
      toolbarHeight: 60,
      backgroundColor: Colors.transparent,
      title: search,
    );

    return Scaffold(
      appBar: appBar,
      body: PagedGridViewWidget<MangaDto>(
        pagingController: paging,
        onRefresh: () => paging.refresh(background: true),
        onTryAgain: () => paging.retryLastFailedRequest(),
        controller: controller.refreshController,
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
