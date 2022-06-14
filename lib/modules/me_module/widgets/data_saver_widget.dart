import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 图片质量
class DataSaverWidget extends StatelessWidget {
  final bool selectedDataSaver;
  final void Function(bool value) onChanged;

  const DataSaverWidget({
    Key? key,
    required this.selectedDataSaver,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedDataSaverRx = RxBool(selectedDataSaver);
    return Obx(
      () => CheckboxListTile(
        title: const Text('图片压缩'),
        value: selectedDataSaverRx.value,
        onChanged: (value) {
          if (value == null) return;
          selectedDataSaverRx.value = value;
          onChanged(selectedDataSaverRx.value);
        },
      ),
    );
  }
}
