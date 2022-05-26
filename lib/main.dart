import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:komikku/views/activate_account.dart';
import 'package:komikku/views/search.dart';
import 'package:komikku/views/shell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      title: 'Komikku',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/search': (context) => const Search(),
        '/login-signup': (context) => const TabShell(),
        '/activate-account': (context) => const ActivateAccount(),
      },
      home: const Shell(),
    );
  }
}
