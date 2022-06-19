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

/// Bidirectional list view
class BidirectionalListView<ItemType> extends StatefulWidget {
  /// Calls methods every time new items are needed.
  /// Execute this method to append items to the reply up list.
  final Future<void> Function(int pageKey, AppendPageCallback<ItemType> append)
      onReplyUp;

  /// Calls methods every time new items are needed.
  /// Execute this method to append items to the reply down list.
  final Future<void> Function(int pageKey, AppendPageCallback<ItemType> append)
      onReplyDown;

  /// The first [pageKey] for reply up.
  /// This value must be greater than 0.
  final int firstReplyUpPageKey;

  /// The first [pageKey] for reply down.
  /// This value must be greater than 0.
  final int firstReplyDownPageKey;

  /// Whether enable replay up.
  /// default: false.
  final bool enableReplayUp;

  /// The controller for scrolling.
  final ScrollController? controller;

  /// The builder for list items.
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
            'Both firstReplyUpPageKey and firstReplyDownPageKey cannot be less than 0.'),
        super(key: key);

  @override
  State<BidirectionalListView<ItemType>> createState() =>
      _BidirectionalListViewState();
}

class _BidirectionalListViewState<ItemType>
    extends State<BidirectionalListView<ItemType>> {
  final Key downListKey = UniqueKey();

  final ValueNotifier<bool> _delayAddReplyUpToScreen = ValueNotifier(true);

  late final ScrollController _scrollController =
      widget.controller ?? ScrollController();

  late final PagingController<int, ItemType> _pagingReplyUpController =
      PagingController(
    firstPageKey: widget.firstReplyUpPageKey,
  );

  late final PagingController<int, ItemType> _pagingReplyDownController =
      PagingController(
    firstPageKey: widget.firstReplyDownPageKey,
  );

  void _fetchUpPage(
          int nextPageKey, List<ItemType> newItems, bool isLastPage) =>
      isLastPage
          ? _pagingReplyUpController.appendLastPage(newItems)
          : _pagingReplyUpController.appendPage(newItems, nextPageKey);

  void _fetchDownPage(
          int nextPageKey, List<ItemType> newItems, bool isLastPage) =>
      isLastPage
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

    if (_delayAddReplyUpToScreen.value) {
      _scrollController.addListener(addRelyUpToScreen);
    }

    super.initState();
  }

  void addRelyUpToScreen() {
    if (_scrollController.position.pixels < 0) {
      _scrollController.removeListener(addRelyUpToScreen);
      _delayAddReplyUpToScreen.value = false;
    }
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

    return ValueListenableBuilder<bool>(
      valueListenable: _delayAddReplyUpToScreen,
      builder: (context, value, child) {
        if (value || !widget.enableReplayUp) {
          return Scrollable(
            controller: _scrollController,
            viewportBuilder: (BuildContext context, ViewportOffset position) {
              return Viewport(
                cacheExtent: 500,
                offset: position,
                center: downListKey,
                slivers: [placeholder, downPageSliverList],
              );
            },
          );
        }

        return Scrollable(
          controller: _scrollController,
          viewportBuilder: (BuildContext context, ViewportOffset position) {
            return Viewport(
              cacheExtent: 500,
              offset: position,
              center: downListKey,
              slivers: [upPageSliverList, downPageSliverList],
            );
          },
        );
      },
    );
  }

  final placeholder = SliverFixedExtentList(
    itemExtent: 5,
    delegate: SliverChildBuilderDelegate(
      childCount: 1,
      (context, index) => const SizedBox(
        height: 5,
      ),
    ),
  );

  @override
  void dispose() {
    _pagingReplyUpController.dispose();
    _pagingReplyDownController.dispose();
    super.dispose();
  }
}
