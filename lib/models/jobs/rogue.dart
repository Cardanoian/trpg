import 'dart:math';

import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

Character rogue(String name) => Character(
      levelUp: rogueLevelUp,
      battleStart: battleStart,
      turnStart: turnStart,
      getDamage: baseGetDamage,
      getHp: baseGetHp,
      weapon: baseDagger,
      armor: baseLeather,
      accessory: baseAccessory,
      weaponType: Type.dagger,
      armorType: Type.leather,
      itemStats: [
        "atBonus",
        "combat",
        "dfBonus",
        "strength",
        "dex",
        "diceAdv",
      ],
      skillBook: [
        Skill(name: "비열한 일격", turn: 0.5, func: sinisterStrike),
        Skill(name: "절개", turn: 0.5, func: eviscerate),
        Skill(name: "칼날부채", turn: 0.5, func: fanOfKnife),
        Skill(),
        Skill(name: "평타", turn: 0.5, func: rogueBlow),
      ],
    );

void rogueLevelUp(Character me) {
  if (me.level >= 5) {
    me.maxSrc = 120;
    me.src = me.maxSrc;
  }
  baseLevelUp(me);
}

void battleStart(Character me) {
  me.src = me.maxSrc;
  me.link = 0;
}

void turnStart(Character me) {
  me.useSrc(me.cDex.toInt(), me);
  baseTurnStart(me);
}

bool rogueBlow(List<Character> targets, Character me) {
  int action = me.actionSuccess(me);
  double damage = me.getDamage(targets[0], me.cDex + me.combat, action) * -1;
  baseBlow(targets, damage, me);
  me.useSrc(action == 4 ? 20 : 10, me);
  return true;
}

@override
bool sinisterStrike(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  int action = me.actionSuccess(me);
  double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
  targets[0].getHp(damage, targets[0]);
  targets[0].getEffect(
      Effect(
        name: "비열한 일격",
        duration: 2,
        dfBonus: -1,
        buff: false,
      ),
      me);
  me.link += action < 3 ? 1 : 2;
  if (me.link > 4) {
    me.link = 4;
  }
  if (action == 4) {
    me.useSrc(20, me);
  }
  return true;
}

@override
bool eviscerate(List<Character> targets, Character me) {
  if (me.link == 0) {
    return false;
  }
  int action = me.actionSuccess(me);
  double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me) *
      pow(1.7, me.link);
  targets[0].getHp(damage, targets[0]);
  me.link = action < 4 ? 0 : me.link ~/ 2;
  return true;
}

@override
bool fanOfKnife(List<Character> targets, Character me) {
  if (me.link == 0) {
    return false;
  }
  int action = me.actionSuccess(me);
  for (Character target in targets) {
    double damage = me.getDamage(target, me.cDex + me.combat, action, me);
    target.getHp(damage * pow(1.7, me.link) * 0.5, target);
  }
  me.link = action < 4 ? 0 : me.link ~/ 2;
  return true;
}

// class Rogue extends Character {
//   int link = 0;
//
//   Rogue({
//     String name = "도적",
//     double strength = 6,
//     double dex = 9,
//     double intel = 3,
//     int level = 1,
//     int exp = 0,
//     double diceAdv = 0,
//   }) : super(
//           name: name,
//           job: "도적",
//           srcName: "기력",
//           lvS: 1,
//           lvD: 3,
//           lvI: 0,
//           src: 100,
//           maxSrc: 100,
//           bStr: strength,
//           bDex: dex,
//           bInt: intel,
//           level: 1,
//           exp: 0,
//           diceAdv: 0,
//           weaponType: Type.dagger,
//           armorType: Type.leather,
//           weapon: baseDagger,
//           armor: baseLeather,
//           accessory: baseAccessory,
//           skillBook: [
//             Skill(name: "비열한 일격", turn: 0.5),
//             Skill(name: "절개", turn: 0.5),
//             Skill(name: "칼날부채", turn: 0.5),
//             Skill(),
//             Skill(name: "평타", turn: 0.5),
//           ],
//           itemStats: [
//             "atBonus",
//             "combat",
//             "dfBonus",
//             "strength",
//             "dex",
//             "diceAdv",
//           ],
//         );
//
//   @override
//   void showTestInfo() {
//     print("\n버블: $link / 4");
//   }
//
//   @override
//   void levelUp() {
//     super.levelUp();
//     if (level >= 5) {
//       src = maxSrc = 120;
//       diceAdv += 1;
//     }
//   }
//
//   @override
//   void battleStart() {
//     src = maxSrc;
//     link = 0;
//   }
//
//   @override
//   void turnStart() {
//     super.turnStart();
//     useSrc(10);
//   }
//
//   bool useSrc(int src) {
//     if (src == 0 || src > this.src) {
//       return false;
//     }
//     this.src += src;
//     if (this.src <= 0) {
//       this.src = 0;
//     }
//     if (this.src >= maxSrc) {
//       this.src = maxSrc;
//     }
//     return true;
//   }
//
//   @override
//   bool blow(List<Character> targets) {
//     int action = actionSuccess();
//     targets[0].getHp(getDamage(targets[0], cDex + combat, action) * -1);
//     useSrc(action == 4 && level >= 5 ? 20 : 10);
//     return true;
//   }
//
//   @override
//   bool skill1(List<Character> targets) {
//     if (!useSrc(40)) {
//       return false;
//     }
//     int action = actionSuccess();
//     double damage = getDamage(targets[0], cDex + combat, action);
//     targets[0].getHp(damage);
//     targets[0].getEffect(Effect(
//       name: "비열한 일격",
//       duration: 2,
//       dfBonus: -1,
//       buff: false,
//     ));
//     link += action < 3 ? 1 : 2;
//     if (link > 4) {
//       link = 4;
//     }
//     if (action == 4) {
//       useSrc(-20);
//     }
//     return true;
//   }
//
//   @override
//   bool skill2(List<Character> targets) {
//     if (link == 0) {
//       return false;
//     }
//     int action = actionSuccess();
//     double damage =
//         getDamage(targets[0], cDex + combat, action) * pow(1.7, link);
//     targets[0].getHp(damage);
//     link = action < 4 ? 0 : link ~/ 2;
//     return true;
//   }
//
//   @override
//   bool skill3(List<Character> targets) {
//     if (link == 0) {
//       return false;
//     }
//     int action = actionSuccess();
//     for (Character target in targets) {
//       double damage = getDamage(target, cDex + combat, action);
//       target.getHp(damage * pow(1.7, link) * 0.5);
//     }
//     link = action < 4 ? 0 : link ~/ 2;
//     return true;
//   }
// }
