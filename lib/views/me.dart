import 'dart:math';

import 'package:flutter/material.dart';
import 'package:komikku/utils/event_bus.dart';

class Me extends StatefulWidget {
  const Me({Key? key}) : super(key: key);

  @override
  State<Me> createState() => _MeState();
}

class _MeState extends State<Me> {
  @override
  initState() {
    super.initState();
    // 监听login事件
    bus.on('login', (arg) {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/images/background-${1 + Random().nextInt(2)}.jpg',
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: 200,
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                '点击登录',
                style: TextStyle(fontSize: 15),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded),
          ),
        ),
      ],
    );
  }
}
