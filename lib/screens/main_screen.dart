import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/services/save_data.dart';

import '../models/character.dart';
import '../widgets/enemy_widget.dart';
import '../widgets/hero_widget.dart';

class MainScreen extends StatefulWidget {
  final String title;

  const MainScreen({
    super.key,
    this.title = "TRPG",
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with ChangeNotifier {
  List<Character> targets = [];

  void clearTargets() {
    targets = [];
    notifyListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            tooltip: "전투 시작",
            icon: const Icon(Icons.play_circle_outline),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "전투 종료",
            icon: const Icon(Icons.stop_circle_outlined),
            onPressed: () {},
          ),
          IconButton(
            tooltip: "몬스터 추가",
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('저장'),
            ),
            ListTile(
              title: const Text('불러오기'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(
          children: [
            HeroWidget(heroesList: context.watch<SaveData>().heroes),
            EnemyWidget(enemyList: context.watch<SaveData>().enemies),
          ],
        ),
      ),
    );
  }
}
