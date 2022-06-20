import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/utils/icons.dart';
import '../../core/utils/message.dart';

import 'controller.dart';

/// 主界面Shell
class Shell extends StatelessWidget {
  const Shell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        body: Obx(
          () => IndexedStack(
            index: ShellController.to.currentIndex,
            children: ShellController.to.pages,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            iconSize: 20,
            selectedFontSize: 12,
            items: const [
              BottomNavigationBarItem(label: '首页', icon: Icon(TaoIcons.home)),
              BottomNavigationBarItem(label: '订阅', icon: Icon(TaoIcons.heart)),
              BottomNavigationBarItem(label: '我的', icon: Icon(TaoIcons.me)),
            ],
            currentIndex: ShellController.to.currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if (index != ShellController.to.currentIndex)
                ShellController.to.currentIndex = index;
            },
          ),
        ),
      ),
      onWillPop: () async {
        var lastPop = ShellController.to.lastPop;
        if (lastPop == null ||
            DateTime.now().difference(lastPop) > const Duration(seconds: 2)) {
          ShellController.to.lastPop = DateTime.now();
          toast('再按一次退出');
          return false;
        }
        return true;
      },
    );
  }
}
