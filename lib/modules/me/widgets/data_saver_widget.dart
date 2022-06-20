import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/icons.dart';
import '../../../core/utils/message.dart';
import '../../../data/services/store.dart';

import 'icon_button_widget.dart';

/// 图片质量
class DataSaverWidget extends StatelessWidget {
  const DataSaverWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selected = RxBool(StoreService().dataSaver);

    /// Content of alert dialog
    final alertContent = Obx(
      () => SizedBox(
        width: Get.width * 0.7,
        child: CheckboxListTile(
          title: const Text('图片压缩'),
          value: selected.value,
          onChanged: (value) {
            if (value == null) return;
            selected.value = value;
          },
        ),
      ),
    );

    return IconTextButtonWidget(
      text: '图片质量',
      icon: TaoIcons.image,
      onPressed: () => dialog(
        '图片质量',
        content: alertContent,
        onConfirm: () {
          // 提示信息
          if (selected.value) toast('阅读漫画时更快加载，但图片质量有所下降');
          StoreService().dataSaver = selected.value;
        },
      ),
    );
  }
}
