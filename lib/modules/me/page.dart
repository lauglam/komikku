import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'widgets/content_rating_widget.dart';
import 'widgets/data_saver_widget.dart';
import 'widgets/translated_language_widget.dart';

import '../../core/utils/message.dart';
import '../login/controller.dart';

import 'controller.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final login = Get.put(LoginController());
    final me = Get.put(MeController());

    /// Big image on top.
    final bigImg = Image.asset(
      'assets/images/background-${1 + Random().nextInt(2)}.jpg',
      fit: BoxFit.fitWidth,
      width: double.infinity,
      height: 220,
    );

    /// The circle avatar.
    const avatar = CircleAvatar(
      radius: 40,
      backgroundImage: ExactAssetImage('assets/images/avatar.png'),
    );

    /// The login/logout button.
    final loginButton = Obx(
      () => OutlinedButton(
        style: ButtonStyle(
          minimumSize: MaterialStateProperty.all(const Size(200, 35)),
        ),
        child: Text(login.loginState ? '退出登录' : '登录'),
        onPressed: () {
          if (!login.loginState) {
            Get.toNamed('/login');
            return;
          }
          dialog(
            '是否退出登录',
            onConfirm: () async => await login.logout(),
          );
        },
      ),
    );

    /// The button go to profile.
    final profileButton = IconButton(
      icon: const Icon(Icons.arrow_forward_ios_rounded),
      onPressed: () {
        // TODO: 去往个人资料
        toast('功能暂未上线，敬请期待');
      },
    );

    /// Username.
    final username = Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Obx(
        () => Text(
          me.username,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
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
                children: [avatar, loginButton, profileButton],
              ),
              username,
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
