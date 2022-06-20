import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/color_schemes.g.dart';

class DialogFit extends StatelessWidget {
  /// The text of confirm.
  final String confirmText;

  /// The callback of confirm.
  final VoidCallback? onConfirm;

  /// The text of cancel.
  final String cancelText;

  /// The callback of cancel.
  final VoidCallback? onCancel;

  /// The close func of toast.
  final VoidCallback cancelFunc;

  ///
  final Widget? content;

  ///
  final Widget? title;

  const DialogFit({
    Key? key,
    required this.confirmText,
    required this.cancelText,
    required this.cancelFunc,
    this.onConfirm,
    this.onCancel,
    this.title,
    this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final confirmButton = TextButton(
      onPressed: () {
        cancelFunc();
        onConfirm?.call();
      },
      child: Text(
        confirmText,
        style: Get.textTheme.labelLarge!.copyWith(
          color: lightColorScheme.primary,
        ),
      ),
    );

    final cancelButton = TextButton(
      onPressed: () {
        cancelFunc();
        onCancel?.call();
      },
      child: Text(
        cancelText,
        style: Get.textTheme.labelLarge!.copyWith(
          color: Get.theme.disabledColor,
        ),
      ),
    );

    return AlertDialog(
      insetPadding: const EdgeInsets.all(0),
      title: title,
      content: content,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      actions: [cancelButton, confirmButton],
    );
  }
}
