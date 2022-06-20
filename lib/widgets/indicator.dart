import 'package:flutter/material.dart';
import '../core/utils/icons.dart';

class ThinProgressIndicator extends StatelessWidget {
  final double? value;

  const ThinProgressIndicator({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: 2,
      ),
    );
  }
}

class ExceptionIndicator extends StatelessWidget {
  const ExceptionIndicator(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: 0.2,
              child: const Icon(Icons.android_rounded,
                  size: 100, color: Colors.black12),
            ),
            Text(title, style: Theme.of(context).textTheme.titleLarge),
          ],
        ),
      ),
    );
  }
}

class TryAgainExceptionIndicator extends StatelessWidget {
  const TryAgainExceptionIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
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
      ),
    );
  }
}

class TryAgainIconExceptionIndicator extends StatelessWidget {
  const TryAgainIconExceptionIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: IconButton(
          color: Colors.black54,
          iconSize: 40,
          onPressed: onTryAgain,
          icon: const Icon(TaoIcons.refresh),
        ),
      ),
    );
  }
}

class CircularTitleProgressIndicator extends StatelessWidget {
  /// 处于指示器上方的标题
  final String title;

  /// 指示器的进度
  final double? progress;

  const CircularTitleProgressIndicator({
    Key? key,
    required this.title,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineLarge),
            const Padding(padding: EdgeInsets.only(bottom: 10)),
            ThinProgressIndicator(value: progress),
          ],
        ),
      ),
    );
  }
}
