// import 'package:hive/hive.dart';
// import 'package:trpg/models/item.dart';
//
// import 'character.dart';
// import 'skill.dart';
//
// @HiveType(typeId: 105)
// class Enemy extends Character {
//   Enemy({
//     String name = "고블린",
//     int strength = 3,
//     int dex = 11,
//     int intel = 4,
//     int level = 1,
//     int exp = 0,
//     int diceAdv = 0,
//   }) : super(
//           name: name,
//           lvS: 1,
//           lvD: 2,
//           lvI: 1,
//           src: 100,
//           maxSrc: 100,
//           bStr: 0,
//           bDex: 0,
//           bInt: 0,
//           level: 1,
//           exp: 0,
//           diceAdv: 0,
//           weaponType: Type.dagger,
//           armorType: Type.leather,
//           weapon: baseDagger,
//           armor: baseLeather,
//           accessory: baseAccessory,
//           skillBook: defaultSkillBook,
//           itemStats: [],
//         );
//
//   @override
//   void battleStart() {
//     src = maxSrc;
//   }
//
//   @override
//   double getDamage(Character target, double stat, int action) {
//     double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
//     double damage = weapon.atBonus * stat * action / defend / 2;
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
//     int src = level >= 4 ? -20 : -10;
//     useSrc(src);
//   }
// }
