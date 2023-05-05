import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/targets.dart';
import 'package:trpg/services/battle_point.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/services/save_data_list.dart';
import 'package:trpg/widgets/character_card.dart';

class MainScreen extends StatefulWidget {
  final String title;
  final int saveIndex;

  const MainScreen({
    super.key,
    this.title = "TRPG",
    required this.saveIndex,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with ChangeNotifier {
  List<Character> turn = [];
  bool isBattleOn = false;

  @override
  Widget build(BuildContext context) {
    SaveData gameData =
        context.watch<SaveDataList>().saveDataList[widget.saveIndex]!;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Targets>(
            create: (BuildContext context) => Targets()),
        ChangeNotifierProvider<BattlePoint>(
            create: (BuildContext context) => BattlePoint()),
      ],
      child: Scaffold(
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
              onPressed: () {},
              icon: const Icon(Icons.add_circle_outline_outlined),
            )
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 600,
              child: ListView.separated(
                itemCount: gameData.heroes.length,
                itemBuilder: (BuildContext context, int charIndex) =>
                    CharacterCard(
                  gameData: gameData,
                  character: gameData.heroes[charIndex],
                ),
                separatorBuilder: (BuildContext context, int charIndex) =>
                    const SizedBox(height: 10),
              ),
            ),
            SizedBox(
              width: 600,
              child: ListView.separated(
                itemCount: gameData.enemies.length,
                itemBuilder: (BuildContext context, int charIndex) =>
                    CharacterCard(
                  gameData: gameData,
                  character: gameData.enemies[charIndex],
                ),
                separatorBuilder: (BuildContext context, int charIndex) =>
                    const SizedBox(height: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
