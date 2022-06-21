import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../core/utils/icons.dart';
import '../../core/utils/message.dart';
import '../../data/dto/manga_dto.dart';
import '../../widgets/widgets.dart';

import 'controller.dart';
import 'widgets/list_view_item_widget.dart';
import 'widgets/search_filter_widget.dart';

class Search extends StatelessWidget {
  const Search({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchController());
    final paging = controller.pagingController;
    final refresh = controller.refreshController;

    /// The button of go back.
    final backButton = TextButton(
      child: Text('取消', style: Theme.of(context).textTheme.labelLarge),
      onPressed: () => Get.back(),
    );

    /// Search input.
    final search = Padding(
      padding: const EdgeInsets.only(left: 10),
      child: CupertinoSearchTextField(
        placeholder: 'Search',
        onSubmitted: (value) {
          controller.searchTitle = value;
          refresh.requestRefresh();
        },
      ),
    );

    /// App bar on top.
    final appBar = AppBar(
      elevation: 0,
      titleSpacing: 0,
      toolbarHeight: 50,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title: search,
      actions: [backButton],
    );

    /// Floating button on bottom left.
    final floatButton = FloatingActionButton(
      clipBehavior: Clip.antiAlias,
      child: const Icon(TaoIcons.filter),
      onPressed: () async {
        // 键盘是否是弹起状态
        final focus = FocusScope.of(context);
        if (!focus.hasPrimaryFocus && focus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }

        final content = Obx(() {
          final grouped = controller.tagsGrouped;
          if (grouped.isEmpty) {
            return SizedBox(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              child: defaultIndicator,
            );
          }
          return SingleChildScrollView(
            child: SearchFilterWidget(
              tagsGrouped: controller.tagsGrouped,
              selected: (value) =>
                  controller.selectedTags.values.contains(value),
              onChanged: (flag, value) {
                flag
                    ? controller.addAll(value)
                    : controller.removeValue(value.value);
              },
            ),
          );
        });

        dialog(
          '高级搜索',
          content: content,
          onConfirm: () {
            if (controller.selectedTags.isNotEmpty) {
              refresh.requestRefresh();
            }
          },
        );
      },
    );

    /// Selected tag, can delete.
    final selectedChip = Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Obx(
        () => CanDeleteChipWarp(
          values: controller.selectedTags.values.toList(),
          onDeleted: (value) {
            controller.removeValue(value);
            refresh.requestRefresh();
          },
        ),
      ),
    );

    final iconTryAgain = TryAgainIndicatorWithIcon(
      onTryAgain: () => paging.retryLastFailedRequest(),
    );
    final tryAgain = TryAgainIndicator(
      onTryAgain: () => paging.retryLastFailedRequest(),
    );

    /// The delegate of child builder.
    final delegate = PagedChildBuilderDelegate<MangaDto>(
      firstPageProgressIndicatorBuilder: (context) => defaultIndicator,
      firstPageErrorIndicatorBuilder: (context) => iconTryAgain,
      newPageProgressIndicatorBuilder: (context) => emptyWidget,
      newPageErrorIndicatorBuilder: (context) => tryAgain,
      noItemsFoundIndicatorBuilder: (context) =>
          const CenterText('没有找到符合条件的漫画'),
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
    );

    /// Content list view.
    final listView = Expanded(
      child: SmartRefresher(
        controller: refresh,
        enablePullUp: true,
        onRefresh: () => paging.refresh(background: true),
        child: PagedListViewExtent(
          cacheExtent: 500,
          prototypeItem: placeholder,
          physics: const AlwaysScrollableScrollPhysics(),
          pagingController: paging,
          builderDelegate: delegate,
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
