import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/hive_repository.dart';
import 'package:trpg/services/saveDataToMap.dart';
import 'package:trpg/services/save_data.dart';
import 'package:trpg/services/save_data_list.dart';

class SaveCard extends StatelessWidget {
  final int index;

  const SaveCard({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SaveData saveData = context.watch<SaveDataList>().saveDataList[index]!;

    return Container(
      padding: const EdgeInsets.all(10),
      height: 70,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          width: 2,
          color: Colors.black,
        ),
        color: Colors.grey[300],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {
                  HiveRepository.delete("$index");
                },
                icon: const Icon(Icons.delete_forever_rounded),
              ),
              context
                          .watch<SaveDataList>()
                          .saveDataList[context.watch<GameData>().playIndex] ==
                      null
                  ? const SizedBox()
                  : IconButton(
                      onPressed: () {
                        HiveRepository.put(
                            "$index",
                            saveDataToMap(
                                context.watch<SaveDataList>().saveDataList[
                                    context.watch<GameData>().playIndex]!));
                      },
                      icon: const Icon(Icons.save_rounded),
                    ),
            ],
          ),
          Expanded(
            child: Text(
              [
                for (Character hero in saveData.heroes)
                  "Lv${hero.level} ${hero.job} ${hero.name}"
              ].join("  /  "),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    "${saveData.lastPlayTime.month}월 ${saveData.lastPlayTime.day}일"),
                Text(
                    "${saveData.lastPlayTime.hour}시 ${saveData.lastPlayTime.minute}분")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
