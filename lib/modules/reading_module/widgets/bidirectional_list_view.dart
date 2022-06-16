import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

typedef ItemWidgetBuilder<ItemType> = Widget Function(
  BuildContext context,
  ItemType item,
  int index,
);

typedef AppendPageCallback<ItemType> = void Function(
  int nextPageKey,
  List<ItemType> newItems,
  bool isLastPage,
);

/// 双向列表
class BidirectionalListView<ItemType> extends StatefulWidget {
  /// 向上请求的回调
  /// 输入当前请求的[pageKey]和一个执行函数[AppendPageCallback]
  /// 执行该函数能将新的值附加到列表中
  final Future<void> Function(int pageKey, AppendPageCallback<ItemType> append) onReplyUp;

  /// 向下请求的回调
  /// 输入当前请求的[pageKey]和一个执行函数[AppendPageCallback]
  /// 执行该函数能将新的值附加到列表中
  final Future<void> Function(int pageKey, AppendPageCallback<ItemType> append) onReplyDown;

  /// 向上的第一个[pageKey]
  /// 这个值必须大于0
  final int firstReplyUpPageKey;

  /// 向下的第一个[pageKey]
  /// 这个值必须大于0
  final int firstReplyDownPageKey;

  /// 是否启用向上
  /// 默认：false
  final bool enableReplayUp;

  /// 滚动控制器
  final ScrollController? controller;

  /// 子项的建造器
  final ItemWidgetBuilder<ItemType> itemBuilder;

  const BidirectionalListView({
    Key? key,
    required this.onReplyUp,
    required this.onReplyDown,
    required this.firstReplyUpPageKey,
    required this.firstReplyDownPageKey,
    required this.itemBuilder,
    this.enableReplayUp = false,
    this.controller,
  })  : assert(firstReplyUpPageKey >= 0 && firstReplyDownPageKey >= 0,
            'Both firstReplyUpPageKey and firstReplyDownPageKey cannot be less than 0'),
        super(key: key);

  @override
  State<BidirectionalListView<ItemType>> createState() => _BidirectionalListViewState();
}

class _BidirectionalListViewState<ItemType> extends State<BidirectionalListView<ItemType>> {
  final Key downListKey = UniqueKey();

  late final PagingController<int, ItemType> _pagingReplyUpController = PagingController(
    firstPageKey: widget.firstReplyUpPageKey,
  );

  late final PagingController<int, ItemType> _pagingReplyDownController = PagingController(
    firstPageKey: widget.firstReplyDownPageKey,
  );

  void _fetchUpPage(int nextPageKey, List<ItemType> newItems, bool isLastPage) => isLastPage
      ? _pagingReplyUpController.appendLastPage(newItems)
      : _pagingReplyUpController.appendPage(newItems, nextPageKey);

  void _fetchDownPage(int nextPageKey, List<ItemType> newItems, bool isLastPage) => isLastPage
      ? _pagingReplyDownController.appendLastPage(newItems)
      : _pagingReplyDownController.appendPage(newItems, nextPageKey);

  @override
  void initState() {
    _pagingReplyUpController.addPageRequestListener((pageKey) async {
      await widget.onReplyUp(pageKey, _fetchUpPage);
    });

    _pagingReplyDownController.addPageRequestListener((pageKey) async {
      await widget.onReplyDown(pageKey, _fetchDownPage);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final upPageSliverList = PagedSliverList(
      pagingController: _pagingReplyUpController,
      builderDelegate: PagedChildBuilderDelegate<ItemType>(
        itemBuilder: widget.itemBuilder,
      ),
    );

    final downPageSliverList = PagedSliverList(
      key: downListKey,
      pagingController: _pagingReplyDownController,
      builderDelegate: PagedChildBuilderDelegate<ItemType>(
        itemBuilder: widget.itemBuilder,
      ),
    );

    // Disable replay up Or delay relay up to screen
    if (!widget.enableReplayUp) {
      return Scrollable(
        controller: widget.controller,
        viewportBuilder: (BuildContext context, ViewportOffset position) {
          return Viewport(
            offset: position,
            center: downListKey,
            slivers: [downPageSliverList],
          );
        },
      );
    }

    return Scrollable(
      controller: widget.controller,
      viewportBuilder: (BuildContext context, ViewportOffset position) {
        return Viewport(
          offset: position,
          center: downListKey,
          slivers: [upPageSliverList, downPageSliverList],
        );
      },
    );
  }

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}
