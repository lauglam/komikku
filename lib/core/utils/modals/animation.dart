import 'package:flutter/material.dart';

class ToastAnimation extends StatelessWidget {
  final AnimationController controller;
  final VoidCallback cancelFunc;
  final Widget widget;
  final VoidCallback? backgroundReturn;

  const ToastAnimation({
    Key? key,
    required this.controller,
    required this.cancelFunc,
    required this.widget,
    this.backgroundReturn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            cancelFunc();
            backgroundReturn?.call();
          },
          //The DecoratedBox here is very important,he will fill the entire parent component
          child: AnimatedBuilder(
            builder: (_, child) => Opacity(
              opacity: controller.value,
              child: child,
            ),
            animation: controller,
            child: const DecoratedBox(
              decoration: BoxDecoration(color: Colors.black26),
              child: SizedBox.expand(),
            ),
          ),
        ),
        OffsetAnimation(
          controller: controller,
          child: widget,
        )
      ],
    );
  }
}

class OffsetAnimation extends StatefulWidget {
  const OffsetAnimation({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final AnimationController controller;
  final Widget child;

  @override
  State<OffsetAnimation> createState() => _OffsetAnimationState();
}

class _OffsetAnimationState extends State<OffsetAnimation> {
  Tween<Offset>? tweenOffset;
  Tween<double>? tweenScale;

  Animation<double>? animation;

  @override
  void initState() {
    tweenOffset = Tween<Offset>(
      begin: const Offset(0.0, 0.8),
      end: Offset.zero,
    );
    tweenScale = Tween<double>(begin: 0.3, end: 1.0);
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return FractionalTranslation(
          translation: tweenOffset!.evaluate(animation!),
          child: ClipRect(
            child: Transform.scale(
              scale: tweenScale!.evaluate(animation!),
              child: Opacity(
                opacity: animation!.value,
                child: child,
              ),
            ),
          ),
        );
      },
      child: widget.child,
    );
  }
}
