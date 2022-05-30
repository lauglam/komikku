import 'package:flutter/material.dart';

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
          Transform.scale(scale: 1.5, child: Icon(icon)),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          Text(text),
        ],
      ),
    );
  }
}
