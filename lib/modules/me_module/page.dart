import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/login_module/controller.dart';

import 'widgets/content_rating_widget.dart';
import 'widgets/data_saver_widget.dart';
import 'widgets/translated_language_widget.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());

    /// Big image on top
    final bigImg = Image.asset(
      'assets/images/background-${1 + Random().nextInt(2)}.jpg',
      fit: BoxFit.fitWidth,
      width: double.infinity,
      height: 220,
    );

    /// Profile - avatar, username, login/logout button
    final profile = Card(
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 150,
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
                  Obx(
                    () => OutlinedButton(
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(const Size(200, 35)),
                      ),
                      child: Text(controller.loginState ? '退出登录' : '登录'),
                      onPressed: () {
                        // 未登录
                        if (!controller.loginState) {
                          Get.toNamed('/login');
                          return;
                        }

                        showAlertDialog(
                          title: '是否退出登录',
                          onConfirm: () async => await controller.logout(),
                        );
                      },
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
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Obx(
                  () {
                    // 未登录
                    if (!controller.loginState) {
                      return Text('  未登录', style: Theme.of(context).textTheme.titleMedium);
                    }

                    // 已登录
                    return Text(
                      controller.username,
                      style: Theme.of(context).textTheme.titleMedium,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );

    /// Settings panel on bottom
    final settings = Card(
      margin: const EdgeInsets.all(15),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Wrap(
          spacing: 20,
          children: const [
            ContentRatingWidget(),
            TranslatedLanguageWidget(),
            DataSaverWidget(),
          ],
        ),
      ),
    );

    return Column(
      children: [
        bigImg,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [profile, settings],
        ),
      ],
    );
  }
}
