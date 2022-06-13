import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:komikku/utils/icons.dart';

/// 搜索框
class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    Key? key,
    required this.hintText,
    required this.onSubmitted,
  }) : super(key: key);

  final String hintText;
  final ValueChanged<String> onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.black26,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextField(
        maxLines: 1,
        decoration: InputDecoration(
          icon: const Icon(
            TaoIcons.search,
            size: 15,
            color: Colors.white,
          ),
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
            height: 1.22,
          ),
        ),
        onSubmitted: (value) => onSubmitted(value),
      ),
    );
  }
}

/// 搜索框按钮，用于跳转
class SearchAppBarButton extends StatelessWidget {
  const SearchAppBarButton({
    Key? key,
    required this.hintText,
    required this.onTap,
  }) : super(key: key);

  final String hintText;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 30,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.white, size: 20),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                '点击搜索',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.labelLarge?.fontSize,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
