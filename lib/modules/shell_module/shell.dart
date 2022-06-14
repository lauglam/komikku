import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/shell_module/shell_controller.dart';
import 'package:komikku/modules/signup_module/signup.dart';
import 'package:komikku/modules/login_module/login.dart';

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
              if (index != ShellController.to.currentIndex) ShellController.to.currentIndex = index;
            },
          ),
        ),
      ),
      onWillPop: () async {
        var lastPop = ShellController.to.lastPop;
        if (lastPop == null || DateTime.now().difference(lastPop!) > const Duration(seconds: 2)) {
          lastPop = DateTime.now();
          showText(text: '再按一次退出');
          return false;
        }
        return true;
      },
    );
  }
}

/// 登录-注册的Shell
@Deprecated('官方不允许App进行注册，注册需要移步官网')
class TabShell extends StatefulWidget {
  const TabShell({Key? key}) : super(key: key);

  @override
  State<TabShell> createState() => _TabShellState();
}

@Deprecated('官方不允许App进行注册，注册需要移步官网')
class _TabShellState extends State<TabShell> {
  final _pages = [const Login(), const Signup()];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _pages.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.black45,
                ),
                onPressed: () => Navigator.pop(context),
              );
            },
          ),
        ),
        body: TabBarView(children: _pages),
      ),
    );
  }
}
