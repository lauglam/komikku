import 'package:flutter/material.dart';

class Subscribes extends StatefulWidget {
  const Subscribes({Key? key}) : super(key: key);

  @override
  State<Subscribes> createState() => _SubscribesState();
}

class _SubscribesState extends State<Subscribes> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('订阅'),
    );
  }
}
