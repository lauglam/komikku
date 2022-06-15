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
