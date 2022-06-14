import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'icons.dart';

/// 底部模态框
Future<void> showBottomModal({
  required String title,
  required Widget child,
}) async {
  await Get.bottomSheet(
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
        ),
      ),
      height: Get.size.height / 2.0,
      child: Column(children: [
        SizedBox(
          height: 50,
          child: Stack(
            textDirection: TextDirection.rtl,
            children: [
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(TaoIcons.wrong),
                onPressed: () => Get.back(),
              ),
            ],
          ),
        ),
        // const Divider(height: 1),
        Expanded(child: child),
      ]),
    ),
  );
}

/// 提示信息
CancelFunc showText({
  required String text,
  WrapAnimation? wrapAnimation,
  WrapAnimation? wrapToastAnimation,
  Color backgroundColor = Colors.transparent,
  Color contentColor = Colors.black45,
  BorderRadiusGeometry borderRadius = const BorderRadius.all(Radius.circular(4)),
  TextStyle textStyle = const TextStyle(fontSize: 14, color: Colors.white),
  AlignmentGeometry? align = const Alignment(0, 0.8),
  EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(vertical: 7, horizontal: 14),
  Duration? duration = const Duration(seconds: 2),
  Duration? animationDuration,
  Duration? animationReverseDuration,
  BackButtonBehavior? backButtonBehavior,
  VoidCallback? onClose,
  bool enableKeyboardSafeArea = true,
  bool clickClose = false,
  bool crossPage = true,
  bool onlyOne = true,
}) {
  return BotToast.showText(
    text: text,
    wrapAnimation: wrapAnimation,
    wrapToastAnimation: wrapToastAnimation,
    backgroundColor: backgroundColor,
    contentColor: contentColor,
    borderRadius: borderRadius,
    textStyle: textStyle,
    align: align,
    contentPadding: contentPadding,
    duration: duration,
    animationDuration: animationDuration,
    animationReverseDuration: animationReverseDuration,
    backButtonBehavior: backButtonBehavior,
    onClose: onClose,
    enableKeyboardSafeArea: enableKeyboardSafeArea,
    clickClose: clickClose,
    crossPage: crossPage,
    onlyOne: onlyOne,
  );
}

/// 确认框
void showAlertDialog({
  required String title,
  String confirmText = '确认',
  String cancelText = '取消',
  Color? confirmTextColor,
  Color? cancelTextColor = Colors.black45,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  VoidCallback? backgroundReturn,
  EdgeInsets insetPadding = const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
  BackButtonBehavior backButtonBehavior = BackButtonBehavior.close,
  Widget? content,
}) {
  BotToast.showAnimationWidget(
      clickClose: false,
      allowClick: false,
      onlyOne: true,
      crossPage: false,
      backButtonBehavior: backButtonBehavior,
      wrapToastAnimation: (controller, cancel, child) => Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  cancel();
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
              _CustomOffsetAnimation(
                controller: controller,
                child: child,
              )
            ],
          ),
      toastBuilder: (cancelFunc) => AlertDialog(
            insetPadding: insetPadding,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            title: Text(title),
            content: content,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  cancelFunc();
                  onCancel?.call();
                },
                child: Text(
                  cancelText,
                  style: TextStyle(color: cancelTextColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  cancelFunc();
                  onConfirm?.call();
                },
                child: Text(
                  confirmText,
                  style: TextStyle(color: confirmTextColor),
                ),
              ),
            ],
          ),
      animationDuration: const Duration(milliseconds: 300));
}

class _CustomOffsetAnimation extends StatefulWidget {
  const _CustomOffsetAnimation({
    Key? key,
    required this.controller,
    required this.child,
  }) : super(key: key);

  final AnimationController controller;
  final Widget child;

  @override
  State<_CustomOffsetAnimation> createState() => _CustomOffsetAnimationState();
}

class _CustomOffsetAnimationState extends State<_CustomOffsetAnimation> {
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
    animation = CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);
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
            ));
      },
      child: widget.child,
    );
  }
}
