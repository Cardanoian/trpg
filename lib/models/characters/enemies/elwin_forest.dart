import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/characters/enemies/enemy.dart';
import 'package:trpg/models/skill.dart';
import 'package:trpg/models/skills/enemy_skills.dart';

Character goblin(int level) => enemy(
      name: "고블린",
      job: "적",
      bStr: 20 + level * 1.5,
      bDex: 3,
      bInt: 4 + level * 1.5,
      skillBook: [
        Skill(name: "후려치기", turn: 1, func: EnemySkills.strike),
        Skill(name: "꿰뚫기", turn: 1, func: EnemySkills.pierce),
      ],
    );

Character goblinArcher(int level) => enemy(
      name: "고블린 궁수",
      job: "적",
      level: level,
      bStr: 15 + level * 1.5,
      bDex: 3,
      bInt: 5 + level * 1.5,
      skillBook: [
        Skill(name: "사격", turn: 1, func: EnemySkills.shoot),
      ],
    );

Character goblinChief(int level) => enemy(
      name: "고블린 대장",
      job: "적",
      level: level,
      bStr: 100 + level * 2.0,
      bDex: 3,
      bInt: 12 + level * 2.0,
      skillBook: [
        Skill(name: "발구르기", turn: 1, func: EnemySkills.stomp),
        Skill(name: "꿰뚫기", turn: 1, func: EnemySkills.pierce),
        Skill(name: "방어구 부수기", turn: 1, func: EnemySkills.breakingArmor),
      ],
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
