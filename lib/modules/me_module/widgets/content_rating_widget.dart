import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 内容分级
class ContentRatingWidget extends StatelessWidget {
  final List<String> selectedContentRating;
  final void Function(List<String> value) onChanged;

  const ContentRatingWidget({
    Key? key,
    required this.selectedContentRating,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedContentRatingRx = RxList<String>(selectedContentRating);
    return SizedBox(
      width: 250,
      child: Scrollbar(
        child: ListView.builder(
          shrinkWrap: true,
          prototypeItem:
              CheckboxListTile(title: const Text(''), value: true, onChanged: (value) {}),
          itemCount: _contentRatingMap.length,
          itemBuilder: (context, index) {
            final currentKey = _contentRatingMap.keys.elementAt(index);
            final currentValue = _contentRatingMap.values.elementAt(index);
            return Obx(
              () => CheckboxListTile(
                title: Text(currentValue),
                value: selectedContentRatingRx.contains(currentKey),
                onChanged: (value) {
                  if (value == null) return;
                  value
                      ? selectedContentRatingRx.add(currentKey)
                      : selectedContentRatingRx.remove(currentKey);
                  onChanged(selectedContentRatingRx);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  static const _contentRatingMap = {
    'safe': '安全的',
    'suggestive': '暗示的',
    'erotica': '涉黄的',
    'pornographic': '色情的'
  };
}
