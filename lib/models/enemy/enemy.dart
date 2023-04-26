import 'package:trpg/models/character.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skill.dart';

Character enemy({
  double bStr = 1,
  double bDex = 1,
  double bInt = 1,
  String name = "",
  String job = "Enemy",
  int level = 1,
  required List<Skill> skillBook,
}) =>
    Character(
      bStr: bStr,
      bDex: bDex,
      bInt: bInt,
      level: level,
      name: name,
      job: job,
      levelUp: baseLevelUp,
      battleStart: baseBattleStart,
      turnStart: baseTurnStart,
      getDamage: baseGetDamage,
      getHp: baseGetHp,
      itemStats: [],
      weapon: baseDagger,
      armor: baseLeather,
      accessory: baseAccessory,
      skillBook: skillBook,
    );

bool strike(List<Character> targets, Character me) {
  double damage = me.getDamage(targets[0], me.cDex, me.actionSuccess(me));
  targets[0].getHp(-2.0 * damage, targets[0]);
  return true;
}

bool stomp(List<Character> targets, Character me) {
  for (int i = 0; i < targets.length; i++) {
    double damage = me.getDamage(targets[i], me.cDex, me.actionSuccess(me));
    targets[i].getHp(-0.5 * damage, targets[i]);
  }
  return true;
}

bool shoot(List<Character> targets, Character me) {
  double damage = me.getDamage(targets[0], me.cDex, me.actionSuccess(me));
  targets[0].getHp(-2.5 * damage, targets[0]);
  return true;
}

bool breakingArmor(List<Character> targets, Character me) {
  double damage = me.getDamage(targets[0], me.cDex, me.actionSuccess(me));
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
      duration: 6,
      dfBonus: -2,
      buff: false,
    ),
    targets[0],
  );
  return true;
}
// class Goblin extends Character {
//   Goblin({
//     String name = "고블린",
//     double bStr = 11,
//     double bDex = 7,
//     double bInt = 1,
//     required List<Skill> skillBook,
//   }) : super(
//           bStr: bStr,
//           bDex: bDex,
//           bInt: bInt,
//           itemStats: [],
//           weapon: baseDagger,
//           armor: baseLeather,
//           accessory: baseAccessory,
//           skillBook: skillBook,
//           battleStart: baseBattleStart,
//           blow: baseBlow,
//           getDamage: baseGetDamage,
//           getHp: defaultGetHp,
//           levelUp: baseLevelUp,
//           turnStart: baseTurnStart,
//           skill1: defaultSkill,
//           skill2: defaultSkill,
//           skill3: defaultSkill,
//           skill4: defaultSkill,
//         );
//
//   bool strike(List<Character> targets, Character me) {
//     double damage = getDamage(targets[0], cDex, actionSuccess(me));
//     targets[0].getHp(-2.0 * damage);
//     return true;
//   }
//
//   bool stomp(List<Character> targets, Character me) {
//     for (int i = 0; i < targets.length; i++) {
//       double damage = getDamage(targets[i], cDex, actionSuccess(me));
//       targets[i].getHp(-0.5 * damage);
//     }
//     return true;
//   }
//
//   bool shoot(List<Character> targets, Character me) {
//     double damage = getDamage(targets[0], cDex, actionSuccess(me));
//     targets[0].getHp(-2.5 * damage);
//     return true;
//   }
// }
