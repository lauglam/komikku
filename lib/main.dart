import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'core/theme/global.dart';
import 'core/theme/theme.dart';
import 'data/services/store.dart';
import 'routes/pages.dart';

void main() async {
  // 注册Hive数据库
  await StoreService().initial();

  // 确保能够调用调用本机代码
  WidgetsFlutterBinding.ensureInitialized();

  // 注册GetX
  Get.put<GlobalService>(GlobalService());

  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

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
