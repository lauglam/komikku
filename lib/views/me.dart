import 'dart:math';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/apis/user_api.dart';
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/widgets/builder_checker.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  final _loginFlag = ValueNotifier<bool>(false);

  @override
  initState() {
    super.initState();

    // 订阅事件
    bus.on('login', (arg) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/background-${1 + Random().nextInt(2)}.jpg',
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 220,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<String?>(
              future: _getUserDetails(),
              builder: (context, snapshot) {
                _loginFlag.value = snapshot.data != null;
                return BuilderChecker(
                  snapshot: snapshot,
                  child: () {
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  radius: 40,
                                  backgroundImage: ExactAssetImage('assets/images/avatar.png'),
                                ),
                                OutlinedButton(
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(
                                      const BorderSide(color: Colors.orange, width: 1),
                                    ),
                                    minimumSize: MaterialStateProperty.all(const Size(200, 35)),
                                  ),
                                  child: ValueListenableBuilder(
                                    valueListenable: _loginFlag,
                                    builder: (context, value, child) {
                                      return Text(
                                        _loginFlag.value ? '退出登录' : '登录',
                                        style: const TextStyle(fontSize: 15),
                                      );
                                    },
                                  ),
                                  onPressed: () {
                                    // 未登录
                                    if (!_loginFlag.value) {
                                      Navigator.pushNamed(context, '/login');
                                      return;
                                    }

                                    showAlertDialog(
                                        title: '是否退出登录',
                                        onConfirm: () {
                                          _logout();
                                          _loginFlag.value = !_loginFlag.value;
                                        });
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                                  onPressed: () {
                                    // TODO: 去往个人资料
                                    showText(text: '功能暂未上线，敬请期待');
                                  },
                                ),
                              ],
                            ),
                            // Username
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                              child: ValueListenableBuilder(
                                valueListenable: _loginFlag,
                                builder: (context, value, child) => Text(
                                  _loginFlag.value ? snapshot.data! : '未登录',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }

  /// 获取用户信息
  Future<String?> _getUserDetails() async {
    if (!await isLogin) return null;

    var response = await UserApi.getUserDetailsAsync();
    return response.data.attributes.username;
  }

  /// 退出登录
  _logout() async {
    // 清除refresh和session
    await removeSession();
    await removeRefresh();

    await AuthApi.logoutAsync();
    // 发出事件
    bus.emit('logout');
    showText(text: '已退出登录');
  }
}
