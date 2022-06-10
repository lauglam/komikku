import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:komikku/database/hive.dart';
import 'package:komikku/provider/chapter_read_marker_provider.dart';
import 'package:komikku/provider/data_saver_provider.dart';
import 'package:komikku/provider/follow_provider.dart';
import 'package:komikku/provider/content_rating_provider.dart';
import 'package:komikku/provider/tag_provider.dart';
import 'package:komikku/provider/translated_language_provider.dart';
import 'package:komikku/provider/user_provider.dart';
import 'package:komikku/views/login.dart';
import 'package:komikku/views/search.dart';
import 'package:komikku/views/shell.dart';
import 'package:provider/provider.dart';

void main() async {
  await hiveInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TagProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => FollowProvider()),
        ChangeNotifierProvider(create: (context) => DataSaverProvider()),
        ChangeNotifierProvider(create: (context) => ContentRatingProvider()),
        ChangeNotifierProvider(create: (context) => ChapterReadMarkerProvider()),
        ChangeNotifierProvider(create: (context) => TranslatedLanguageProvider()),
      ],
      builder: (context, child) => MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        title: 'Komikku',
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        routes: {
          '/search': (context) => const Search(),
          '/login': (context) => const Login(),
        },
        home: const Shell(),
      ),
    );
  }
}
