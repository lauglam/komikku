import 'dart:math';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/auth_api.dart';
import 'package:komikku/dex/apis/user_api.dart';
import 'package:komikku/utils/authentication.dart';
import 'package:komikku/utils/event_bus.dart';
import 'package:komikku/utils/icons.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/icon_text_button.dart';

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
        // 大图
        Image.asset(
          'assets/images/background-${1 + Random().nextInt(2)}.jpg',
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 220,
        ),

        // 主体内容
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 资料卡片
            FutureBuilder<String?>(
              future: _getUserDetails(),
              builder: (context, snapshot) {
                _loginFlag.value = snapshot.data != null;
                return BuilderChecker(
                  snapshot: snapshot,
                  builder: (context) {
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

            // TODO: 设置项
            // _SettingPanel(),
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

/// 设置面板
class _SettingPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Wrap(
          spacing: 20,
          children: [
            // 内容分级
            IconTextButton(
              text: '内容分级',
              icon: TaoIcons.film,
              onPressed: () {
                // TODO: 内容分级
                showAlertDialog(
                  title: '内容分级',
                  content: _ContentRating(),
                );
              },
            ),

            // 章节语言
            IconTextButton(
              text: '章节语言',
              icon: TaoIcons.comment,
              onPressed: () {
                // TODO: 章节语言
                showText(text: '功能暂未上线，敬请期待');
              },
            ),

            // 本地化
            IconTextButton(
              text: '本地化',
              icon: TaoIcons.cycle,
              onPressed: () {
                // TODO: 本地化
                showText(text: '功能暂未上线，敬请期待');
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 内容分级
class _ContentRating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CheckboxListTile(
          title: const Text('安全'),
          value: true,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: const Text('性暗示'),
          value: true,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: const Text('涉黄'),
          value: true,
          onChanged: (value) {},
        ),
        CheckboxListTile(
          title: const Text('色情'),
          value: true,
          onChanged: (value) {},
        ),
      ],
    );
  }
}
