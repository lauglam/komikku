import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:komikku/provider/history_provider.dart';
import 'package:komikku/views/login.dart';
import 'package:komikku/views/search.dart';
import 'package:komikku/views/shell.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
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
