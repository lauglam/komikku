import 'package:flutter/material.dart';
import 'package:komikku/routes.dart';
import 'package:komikku/views/latest_update.dart';
import 'package:komikku/views/me.dart';
import 'package:komikku/views/subscribes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Komikku',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: staticRoutes,
      home: const Shell(),
    );
  }
}

class Shell extends StatefulWidget {
  const Shell({Key? key}) : super(key: key);

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: [
        const LatestUpdate(),
        const Subscribes(),
        const Me(),
      ][currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: '最新更新',
            icon: Icon(
              Icons.home_rounded,
              color: Colors.green,
            ),
          ),
          BottomNavigationBarItem(
            label: '订阅',
            icon: Icon(
              Icons.favorite,
              color: Colors.pink,
            ),
          ),
          BottomNavigationBarItem(
            label: '我的',
            icon: Icon(
              Icons.person_pin,
              color: Colors.blue,
            ),
          ),
        ],
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index != currentIndex) setState(() => currentIndex = index);
        },
      ),
    );
  }
}
