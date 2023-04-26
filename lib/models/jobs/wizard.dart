import '../character.dart';
import '../item.dart';
import '../skill.dart';

Character wizard(String name) => Character(
      levelUp: wizardLevelUp,
      battleStart: wizardBattleStart,
      turnStart: baseTurnStart,
      getDamage: wizardGetDamage,
      getHp: baseGetHp,
      weapon: baseStaff,
      armor: baseCloth,
      accessory: baseAccessory,
      itemStats: [
        "combat",
        "dfBonus",
        "strength",
        "intel",
        "diceAdv",
      ],
      skillBook: [
        Skill(name: "비전 탄막", turn: 0.5, func: arcaneBarrage),
        Skill(name: "연쇄 번개", turn: 1, func: chainLightning),
        Skill(name: "화염 기둥", turn: 1, func: flameStrike),
        Skill(name: "비전 작렬", turn: 0.5, func: arcaneBlast),
        Skill(),
      ],
    );

void wizardLevelUp(Character me) {
  me.maxSrc = me.level * 10 + me.cInt * 5;
  baseLevelUp(me);
}

double wizardGetDamage(Character target, String source, Character me) {
  double damage = -1 * (me.cInt + me.combat) * me.actionSuccess(me) / 2;
  if (me.doubleDamage) {
    damage *= 2;
    me.doubleDamage = false;
  }
  if (me.lastSource != "" && me.lastSource != source) {
    damage *= 2;
  }
  me.lastSource = source;
  return damage;
}

@override
void wizardBattleStart(Character me) {
  me.doubleDamage = false;
  me.lastSource = "";
  me.renewStat(me);
}

@override
bool arcaneBarrage(List<Character> targets, Character me) {
  me.useSrc(20, me);
  targets[0].getHp(me.getDamage(targets[0], "비전", me), targets[0]);
  return true;
}

@override
bool chainLightning(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  for (Character target in targets) {
    target.getHp(me.getDamage(target, "전기", me), target);
  }
  return true;
}

@override
bool flameStrike(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  for (Character target in targets) {
    target.getHp(me.getDamage(target, "화염", me) * 0.5, target);
  }
  return true;
}

@override
bool arcaneBlast(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  targets[0].getHp(me.getDamage(targets[0], "비전", me), targets[0]);
  me.doubleDamage = true;
  return true;
}
//
// class Wizard extends Character {
//   bool doubleDamage = false;
//   String lastSource = "";
//
//   Wizard({
//     String name = "마법사",
//     double strength = 3,
//     double dex = 3,
//     double intel = 12,
//     int level = 1,
//     int exp = 0,
//     double diceAdv = 0,
//   }) : super(
//           name: name,
//           job: "마법사",
//           lvS: 1,
//           lvD: 0,
//           lvI: 3,
//           src: 70,
//           maxSrc: 70,
//           bStr: strength,
//           bDex: dex,
//           bInt: intel,
//           level: 1,
//           exp: 0,
//           diceAdv: diceAdv,
//           weaponType: Type.staff,
//           armorType: Type.cloth,
//           weapon: baseDagger,
//           armor: baseLeather,
//           accessory: baseAccessory,
//           skillBook: [
//             Skill(name: "비전 탄막", turn: 1),
//             Skill(name: "연쇄 번개", turn: 1),
//             Skill(name: "화염 기둥", turn: 1),
//             Skill(name: "비전 작렬", turn: 1),
//             Skill(),
//           ],
//           itemStats: [
//             "combat",
//             "dfBonus",
//             "strength",
//             "intel",
//             "diceAdv",
//           ],
//         );
//
//   @override
//   void levelUp() {
//     super.levelUp();
//     maxSrc = level * 10 + cInt * 5;
//   }
//
//   bool useSrc(int src) {
//     if (src == 0 || this.src + src < 0) {
//       return false;
//     }
//     this.src += src;
//     if (this.src >= maxSrc) {
//       this.src = maxSrc;
//     }
//     return true;
//   }
//
//   double getMagicDamage(Character target, String source) {
//     double damage = -1 * (cInt + combat) * actionSuccess() / 2;
//     if (doubleDamage) {
//       damage *= 2;
//       doubleDamage = false;
//     }
//     if (lastSource != "" && lastSource != source) {
//       damage *= 2;
//     }
//     lastSource = source;
//     return damage;
//   }
//
//   @override
//   void battleStart() {
//     doubleDamage = false;
//     lastSource = "";
//   }
//
//   @override
//   bool skill1(List<Character> targets) {
//     useSrc(20);
//     targets[0].getHp(getMagicDamage(targets[0], "비전"));
//     return true;
//   }
//
//   @override
//   bool skill2(List<Character> targets) {
//     if (!useSrc(-40)) {
//       return false;
//     }
//     for (Character target in targets) {
//       target.getHp(getMagicDamage(target, "전기"));
//     }
//     return true;
//   }
//
//   @override
//   bool skill3(List<Character> targets) {
//     if (!useSrc(-40)) {
//       return false;
//     }
//     for (Character target in targets) {
//       target.getHp(getMagicDamage(target, "화염") * 0.5);
//     }
//     return true;
//   }
//
//   @override
//   bool skill4(List<Character> targets) {
//     if (!useSrc(-40)) {
//       return false;
//     }
//     targets[0].getHp(getMagicDamage(targets[0], "비전"));
//     doubleDamage = true;
//     return true;
//   }
// }
