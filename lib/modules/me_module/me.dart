import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/utils/icons.dart';
import 'package:komikku/core/utils/toast.dart';
import 'package:komikku/modules/home_module/home_controller.dart';
import 'package:komikku/modules/subscribes_module/subscribes_controller.dart';
import 'package:komikku/modules/me_module/user_controller.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/global_widgets/widgets.dart';

import 'widgets/content_rating_widget.dart';
import 'widgets/data_saver_widget.dart';
import 'widgets/translated_language_widget.dart';

class Me extends StatelessWidget {
  const Me({Key? key}) : super(key: key);

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
              child: SizedBox(
                height: 140,
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
                          GetX<UserController>(
                            init: UserController(),
                            builder: (controller) => OutlinedButton(
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
                            if (!UserController.to.loginState) {
                              return Text('  未登录', style: Theme.of(context).textTheme.titleMedium);
                            }

                            // 已登录
                            return Text(
                              UserController.to.username,
                              style: Theme.of(context).textTheme.titleMedium,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // 设置项
            Builder(
              builder: (context) {
                var selectedDataSaver = false;
                var selectedContentRating = <String>[];
                var selectedTranslatedLanguage = <String>[];
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
                          onPressed: () => showAlertDialog(
                            title: '内容分级',
                            content: ContentRatingWidget(
                              selectedContentRating: HiveDatabase.contentRating,
                              onChanged: (value) => selectedContentRating = value,
                            ),
                            onConfirm: () {
                              if (selectedContentRating.isNotEmpty) {
                                HiveDatabase.contentRating = selectedContentRating;

                                // 刷新首页和订阅页
                                HomeController.to.pagingController.refresh();
                                SubscribesController.to.pagingController.refresh();
                              }
                            },
                          ),
                        ),

                        // 章节语言
                        IconTextButton(
                          text: '章节语言',
                          icon: TaoIcons.comment,
                          onPressed: () => showAlertDialog(
                            title: '章节语言',
                            content: TranslatedLanguageWidget(
                              selectedLanguage: HiveDatabase.translatedLanguage,
                              onChanged: (value) => selectedTranslatedLanguage = value,
                            ),
                            // translatedLanguage can be empty
                            onConfirm: () {
                              HiveDatabase.translatedLanguage = selectedTranslatedLanguage;

                              // 刷新首页
                              HomeController.to.pagingController.refresh();
                            },
                          ),
                        ),

                        // 图片质量
                        IconTextButton(
                          text: '图片质量',
                          icon: TaoIcons.image,
                          onPressed: () => showAlertDialog(
                            title: '图片质量',
                            content: DataSaverWidget(
                              selectedDataSaver: HiveDatabase.dataSaver,
                              onChanged: (value) => selectedDataSaver = value,
                            ),
                            onConfirm: () {
                              // 提示信息
                              if (selectedDataSaver) showText(text: '阅读漫画时更快加载，但图片质量有所下降');
                              HiveDatabase.dataSaver = selectedDataSaver;
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
