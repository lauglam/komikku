import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/data/hive.dart';

import 'icon_button_widget.dart';

/// 图片质量
class DataSaverWidget extends StatelessWidget {
  const DataSaverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = RxBool(HiveDatabase.dataSaver);

    final content = Obx(
      () => CheckboxListTile(
        title: const Text('图片压缩'),
        value: selected.value,
        onChanged: (value) {
          if (value == null) return;
          selected.value = value;
        },
      ),
    );

    return IconTextButtonWidget(
      text: '图片质量',
      icon: TaoIcons.image,
      onPressed: () => showAlertDialog(
        title: '图片质量',
        content: content,
        onConfirm: () {
          // 提示信息
          if (selected.value) showText(text: '阅读漫画时更快加载，但图片质量有所下降');
          HiveDatabase.dataSaver = selected.value;
        },
      ),
    );
  }
}
