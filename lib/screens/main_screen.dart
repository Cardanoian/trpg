import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/characters/enemies/mosters.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/screens/game_screen_widget.dart';
import 'package:trpg/screens/main_screen_widget.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/save_data_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    SaveDataList saveDataList = context.watch<SaveDataList>();
    List<Widget> mainAppBarActions = [
      IconButton(
        onPressed: () {},
        icon: const Icon(Icons.refresh_rounded),
      ),
    ];
    List<Widget> playAppBarActions = [
      IconButton(
        tooltip: "전투 시작",
        icon: const Icon(Icons.play_circle_outline),
        onPressed: () {},
      ),
      IconButton(
        tooltip: "전투 종료",
        icon: const Icon(Icons.stop_circle_outlined),
        onPressed: () {
          double gold = context.watch<GameData>().gold;
          double exp = context.watch<GameData>().exp;
          double itemRating = context.watch<GameData>().itemRating;
          int survival = 0;
          List<Character> heroes = saveDataList
              .saveDataList[context.watch<GameData>().playIndex]!.heroes;
          for (Character hero in heroes) {
            survival += hero.isAlive ? 1 : 0;
          }
          if (survival == 0) {
            for (Character hero in heroes) {
              hero.lostExp();
            }
          }
          for (var hero in heroes) {
            hero.getGold(gold);
            hero.getExp(exp.toInt());
            Item? item =
                getRandomGradeItem(itemRating: itemRating, character: hero);
            if (item != null) {
              hero.getItem(item);
            }
          }
        },
      ),
      IconButton(
        tooltip: "몬스터 추가",
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return Container(
                  child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) =>
                          GestureDetector(
                            child: Container(
                              child: Text(enemySpecies.keys.toList()[index]),
                            ),
                            onTap: () {},
                          ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 5),
                      itemCount: enemySpecies.length),
                );
              });
        },
        icon: const Icon(Icons.add_circle_outline_outlined),
      )
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text("TRPG"),
        actions: context.watch<GameData>().pageIndex == 0
            ? mainAppBarActions
            : playAppBarActions,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: context.watch<GameData>().pageIndex == 0
              ? const MainScreenWidget()
              : const GameScreenWidget(),
        ),
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      showSelectedLabels: true,
      showUnselectedLabels: false,
      unselectedItemColor: Colors.black.withOpacity(0.6),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "홈"),
        BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow_outlined), label: "게임"),
      ],
      currentIndex: context.watch<GameData>().pageIndex,
      onTap: (int idx) {
        context.read<GameData>().updatePageIndex(idx);
      },
    );
  }
}
