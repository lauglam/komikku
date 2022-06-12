import 'package:flutter/material.dart';

/// 菱形按钮
class BeveledButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onPressed;
  final String data;
  final MaterialStateProperty<Color?>? backgroundColor;

  const BeveledButton(
    this.data, {
    Key? key,
    required this.icon,
    required this.onPressed,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: icon,
      label: Text(data),
      style: ButtonStyle(
        backgroundColor: backgroundColor,
        shape: MaterialStateProperty.all(
          const BeveledRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}

/// 上方图标-下方文字
class IconTextButton extends StatelessWidget {
  const IconTextButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onPressed,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      clipBehavior: Clip.antiAlias,
      onPressed: onPressed,
      style: ButtonStyle(foregroundColor: MaterialStateProperty.all(Colors.black54)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon),
          const Padding(padding: EdgeInsets.only(bottom: 8)),
          Text(
            text,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
