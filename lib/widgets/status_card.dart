import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';

class StatusCard extends StatelessWidget {
  const StatusCard({
    super.key,
    required this.character,
  });

  final Character character;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      width: 350,
      child: Column(
        children: [
          Text(
              "Lv ${character.level} ${character.job} ${character.name}  ${character.job == "도적" ? "연계" : ""} ${character.job == "도적" ? character.link : ""}"),
          Text(
              "HP ${character.hp}/${character.maxHp}  ${character.srcName} ${character.src}/${character.maxSrc}"),
          Text("전투력: ${character.combat}  주사위 보조: ${character.diceAdv}"),
          Text("무기 공격력: ${character.atBonus}  방어력: ${character.dfBonus}"),
          Text(
              "힘: ${character.cStr}  민첩: ${character.cDex}  지능: ${character.cInt}"),
          Text(
              "무기: +${character.weapon.grade} ${typeToString(character.weapon.type)}")
        ],
      ),
    );
  }
}
