import 'package:hive/hive.dart';

import '../characters/character.dart';
import '../effect.dart';

part 'enemy_skills.g.dart';

@HiveType(typeId: 108)
class EnemySkills {
  @HiveField(0)
  static bool strike(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(me));
    targets[0].getHp(-2.0 * damage, targets[0]);
    return true;
  }

  @HiveField(1)
  static bool stomp(List<Character> targets, Character me) {
    for (int i = 0; i < targets.length; i++) {
      double damage = me.getDamage(targets[i], me.cInt, me.actionSuccess(me));
      targets[i].getHp(-0.5 * damage, targets[i]);
    }
    return true;
  }

  @HiveField(2)
  static bool shoot(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(me));
    targets[0].getHp(-2.5 * damage, targets[0]);
    return true;
  }

  @HiveField(3)
  static bool pierce(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(me));
    targets[0].getHp(-0.5 * damage, targets[0]);
    targets[0].getEffect(
      Effect(
        hp: -0.5 * damage,
        name: "출혈",
        duration: 3,
        buff: false,
        by: me.name,
      ),
      targets[0],
    );
    return true;
  }

  @HiveField(4)
  static bool breakingArmor(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(me));
    targets[0].getHp(-3 * damage, targets[0]);
    for (var effect in targets[0].effects) {
      if (effect.name == "방어구 부수기") {
        effect.dfBonus *= 2;
        effect.duration = 6;
      }
    }
    targets[0].getEffect(
      Effect(
        by: me.name,
        name: "방어구 부수기",
        duration: 4,
        dfBonus: -2 - me.level * 0.2,
        buff: false,
      ),
      targets[0],
    );
    return true;
  }

  @HiveField(5)
  static void enemyGetHp(double hp, Character me, Character opponent) {
    me.getHp(hp, me);
    if (hp < 0 && me.hp > 0) {
      double agg = opponent.job == "전사" || opponent.job == "성기사" ? hp * 5 : hp;
      if (me.aggro.keys.contains(opponent)) {
        me.aggro[opponent] = me.aggro[opponent]! + agg;
      } else {
        me.aggro[opponent] = agg;
      }
    }
  }
}
