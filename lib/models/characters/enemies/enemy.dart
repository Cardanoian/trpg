import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skills/enemy_skills.dart';
import 'package:trpg/models/skills/skill.dart';

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
      levelUp: Character.baseLevelUp,
      battleStart: Character.baseBattleStart,
      turnStart: Character.baseTurnStart,
      getDamage: Character.baseGetDamage,
      getHp: EnemySkills.enemyGetHp,
      itemStats: [],
      weapon: baseDagger,
      armor: baseLeather,
      accessory: baseAccessory,
      skillBook: skillBook,
    );

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
