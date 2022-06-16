import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/dto/manga_dto.dart';

import 'package:komikku/global_widgets/widgets.dart';

import 'controller.dart';
import 'widgets/list_view_item_widget.dart';
import 'widgets/search_filter_widget.dart';

/// 搜索页面
class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        toolbarHeight: 50,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: SearchAppBar(
          hintText: '搜索',
          onSubmitted: (value) {
            SearchController.to.searchTitle = value;
            SearchController.to.pagingController.refresh();
          },
        ),
        actions: [
          TextButton(
            child: Text('取消', style: Theme.of(context).textTheme.labelLarge),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      // 底部高级搜索
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        clipBehavior: Clip.antiAlias,
        child: const Icon(TaoIcons.filter),
        onPressed: () async {
          // 键盘是否是弹起状态
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }

          showAlertDialog(
            title: '高级搜索',
            insetPadding: const EdgeInsets.all(0),
            onConfirm: () {
              if (SearchController.to.selectedTags.isNotEmpty) {
                SearchController.to.pagingController.refresh();
              }
            },
            content: SingleChildScrollView(
              child: SearchFilterWidget(
                tagsGrouped: SearchController.to.tagsGrouped,
                selected: (value) => SearchController.to.selectedTags.values.contains(value),
                onChanged: (flag, value) {
                  flag
                      ? SearchController.to.addAll(value)
                      : SearchController.to.removeValue(value.value);
                },
              ),
            ),
          );
        },
      ),

      // 主内容
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 已选标签
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Obx(
                () => CanDeleteChipWarp(
                  values: SearchController.to.selectedTags.values.toList(),
                  onDeleted: (value) {
                    SearchController.to.removeValue(value);
                    SearchController.to.pagingController.refresh();
                  },
                ),
              ),
            ),

            // 列表内容
            Expanded(
              child: PagedListViewExtent(
                cacheExtent: 500,
                prototypeItem: const ListViewItemWidget(imageUrl: '', title: '', subtitle: ''),
                physics: const AlwaysScrollableScrollPhysics(),
                pagingController: SearchController.to.pagingController,
                builderDelegate: PagedChildBuilderDelegate<MangaDto>(
                  firstPageErrorIndicatorBuilder: (context) => TryAgainExceptionIndicator(
                    onTryAgain: () => SearchController.to.pagingController.retryLastFailedRequest(),
                  ),
                  newPageErrorIndicatorBuilder: (context) => TryAgainIconExceptionIndicator(
                    onTryAgain: () => SearchController.to.pagingController.retryLastFailedRequest(),
                  ),
                  noItemsFoundIndicatorBuilder: (context) => const Center(
                    child: Text('没有找到符合条件的漫画'),
                  ),
                  itemBuilder: (context, item, index) {
                    return InkWell(
                      onTap: () => Get.toNamed('/details', arguments: item),
                      child: ListViewItemWidget(
                        imageUrl: item.imageUrl256,
                        title: item.title,
                        subtitle: item.status,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
