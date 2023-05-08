import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:trpg/models/characters/character.dart';

part 'effect.g.dart';

@HiveType(typeId: 104)
class Effect {
  @HiveField(0)
  Character? by;
  @HiveField(1)
  String name;
  @HiveField(2)
  int duration;
  @HiveField(3)
  double strength;
  @HiveField(4)
  double dex;
  @HiveField(5)
  double intel;
  @HiveField(6)
  double hp;
  @HiveField(7)
  double atBonus;
  @HiveField(8)
  double combat;
  @HiveField(9)
  double dfBonus;
  @HiveField(10)
  double diceAdv;
  @HiveField(11)
  bool buff;
  @HiveField(12)
  Function? addEffect;
  @HiveField(13)
  double barrier;
  @HiveField(14)
  Image image;

  Effect({
    this.barrier = 0,
    this.duration = 0,
    this.strength = 0,
    this.dex = 0,
    this.intel = 0,
    this.hp = 0,
    this.atBonus = 0,
    this.combat = 0,
    this.dfBonus = 0,
    this.diceAdv = 0,
    this.buff = true,
    this.addEffect,
    this.by,
    required this.name,
    required this.image,
  });

  @override
  String toString() {
    String result = "$name $duration초 시전자: $by\n";
    List<String> abilities = [];
    if (hp != 0) abilities.add("HP: $hp");
    if (diceAdv != 0) abilities.add("주사위: $diceAdv");
    if (atBonus != 0) abilities.add("공격력: $atBonus");
    if (dfBonus != 0) abilities.add("방어력: $dfBonus");
    if (combat != 0) abilities.add("전투력: $combat");
    if (strength != 0) abilities.add("힘: $strength");
    if (dex != 0) abilities.add("민첩: $dex");
    if (intel != 0) abilities.add("지능: $intel");
    result = result + abilities.join(", ");
    return result;
  }
}
