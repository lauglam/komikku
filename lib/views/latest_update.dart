import 'package:flutter/material.dart';
import 'package:komikku/widgets/collection_view.dart';

class LatestUpdate extends StatefulWidget {
  const LatestUpdate({Key? key}) : super(key: key);

  @override
  State<LatestUpdate> createState() => _LatestUpdateState();
}

class _LatestUpdateState extends State<LatestUpdate> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return const CollectionView();
  }
}
