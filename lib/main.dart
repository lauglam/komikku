import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:komikku/core/theme/global.dart';
import 'package:komikku/data/hive.dart';
import 'package:komikku/routes/pages.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'core/theme/theme.dart';

void main() async {
  // 注册Hive数据库
  await HiveDatabase.initial();

  // 确保能够调用调用本机代码
  WidgetsFlutterBinding.ensureInitialized();

  // 注册GetX
  Get.put<GlobalService>(GlobalService());

  // 启动App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      headerBuilder: () => const ClassicHeader(),
      footerBuilder: () => const ClassicFooter(),
      hideFooterWhenNotFull: true,
      shouldFooterFollowWhenNotFull: (state) => false,
      child: GetMaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        title: 'Komikku',
        theme: GlobalService.to.isDarkModel ? AppTheme.dark : AppTheme.light,
        initialRoute: AppPages.initial,
        getPages: AppPages.pages,
        // localizationsDelegates: const [
        //   // 国际化
        //   RefreshLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalMaterialLocalizations.delegate
        // ],
        // supportedLocales: const [Locale('en'), Locale('zh')],
        // localeResolutionCallback: (locale, supportedLocales) => locale,
      ),
    );
  }
}
