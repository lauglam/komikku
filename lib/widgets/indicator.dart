import 'package:flutter/material.dart';
import 'package:komikku/utils/icons.dart';

/// 中间带安卓图片的错误指示器
class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Transform.rotate(
            angle: 0.2,
            child: const Icon(Icons.android_rounded, size: 100, color: Colors.black12),
          ),
          Text(title, style: const TextStyle(fontSize: 18, color: Colors.black54)),
        ],
      ),
    );
  }
}

/// 带有刷新图标和文本的指示器
class TryAgainExceptionIndicator extends StatelessWidget {
  const TryAgainExceptionIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            color: Colors.black54,
            iconSize: 50,
            onPressed: onTryAgain,
            icon: const Icon(TaoIcons.refresh),
          ),
          Text('再试一次', style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}

/// 只有刷新图标的指示器
class TryAgainIconExceptionIndicator extends StatelessWidget {
  const TryAgainIconExceptionIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        color: Colors.black54,
        iconSize: 40,
        onPressed: onTryAgain,
        icon: const Icon(TaoIcons.refresh),
      ),
    );
  }
}
