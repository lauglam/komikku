import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/modules/home_module/controller.dart';
import 'package:komikku/modules/subscribes_module/controller.dart';

import 'icon_button_widget.dart';

/// 内容分级
class ContentRatingWidget extends StatelessWidget {
  const ContentRatingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = RxList<String>(HiveDatabase.contentRating);
    final content = SizedBox(
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
                  value ? selected.add(currentKey) : selected.remove(currentKey);
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
        content: content,
        onConfirm: () {
          HiveDatabase.contentRating = selected;

          // 刷新首页和订阅页
          HomeController.to.pagingController.refresh();
          SubscribesController.to.pagingController.refresh();
        },
      ),
    );
  }

  static const _placeholder = CheckboxListTile(title: Text(''), value: true, onChanged: null);

  static const _contentRatingMap = {
    'safe': '安全的',
    'suggestive': '暗示的',
    'erotica': '涉黄的',
    'pornographic': '色情的'
  };
}
