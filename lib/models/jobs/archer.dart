import '../character.dart';
import '../item.dart';
import '../skill.dart';

Character archer(String name) => Character(
      name: name,
      job: "궁수",
      levelUp: baseLevelUp,
      battleStart: archerBattleStart,
      turnStart: archerTurnStart,
      getDamage: archerGetDamage,
      getHp: baseGetHp,
      itemStats: [
        "atBonus",
        "combat",
        "dfBonus",
        "strength",
        "dex",
        "diceAdv",
      ],
      weapon: baseBow,
      armor: baseLeather,
      accessory: baseAccessory,
      weaponType: Type.bow,
      armorType: Type.leather,
      skillBook: [
        Skill(name: "신비한 사격", turn: 0.5, func: arcaneShot),
        Skill(name: "다발 사격", turn: 0.5, func: volley),
        Skill(name: "최후의 사격", turn: 0.5, func: killShot),
        Skill(),
        Skill(name: "평타", turn: 0.5, func: archerBlow),
      ],
    );

void archerBattleStart(Character me) {
  me.lastTarget = null;
  me.src = me.maxSrc;
}

double archerGetDamage(
    Character target, double stat, int action, Character me) {
  double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
  double damage = me.weapon.atBonus * stat * action / defend / 2;
  if (me.lastTarget != null) {
    if (me.lastTarget == target) {
      damage *= 2;
      me.useSrc(10, me);
    }
  }
  me.lastTarget = target;
  return damage;
}

void archerTurnStart(Character me) {
  me.skillCools[2] = 0;
  me.useSrc(me.cDex.toInt(), me);
  me.blowAvailable = true;
  baseTurnStart(me);
}

bool archerBlow(List<Character> targets, Character me) {
  if (me.blowAvailable == false) {
    return false;
  }
  targets[0].getHp(
      me.getDamage(
            targets[0],
            me.cDex + me.combat,
            me.actionSuccess(me),
            me,
          ) *
          2,
      me);
  me.blowAvailable = false;
  return true;
}

bool arcaneShot(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  targets[0].getHp(
      me.getDamage(
            targets[0],
            me.cDex + me.combat,
            me.actionSuccess(me),
            me,
          ) *
          3,
      me);
  return true;
}

bool volley(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  for (var target in targets) {
    target.getHp(
        me.getDamage(target, me.cDex + me.combat, me.actionSuccess(me)) * 1,
        me);
  }
  return true;
}

bool killShot(List<Character> targets, Character me) {
  if (me.skillCools[2] > 0 || targets[0].hp / targets[0].maxHp >= 0.3) {
    return false;
  }
  me.useSrc(20, me);
  targets[0].getHp(
      me.getDamage(targets[0], me.cDex + me.combat, me.actionSuccess(me), me) *
          3,
      me);
  me.skillCools[2] = 1;
  return true;
}

// class Archer extends Character {
//   Character? lastTarget;
//   bool lastShot = false;
//   bool blowAvailable = true;
//
//   Archer({
//     String name = "궁수",
//     double strength = 3,
//     double dex = 11,
//     double intel = 4,
//     int level = 1,
//     int exp = 0,
//     double diceAdv = 0,
//   }) : super(
//             name: name,
//             job: "궁수",
//             srcName: "기력",
//             bStr: strength,
//             bDex: dex,
//             bInt: intel,
//             lvS: 1,
//             lvD: 2,
//             lvI: 1,
//             src: 100,
//             maxSrc: 100,
//             level: 1,
//             exp: 0,
//             diceAdv: diceAdv,
//             weaponType: Type.bow,
//             armorType: Type.leather,
//             weapon: baseDagger,
//             armor: baseLeather,
//             accessory: baseAccessory,
//             skillBook: [
//               Skill(name: "신비한 사격", turn: 0.5),
//               Skill(name: "다발 사격", turn: 0.5),
//               Skill(name: "최후의 사격", turn: 0.5),
//               Skill(),
//               Skill(name: "평타", turn: 0.5),
//             ],
//             itemStats: [
//               "atBonus",
//               "combat",
//               "dfBonus",
//               "strength",
//               "dex",
//               "diceAdv",
//             ]);
//
//   @override
//   void battleStart() {
//     lastTarget = null;
//     src = maxSrc;
//   }
//
//   @override
//   double getDamage(Character target, double stat, int action) {
//     double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
//     double damage = weapon.atBonus * stat * action / defend / 2;
//     if (lastTarget != null) {
//       if (lastTarget == target) {
//         damage *= 2;
//         useSrc(-10);
//       }
//     }
//     lastTarget = target;
//     return damage;
//   }
//
//   bool useSrc(int src) {
//     if (src == 0 || src > this.src) {
//       return false;
//     }
//     this.src -= src;
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
//   void turnStart() {
//     super.turnStart();
//     lastShot = false;
//     int src = -20;
//     useSrc(src);
//     blowAvailable = true;
//   }
//
//   @override
//   bool blow(List<Character> targets) {
//     if (blowAvailable == false) {
//       return false;
//     }
//     targets[0].getHp(getDamage(targets[0], cDex + combat, actionSuccess()) * 2);
//     blowAvailable = false;
//     return true;
//   }
//
//   @override
//   bool skill1(List<Character> targets) {
//     if (!useSrc(40)) {
//       return false;
//     }
//     targets[0].getHp(getDamage(targets[0], cDex + combat, actionSuccess()) * 3);
//     return true;
//   }
//
//   @override
//   bool skill2(List<Character> targets) {
//     if (!useSrc(40)) {
//       return false;
//     }
//     for (var target in targets) {
//       target.getHp(getDamage(target, cDex + combat, actionSuccess()) * 1);
//     }
//     return true;
//   }
//
//   @override
//   bool skill3(List<Character> targets) {
//     if (lastShot || targets[0].hp / targets[0].maxHp >= 0.3) {
//       return false;
//     }
//     useSrc(-20);
//     targets[0].getHp(getDamage(targets[0], cDex + combat, actionSuccess()) * 3);
//     lastShot = true;
//     return true;
//   }
// }
