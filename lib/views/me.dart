import 'dart:math';

import 'package:flutter/material.dart';
import 'package:komikku/dex/apis/user_api.dart';
import 'package:komikku/provider/local_setting_provider.dart';
import 'package:komikku/provider/user_provider.dart';
import 'package:komikku/utils/icons.dart';
import 'package:komikku/utils/toast.dart';
import 'package:komikku/database/local_storage.dart';
import 'package:komikku/widgets/builder_checker.dart';
import 'package:komikku/widgets/icon_text_button.dart';
import 'package:provider/provider.dart';

part 'me.setting.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
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
            Card(
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
                        Consumer<UserProvider>(
                          builder: (context, userProvider, child) => FutureBuilder<bool>(
                            future: LocalStorage.userLoginState,
                            builder: (context, snapshot) => BuilderChecker(
                              snapshot: snapshot,
                              builder: (context) => OutlinedButton(
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(
                                    const BorderSide(color: Colors.orange, width: 1),
                                  ),
                                  minimumSize: MaterialStateProperty.all(const Size(200, 35)),
                                ),
                                child: Text(
                                  snapshot.data! ? '退出登录' : '登录',
                                  style: const TextStyle(fontSize: 15),
                                ),
                                onPressed: () {
                                  // 未登录
                                  if (!snapshot.data!) {
                                    Navigator.pushNamed(context, '/login');
                                    return;
                                  }

                                  showAlertDialog(
                                    title: '是否退出登录',
                                    onConfirm: () async => await userProvider.logout(),
                                  );
                                },
                              ),
                            ),
                          ),
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
                      child: Consumer<UserProvider>(
                        builder: (context, userProvider, child) => FutureBuilder<bool>(
                          future: LocalStorage.userLoginState,
                          builder: (context, snapshot) => BuilderChecker(
                            snapshot: snapshot,
                            builder: (context) {
                              // 未登录
                              if (!snapshot.data!) {
                                return const Text('未登录', style: TextStyle(fontSize: 16));
                              }

                              // 已登录
                              return FutureBuilder<String?>(
                                future: _getUserDetails(),
                                builder: (context, snapshot) => BuilderChecker(
                                  snapshot: snapshot,
                                  builder: (context) {
                                    return Text(
                                      snapshot.data!,
                                      style: const TextStyle(fontSize: 16),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 设置项
            _SettingPanel(),
          ],
        ),
      ],
    );
  }

  /// 获取用户信息
  Future<String> _getUserDetails() async {
    if (!await LocalStorage.userLoginState) throw Exception('Invalid operation');

    var response = await UserApi.getUserDetailsAsync();
    return response.data.attributes.username;
  }
}
