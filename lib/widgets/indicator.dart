import 'package:flutter/material.dart';
import '../core/utils/icons.dart';

/// Thin indicator.
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

/// Thin indicator with title on the top.
class ThinIndicatorWithTitle extends StatelessWidget {
  /// The title of top.
  final String title;

  /// The progress of indicator.
  final double? progress;

  const ThinIndicatorWithTitle({
    Key? key,
    required this.title,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          const Padding(padding: EdgeInsets.only(bottom: 10)),
          ThinProgressIndicator(value: progress),
        ],
      ),
    );
  }
}

/// The indicator with warning icon on top and try again button.
class TryAgainIndicatorWithIcon extends StatelessWidget {
  const TryAgainIndicatorWithIcon({
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
            iconSize: 60,
            onPressed: onTryAgain,
            icon: const Icon(TaoIcons.warning),
          ),
          const Padding(padding: EdgeInsets.only(bottom: 15)),
          ElevatedButton.icon(
            icon: const Icon(TaoIcons.refresh),
            label: const Text('Try again'),
            onPressed: onTryAgain,
          ),
        ],
      ),
    );
  }
}

/// The indicator with try again button.
class TryAgainIndicator extends StatelessWidget {
  const TryAgainIndicator({
    this.onTryAgain,
    Key? key,
  }) : super(key: key);

  final VoidCallback? onTryAgain;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(TaoIcons.refresh, size: 40),
        label: const Text('Try again'),
        onPressed: onTryAgain,
      ),
    );
  }
}
