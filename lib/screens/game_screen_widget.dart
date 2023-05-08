import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/services/save_data_list.dart';
import 'package:trpg/widgets/character_card.dart';

class GameScreenWidget extends StatelessWidget {
  const GameScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    SaveData gameData = context
        .watch<SaveDataList>()
        .saveDataList[context.watch<GameData>().playIndex]!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 600,
          child: ListView.separated(
            itemCount: gameData.heroes.length,
            itemBuilder: (BuildContext context, int charIndex) => CharacterCard(
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
            itemBuilder: (BuildContext context, int charIndex) => CharacterCard(
              character: gameData.enemies[charIndex],
            ),
            separatorBuilder: (BuildContext context, int charIndex) =>
                const SizedBox(height: 10),
          ),
        ),
      ],
    );
  }
}
