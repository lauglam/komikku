import 'package:flutter/material.dart';
import 'package:komikku/views/latest_update.dart';
import 'package:komikku/views/me.dart';
import 'package:komikku/views/subscribes.dart';

class Shell extends StatefulWidget {
  const Shell({Key? key}) : super(key: key);

  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int _currentIndex = 0;
  final _pages = [
    const LatestUpdate(),
    const Subscribes(),
    const Me(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
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
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          if (index != _currentIndex) setState(() => _currentIndex = index);
        },
      ),
    );
  }
}
