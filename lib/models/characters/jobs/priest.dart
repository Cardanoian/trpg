import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skills/job_skills.dart';
import 'package:trpg/models/skills/magics.dart';
import 'package:trpg/models/skills/skill.dart';

Character priest(
  String name,
  List<Character> heroes,
  List<Character> enemies,
) =>
    Character(
      name: name,
      job: "사제",
      bStr: 4,
      bDex: 3,
      bInt: 11,
      lvS: 1,
      lvI: 3,
      getHp: Character.baseGetHp,
      levelUp: JobSkills.priestLevelUp,
      battleStart: JobSkills.priestBattleStart,
      turnStart: Character.baseTurnStart,
      getDamage: Character.baseGetDamage,
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
        Skill(name: "소생", turn: 0.5, func: Magics.renew, src: "mp 3"),
        Skill(name: "회개", turn: 0.5, func: Magics.penance),
        Skill(name: "치유", turn: 0.5, func: Magics.healing, src: "hp 10%"),
        Skill(
            name: "수호의 보호막",
            turn: 0.5,
            func: Magics.protectionBarrier,
            src: "mp 5"),
        Skill(
            name: "치유의 마법진",
            turn: 1,
            func: Magics.circleOfHealing,
            src: "mp 10"),
      ],
      heroes: heroes,
      enemies: enemies,
    );

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
