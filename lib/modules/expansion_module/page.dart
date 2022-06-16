import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller.dart';
import 'widgets/entry_item_widget.dart';

class ExpansionListView extends StatelessWidget {
  const ExpansionListView({Key? key}) : super(key: key);

  static const _indicator = Center(child: CircularProgressIndicator());

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChapterController());
    return Obx(
      () {
        final data = controller.data.value;
        if (data.isEmpty) return _indicator;

        return ListView.builder(
          cacheExtent: 500,
          shrinkWrap: true,
          itemCount: data.length,
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, index) => EntryItemWidget(data[index]),
        );
      },
    );
  }
}
