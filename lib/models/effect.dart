import 'package:hive/hive.dart';

part 'effect.g.dart';

@HiveType(typeId: 104)
class Effect {
  @HiveField(0)
  String? by;
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

  Effect({
    this.by = "tmp",
    this.name = "tmp",
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
  });
}
