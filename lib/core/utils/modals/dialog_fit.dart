import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../icons.dart';

class ModalFit extends StatelessWidget {
  final Widget child;
  final Widget? title;

  const ModalFit({
    Key? key,
    required this.child,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // The button of close.
    final close = IconButton(
      icon: const Icon(TaoIcons.wrong),
      onPressed: () => Get.back(),
    );

    // The header - center title, close button
    final header = SizedBox(
      height: 50,
      child: title == null
          ? Align(
              alignment: Alignment.centerRight,
              child: close,
            )
          : Stack(
              textDirection: TextDirection.rtl,
              children: [Center(child: title), close],
            ),
    );

    // Content.
    final content = Expanded(child: child);

    return Material(
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: Get.height * 0.5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [header, content],
          ),
        ),
      ),
    );
  }
}
