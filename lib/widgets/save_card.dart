import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/services/hive_repository.dart';
import 'package:trpg/services/save_data.dart';

class SaveCard extends StatelessWidget {
  final SaveData saveDatum;
  final int index;

  const SaveCard({
    Key? key,
    required this.saveDatum,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          IconButton(
            onPressed: () {
              HiveRepository.delete("$index");
            },
            icon: const Icon(Icons.delete_forever_rounded),
          ),
          Expanded(
            child: Text(
              [
                for (Character hero in saveDatum.heroes)
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
                    "${saveDatum.lastPlayTime.month}월 ${saveDatum.lastPlayTime.day}일"),
                Text(
                    "${saveDatum.lastPlayTime.hour}시 ${saveDatum.lastPlayTime.minute}분")
              ],
            ),
          ),
          // Column(
          //   children: [
          //     for (int i = 0; i < saveDatum.heroes.length; i++)
          //       characterStatusText(i)
          //   ],
          // ),
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: saveDatum.heroes.length,
          //   itemBuilder: (BuildContext context, int index) {
          //     return Text(
          //         "${saveDatum.heroes[index].name} HP:s${saveDatum.heroes[index].hp}/${saveDatum.heroes[index].maxHp}");
          //   },
          // ),
        ],
      ),
    );
  }
}
