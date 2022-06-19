import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PagingControllerExtent<PageKeyType, ItemType>
    extends PagingController<PageKeyType, ItemType> {
  PagingControllerExtent({
    required super.firstPageKey,
    super.invisibleItemsThreshold,
  });

  /// Whether it is in the state of background refresh
  bool background = false;

  @override
  void refresh({bool background = false}) {
    if (background) {
      this.background = true;
      // Since the state of PagingState has too much influence,
      // skip it here and directly [notifyPageRequestListeners].
      notifyPageRequestListeners(firstPageKey);
    } else {
      super.refresh();
    }
  }

  @override
  void appendPage(List<ItemType> newItems, PageKeyType? nextPageKey) {
    // Add judgment here
    final previousItems = background ? <ItemType>[] : value.itemList ?? <ItemType>[];
    final itemList = previousItems + newItems;
    value = PagingState<PageKeyType, ItemType>(
      itemList: itemList,
      error: null,
      nextPageKey: nextPageKey,
    );
    // reduction
    background = false;
  }
}
