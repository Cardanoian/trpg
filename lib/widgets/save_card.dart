import 'package:flutter/material.dart';

import '../services/save_data.dart';

class SaveCard extends StatelessWidget {
  final SaveData saveDatum;

  const SaveCard({
    Key? key,
    required this.saveDatum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(1, 2),
            color: Colors.black.withOpacity(0.7),
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {},
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
          ListView.builder(
            itemCount: saveDatum.heroes.length,
            itemBuilder: (BuildContext context, int index) {
              return Text(
                  "${saveDatum.heroes[index].name} HP:s${saveDatum.heroes[index].hp}/${saveDatum.heroes[index].maxHp}");
            },
          ),
        ],
      ),
    );
  }
}
