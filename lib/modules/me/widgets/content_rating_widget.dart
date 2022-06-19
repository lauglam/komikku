import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'icon_button_widget.dart';

import '../../../core/utils/icons.dart';
import '../../../core/utils/toast.dart';
import '../../../data/services/store.dart';
import '../../../modules/subscribes/controller.dart';

import '../../home/controller.dart';

/// 内容分级
class ContentRatingWidget extends StatelessWidget {
  const ContentRatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hoController = Get.put(HomeController());
    final subController = Get.put(SubscribesController());

    final selected = RxList<String>(StoreService().contentRating);

    /// Content of alert dialog
    final alertContent = SizedBox(
      width: 250,
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          prototypeItem: _placeholder,
          itemCount: _contentRatingMap.length,
          itemBuilder: (context, index) {
            final currentKey = _contentRatingMap.keys.elementAt(index);
            final currentValue = _contentRatingMap.values.elementAt(index);
            return Obx(
              () => CheckboxListTile(
                title: Text(currentValue),
                value: selected.contains(currentKey),
                onChanged: (value) {
                  if (value == null) return;
                  value
                      ? selected.add(currentKey)
                      : selected.remove(currentKey);
                },
              ),
            );
          },
        ),
      ),
    );

    return IconTextButtonWidget(
      text: '内容分级',
      icon: TaoIcons.film,
      onPressed: () => showAlertDialog(
        title: '内容分级',
        content: alertContent,
        onConfirm: () {
          StoreService().contentRating = selected;

          // 刷新首页和订阅页
          hoController.refreshController.requestRefresh();
          subController.refreshController.requestRefresh();
        },
      ),
    );
  }

  static const _placeholder =
      CheckboxListTile(title: Text(''), value: true, onChanged: null);

  static const _contentRatingMap = {
    'safe': '安全的',
    'suggestive': '暗示的',
    'erotica': '涉黄的',
    'pornographic': '色情的'
  };
}
