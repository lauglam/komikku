import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'indicator.dart';
import 'shortcut.dart';

class PagedGridViewWidget<ItemType> extends StatelessWidget {
  /// Corresponds to [PagedSliverBuilder.pagingController].
  final PagingController pagingController;

  /// The builder for list items.
  final ItemWidgetBuilder<ItemType> itemBuilder;

  /// Fire when try again
  final VoidCallback? onTryAgain;

  /// Displayed when no item found
  final String noItemsFoundText;

  /// Control inner state
  final RefreshController controller;

  /// callback when header refresh
  ///
  /// when the callback is happening,you should use [RefreshController]
  /// to end refreshing state,else it will keep refreshing state
  final VoidCallback? onRefresh;

  const PagedGridViewWidget({
    Key? key,
    required this.pagingController,
    required this.itemBuilder,
    required this.noItemsFoundText,
    required this.controller,
    required this.onRefresh,
    this.onTryAgain,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullUp: true,
      controller: controller,
      onRefresh: onRefresh,
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
        pagingController: pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageProgressIndicatorBuilder: (context) => defaultIndicator,
          newPageProgressIndicatorBuilder: (context) => emptyWidget,
          firstPageErrorIndicatorBuilder: (context) =>
              TryAgainExceptionIndicator(onTryAgain: onTryAgain),
          newPageErrorIndicatorBuilder: (context) =>
              TryAgainIconExceptionIndicator(onTryAgain: onTryAgain),
          noItemsFoundIndicatorBuilder: (context) =>
              Center(child: Text(noItemsFoundText)),
          itemBuilder: (context, item, index) =>
              itemBuilder(context, item as ItemType, index),
        ),
      ),
    );
  }
}
