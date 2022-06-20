import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'modals/dialog_fit.dart';
import 'modals/modal_fit.dart';
import 'modals/animation.dart';

Future<void> bottomModal({
  required Widget child,
  Widget? title,
  bool expand = false,
}) async {
  await showCupertinoModalBottomSheet(
    expand: expand,
    context: Get.context!,
    builder: (context) => ModalFit(title: title, child: child),
  );
}

void toast(String message) {
  BotToast.showText(
    text: message,
    borderRadius: BorderRadius.circular(4),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 4,
      horizontal: 8,
    ),
    textStyle: Get.textTheme.bodyLarge!.copyWith(
      color: Colors.white,
    ),
  );
}

void dialog(
  String? title, {
  String confirmText = '确认',
  String cancelText = '取消',
  Color? confirmColor,
  Color? cancelColor,
  VoidCallback? onConfirm,
  VoidCallback? onCancel,
  Widget? content,
  VoidCallback? backgroundReturn,
}) async {
  BotToast.showAnimationWidget(
    clickClose: false,
    allowClick: false,
    onlyOne: true,
    crossPage: false,
    animationDuration: const Duration(milliseconds: 300),
    wrapToastAnimation: (controller, cancelFunc, widget) => ToastAnimation(
      controller: controller,
      cancelFunc: cancelFunc,
      widget: widget,
      backgroundReturn: backgroundReturn,
    ),
    toastBuilder: (cancelFunc) => DialogFit(
      title: title == null ? null : Text(title),
      confirmText: confirmText,
      cancelText: cancelText,
      onConfirm: onConfirm,
      onCancel: onCancel,
      content: content,
      cancelFunc: cancelFunc,
    ),
  );
}
