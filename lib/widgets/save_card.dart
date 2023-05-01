import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/save_data.dart';

class SaveCard extends StatelessWidget {
  final Box box;
  final SaveData saveDatum;
  final int index;

  const SaveCard({
    Key? key,
    required this.saveDatum,
    required this.index,
    required this.box,
  }) : super(key: key);

  Text characterStatusText(int index) {
    return Text(
        "${saveDatum.heroes[index].name} HP:${saveDatum.heroes[index].hp.toInt()}/${saveDatum.heroes[index].maxHp.toInt()}");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 100,
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1, color: Colors.black),
          boxShadow: [
            BoxShadow(
              offset: const Offset(1, 2),
              color: Colors.grey.withOpacity(0.7),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                box.put("$index", null);
              },
              icon: const Icon(Icons.delete_forever_rounded),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                    "${saveDatum.lastPlayTime.month}월 ${saveDatum.lastPlayTime.day}일 ${saveDatum.lastPlayTime.weekday}요일"),
                Text(
                    "${saveDatum.lastPlayTime.hour}시 ${saveDatum.lastPlayTime.minute}분 ${saveDatum.lastPlayTime.second}초")
              ],
            ),
            Column(
              children: [
                for (int i = 0; i < saveDatum.heroes.length; i++)
                  characterStatusText(i)
              ],
            ),
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
      ),
    );
  }
}
