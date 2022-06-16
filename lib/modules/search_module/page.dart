import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/data/dto/manga_dto.dart';

import 'package:komikku/global_widgets/widgets.dart';

import 'controller.dart';
import 'widgets/list_view_item_widget.dart';
import 'widgets/search_filter_widget.dart';

/// 搜索页面
class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());

    /// App bar on top
    final appBar = AppBar(
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: SearchAppBar(
        hintText: '搜索',
        onSubmitted: (value) {
          controller.searchTitle = value;
          controller.pagingController.refresh();
        },
      ),
      actions: [
        TextButton(
          child: Text('取消', style: Theme.of(context).textTheme.labelLarge),
          onPressed: () => Get.back(),
        ),
      ],
    );

    /// Floating button on bottom left
    final floatButton = FloatingActionButton(
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
            if (controller.selectedTags.isNotEmpty) {
              controller.pagingController.refresh();
            }
          },
          content: SingleChildScrollView(
            child: SearchFilterWidget(
              tagsGrouped: controller.tagsGrouped,
              selected: (value) => controller.selectedTags.values.contains(value),
              onChanged: (flag, value) {
                flag ? controller.addAll(value) : controller.removeValue(value.value);
              },
            ),
          ),
        );
      },
    );

    /// Selected tag, can delete
    final selectedChip = Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Obx(
        () => CanDeleteChipWarp(
          values: controller.selectedTags.values.toList(),
          onDeleted: (value) {
            controller.removeValue(value);
            controller.pagingController.refresh();
          },
        ),
      ),
    );

    /// Content list view
    final listView = Expanded(
      child: PagedListViewExtent(
        cacheExtent: 500,
        prototypeItem: placeholder,
        physics: const AlwaysScrollableScrollPhysics(),
        pagingController: controller.pagingController,
        builderDelegate: PagedChildBuilderDelegate<MangaDto>(
          firstPageErrorIndicatorBuilder: (context) => TryAgainExceptionIndicator(
            onTryAgain: () => controller.pagingController.retryLastFailedRequest(),
          ),
          newPageErrorIndicatorBuilder: (context) => TryAgainIconExceptionIndicator(
            onTryAgain: () => controller.pagingController.retryLastFailedRequest(),
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
    );

    return Scaffold(
      appBar: appBar,
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: floatButton,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [selectedChip, listView],
        ),
      ),
    );
  }

  static const placeholder = ListViewItemWidget(
    imageUrl: _defaultChar,
    title: _defaultChar,
    subtitle: _defaultChar,
  );

  static const _defaultChar = '';
}
