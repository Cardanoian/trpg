import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skills/job_skills.dart';
import 'package:trpg/models/skills/magics.dart';
import 'package:trpg/models/skills/skill.dart';

Character paladin(
  String name,
  List<Character> heroes,
  List<Character> enemies,
) =>
    Character(
      bStr: 10,
      bDex: 2,
      bInt: 6,
      lvS: 2,
      lvI: 2,
      name: name,
      job: "성기사",
      srcName: "신성한 힘",
      maxSrc: 5,
      levelUp: Character.baseLevelUp,
      battleStart: JobSkills.paladinBattleStart,
      getDamage: Character.baseGetDamage,
      getHp: JobSkills.paladinGetHp,
      turnStart: JobSkills.paladinTurnStart,
      weapon: baseShield,
      armor: basePlate,
      accessory: baseAccessory,
      weaponType: Type.shield,
      armorType: Type.plate,
      itemStats: [
        "atBonus",
        "combat",
        "dfBonus",
        "strength",
        "intel",
        "diceAdv"
      ],
      skillBook: [
        Skill(name: "심판", turn: 0.5, func: Magics.judgement, src: "1 회복"),
        Skill(
            name: "정의의 방패",
            turn: 0,
            func: Magics.shieldOfRighteous,
            src: "3 소모"),
        Skill(
            name: "응징의 방패",
            turn: 0.5,
            func: Magics.avengersShield,
            src: "2 회복"),
        Skill(
            name: "빛의 가호",
            turn: 0.5,
            func: Magics.flashOfLight,
            src: "쿨 감소, 2회복"),
        Skill(name: "평타", turn: 0.5, func: Character.baseBlow),
        Skill(name: "도발", turn: 0, func: JobSkills.provocation),
      ],
      heroes: heroes,
      enemies: enemies,
    );

bool blow(List<Character> targets, Character me) {
  if (me.blowAvailable < 1) {
    return false;
  }
  int action = me.actionSuccess();
  targets[0].getHp(
      me.getDamage(
              targets[0], me.cStr / 2.0 + me.cInt + me.combat, action, me) *
          -1,
      me);
  me.blowAvailable -= 1;
  return true;
}

// Skills

// class Paladin extends Character {
//   int judCool = 0;
//   int avgCool = 0;
//   int blessCool = 0;
//   bool blowAvailable = true;
//
//   Paladin({
//     String name = "성기사",
//     double strength = 9,
//     double dex = 3,
//     double intel = 6,
//     int level = 1,
//     int exp = 0,
//     double diceAdv = 0,
//   }) : super(
//           name: name,
//           job: "성기사",
//           srcName: "신성한 힘",
//           bStr: strength,
//           bDex: dex,
//           bInt: intel,
//           lvS: 2,
//           lvD: 0,
//           lvI: 2,
//           src: 0,
//           maxSrc: 5,
//           level: 1,
//           exp: 0,
//           diceAdv: diceAdv,
//           weaponType: Type.shield,
//           armorType: Type.plate,
//           weapon: baseShield,
//           armor: basePlate,
//           accessory: baseAccessory,
//           skillBook: [
//             Skill(name: "심판", turn: 0.5),
//             Skill(name: "정의의 방패", turn: 0.5),
//             Skill(name: "응징의 방패", turn: 0.5),
//             Skill(name: "빛의 가호", turn: 0.5),
//             Skill(name: "평타", turn: 0.5),
//           ],
//           itemStats: [
//             "atBonus",
//             "combat",
//             "dfBonus",
//             "strength",
//             "intel",
//             "diceAdv"
//           ],
//         );
//
//   @override
//   void battleStart() {
//     judCool = 0;
//     avgCool = 0;
//     blessCool = 0;
//     src = 0;
//   }
//
//   @override
//   void turnStart() {
//     super.turnStart();
//     judCool -= judCool > 0 ? 1 : 0;
//     avgCool -= avgCool > 0 ? 1 : 0;
//     blessCool -= blessCool > 0 ? 1 : 0;
//   }
//
//   void getSrc(int point) {
//     src += point;
//     if (src > maxSrc) {
//       src = maxSrc;
//     }
//     if (src < 0) {
//       src = 0;
//     }
//   }
//
//   @override
//   bool blow(List<Character> targets) {
//     if (blowAvailable == false) {
//       return false;
//     }
//     targets[0].getHp(
//         getDamage(targets[0], cStr / 2.0 + cInt + combat, actionSuccess()) *
//             -1);
//     blowAvailable = false;
//     return true;
//   }
//
// // Skills
//
//   @override
//   bool skill1(List<Character> targets) {
//     if (judCool != 0) {
//       return false;
//     }
//     judCool = 1;
//     int action = actionSuccess();
//     if (action == 4) {
//       blessCool -= blessCool != 0 ? 1 : 0;
//     }
//     double damage = getDamage(targets[0], cStr / 2.0 + cInt + combat, action);
//     targets[0].getHp(damage);
//     getHp(damage * 0.5);
//     getSrc(action == 4 ? 2 : 1);
//     return true;
//   }
//
//   @override
//   bool skill2(List<Character> targets) {
//     if (src < 3) {
//       return false;
//     }
//     int action = actionSuccess();
//     getSrc(-3);
//     if (action == 4) {
//       getSrc(1);
//     }
//     getEffect(Effect(
//       name: "신성한 방패",
//       duration: 2,
//       dfBonus: dfBonus,
//     ));
//     for (Character target in targets) {
//       double damage = getDamage(target, cStr / 2 + cInt + combat, action) * 0.5;
//       target.getHp(damage);
//     }
//     return true;
//   }
//
//   @override
//   bool skill3(List<Character> targets) {
//     if (avgCool != 0) {
//       return false;
//     }
//     avgCool = 2;
//     int action = actionSuccess();
//     if (action == 4) {
//       blessCool -= blessCool != 0 ? 1 : 0;
//     }
//     getSrc(action == 4 ? 3 : 2);
//     for (var target in targets) {
//       double damage = getDamage(target, cStr / 2 + cInt + combat, action);
//       target.getHp(damage);
//     }
//     return true;
//   }
//
//   @override
//   bool skill4(List<Character> targets) {
//     if (blessCool != 0) {
//       return false;
//     }
//     double damage = getDamage(
//       targets[0],
//       cStr / 2.0 + cInt + combat,
//       actionSuccess(),
//     );
//     getHp(damage);
//     getSrc(2);
//     avgCool = 0;
//     judCool = 0;
//     blessCool = 5;
//     return true;
//   }
// }
