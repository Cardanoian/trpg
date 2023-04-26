import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

Character priest(String name) => Character(
      name: name,
      job: "사제",
      bStr: 4,
      bDex: 3,
      bInt: 11,
      getHp: baseGetHp,
      levelUp: priestLevelUp,
      battleStart: priestBattleStart,
      turnStart: baseTurnStart,
      getDamage: baseGetDamage,
      weaponType: Type.staff,
      armorType: Type.cloth,
      itemStats: [
        "combat",
        "dfBonus",
        "strength",
        "intel",
        "diceAdv",
      ],
      weapon: baseStaff,
      armor: baseCloth,
      accessory: baseAccessory,
      skillBook: [
        Skill(name: "소생", turn: 0.5, func: renew),
        Skill(name: "회개", turn: 1, func: penance),
        Skill(name: "치유", turn: 1, func: healing),
        Skill(name: "치유의 마법진", turn: 1, func: circleOfHealing),
        Skill(),
      ],
    );

void priestLevelUp(Character me) {
  me.level++;
  me.bStr += me.lvS;
  me.bDex += me.lvD;
  me.bInt += me.lvI;
  me.maxSrc = me.level * 10 + me.cInt * 5;
  me.src = me.maxSrc;
  me.renewStat(me);
}

void priestBattleStart(Character me) {
  me.src = me.maxSrc;
}

bool renew(List<Character> targets, Character me) {
  if (!me.useSrc(-10, me)) {
    return false;
  }
  double spellPower = me.getSpellPower(me) * 0.3;
  int duration = 5;
  targets[0].getHp(spellPower, targets[0]);
  targets[0].getEffect(
      Effect(
        name: "소생",
        duration: duration,
        hp: spellPower,
      ),
      targets[0]);
  return true;
}

bool penance(List<Character> targets, Character me, List<Character> heroes) {
  double spellPower = me.getSpellPower(me);
  targets[0].getHp(-2 * spellPower, targets[0]);
  Character target = me;
  for (var hero in heroes) {
    if (hero.hp / hero.maxHp < me.hp / me.maxHp) {
      target = hero;
    }
  }
  target.getHp(spellPower, target);
  return true;
}

bool healing(List<Character> targets, Character me) {
  if (targets[0] == me || me.hp <= 10) {
    return false;
  }
  me.getHp(-10, me);
  targets[0].getEffect(
      Effect(
        name: "보호",
        duration: 3,
        dfBonus: me.cStr / 3,
      ),
      targets[0]);
  targets[0].getHp(me.getSpellPower(me), me);
  return true;
}

bool circleOfHealing(List<Character> targets, Character me) {
  if (!me.useSrc(-40, me)) {
    return false;
  }
  double spellPower = me.getSpellPower(me) * 0.5;
  for (dynamic target in targets) {
    target.getHp(spellPower, target);
  }
  return true;
}

// class Priest extends Character {
//   Priest({
//     String name = "사제",
//     double strength = 4,
//     double dex = 3,
//     double intel = 11,
//     int level = 1,
//     int exp = 0,
//     double diceAdv = 0,
//   }) : super(
//           name: name,
//           job: "사제",
//           bStr: strength,
//           bDex: dex,
//           bInt: intel,
//           lvS: 2,
//           lvD: 0,
//           lvI: 2,
//           src: 0,
//           maxSrc: 65,
//           level: 1,
//           exp: 0,
//           diceAdv: diceAdv,
//           weaponType: Type.staff,
//           armorType: Type.cloth,
//           weapon: baseDagger,
//           armor: baseLeather,
//           accessory: baseAccessory,
//           skillBook: [
//             Skill(name: "소생", turn: 0.5),
//             Skill(name: "회개", turn: 1),
//             Skill(name: "치유", turn: 1),
//             Skill(name: "치유의 마법진", turn: 1),
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
//   void levelUp(Character me) {
//     me.level++;
//     me.bStr += me.lvS;
//     me.bDex += me.lvD;
//     me.bInt += me.lvI;
//     maxSrc = level * 10 + cInt * 5;
//     src = maxSrc;
//     renewStat(me);
//   }
//
//   @override
//   void battleStart(Character me) {
//     me.src = me.maxSrc;
//   }
//
//   bool useSrc(int src, Character me) {
//     if (me.src + src < 0) {
//       return false;
//     }
//     me.src += src;
//     if (me.src >= me.maxSrc) {
//       me.src = me.maxSrc;
//     }
//     return true;
//   }
//
//   @override
//   double getSpellPower(Character me) {
//     return (me.cInt + me.combat) * me.actionSuccess(me) / 2;
//   }
//
// @override
// bool skill1(List<Character> targets) {
//   if (!useSrc(-10)) {
//     return false;
//   }
//   double spellPower = getSpellPower() * 0.3;
//   int duration = 5;
//   targets[0].getHp(spellPower);
//   targets[0].getEffect(
//     Effect(
//       name: "소생",
//       duration: duration,
//       hp: spellPower,
//     ),
//   );
//   return true;
// }
//
// @override
// bool skill2(List<Character> targets) {
//   double spellPower = getSpellPower();
//   targets[0].getHp(-2 * spellPower);
//   getHp(spellPower);
//   return true;
// }
//
// @override
// bool skill3(List<Character> targets) {
//   if (targets[0] == this || hp <= 10) {
//     return false;
//   }
//   getHp(-10);
//   targets[0].getEffect(
//     Effect(
//       name: "보호",
//       duration: 3,
//       dfBonus: cStr / 3,
//     ),
//   );
//   targets[0].getHp(getSpellPower());
//   return true;
// }
//
// @override
// bool skill4(List<Character> targets) {
//   if (!useSrc(-40) || level < 3) {
//     return false;
//   }
//   double spellPower = getSpellPower() * 0.5;
//   for (dynamic target in targets) {
//     target.getHp(spellPower);
//   }
//   return true;
// }
// }
