import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skills/job_skills.dart';
import 'package:trpg/models/skills/magics.dart';
import 'package:trpg/models/skills/skill.dart';

Character wizard(String name) => Character(
      name: name,
      job: "마법사",
      bStr: 3,
      bDex: 2,
      bInt: 13,
      lvS: 1,
      lvI: 3,
      levelUp: JobSkills.wizardLevelUp,
      battleStart: JobSkills.wizardBattleStart,
      turnStart: Character.baseTurnStart,
      getDamage: JobSkills.wizardGetDamage,
      getHp: Character.baseGetHp,
      weaponType: Type.staff,
      armorType: Type.cloth,
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
        Skill(
            name: "비전 탄막",
            turn: 0.5,
            func: Magics.arcaneBarrage,
            src: "비전, 15회복"),
        Skill(
            name: "비전 작렬", turn: 0.5, func: Magics.arcaneBlast, src: "비전, 3소모"),
        Skill(
            name: "연쇄 번개",
            turn: 0.5,
            func: Magics.chainLightning,
            src: "전기, 5소모"),
        Skill(name: "화염구", turn: 0.5, func: Magics.fireBall, src: "화염, 3소모"),
        Skill(name: "화염 기둥", turn: 1, func: Magics.flameStrike, src: "화염, 5소모"),
      ],
    );

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
