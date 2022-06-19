import 'package:flutter/material.dart';

class BottomModalItem extends StatelessWidget {
  const BottomModalItem({
    Key? key,
    required this.title,
    required this.subtitle1,
    required this.subtitle2,
    required this.subtitle3,
    required this.subtitle4,
    this.onTap,
  }) : super(key: key);

  final String title;
  final String subtitle1;
  final String subtitle2;
  final String subtitle3;
  final String subtitle4;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(4),
      color: Colors.black12,
      clipBehavior: Clip.antiAlias,
      child: ListTile(
        dense: true,
        title: Text(title, style: const TextStyle(overflow: TextOverflow.ellipsis)),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _ExpandedText(subtitle1),
            const Padding(padding: EdgeInsets.only(left: 5)),
            _ExpandedText(subtitle2),
            const Padding(padding: EdgeInsets.only(left: 5)),
            _ExpandedText(subtitle3),
            const Padding(padding: EdgeInsets.only(left: 5)),
            _ExpandedText(subtitle4, alignment: Alignment.centerRight),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}

/// 自适应文字
class _ExpandedText extends StatelessWidget {
  const _ExpandedText(this.text, {Key? key, this.alignment}) : super(key: key);

  final String text;
  final Alignment? alignment;

  @override
  Widget build(BuildContext context) {
    if (alignment != null) {
      return Expanded(
        child: Container(
          alignment: alignment,
          child: Text(text, style: const TextStyle(overflow: TextOverflow.ellipsis)),
        ),
      );
    }

    return Expanded(
      child: Text(text, style: const TextStyle(overflow: TextOverflow.ellipsis)),
    );
  }
}
