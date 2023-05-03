import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../models/characters/character.dart';

part 'save_data.g.dart';

@HiveType(typeId: 105)
class SaveData with ChangeNotifier {
  @HiveField(0)
  List<Character> heroes;
  @HiveField(1)
  List<Character> enemies;
  @HiveField(2)
  DateTime lastPlayTime;

  @HiveField(100)
  void addHero(Character hero) {
    heroes.add(hero);
    notifyListeners();
  }

  @HiveField(101)
  void removeHero(Character hero) {
    heroes.remove(hero);
    notifyListeners();
  }

  @HiveField(102)
  void clearHero() {
    heroes = <Character>[];
    notifyListeners();
  }

  @HiveField(110)
  void addEnemy(Character enemy) {
    enemies.add(enemy);
    notifyListeners();
  }

  @HiveField(111)
  void removeEnemy(Character enemy) {
    enemies.remove(enemy);
    notifyListeners();
  }

  @HiveField(112)
  void clearEnemy() {
    enemies = <Character>[];
    notifyListeners();
  }

  @HiveField(120)
  void resetPlayTime() {
    lastPlayTime = DateTime.now();
    notifyListeners();
  }

  @HiveField(121)
  void refreshData() {
    notifyListeners();
  }

  SaveData({
    required this.heroes,
    required this.enemies,
    required this.lastPlayTime,
  });
}

// SaveData boxToData(Map data) {
//   List<Character> heroes = [
//     for (var charMap in data["heroes"]) makeMapToCharacter(charMap)
//   ];
//   List<Character> enemies = [
//     for (var charMap in data["enemies"]) makeMapToCharacter(charMap)
//   ];
//   SaveData saveData = SaveData(
//       heroes: heroes, enemies: enemies, lastPlayTime: data["lastPlayTime"]);
//   return saveData;
// }
//
// Map dataToBox(SaveData saveData) {
//   List<Map> heroes = [
//     for (var hero in saveData.heroes) makeCharacterToMap(hero)
//   ];
//   List<Map> enemies = [
//     for (var hero in saveData.enemies) makeCharacterToMap(hero)
//   ];
//   Map<String, dynamic> mapData = {
//     "heroes": heroes,
//     "enemies": enemies,
//     "lastPlayTime": DateTime.now(),
//   };
//   return mapData;
// }
//
// Map makeCharacterToMap(Character character) => {
//       "name": character.name,
//       "srcName": character.srcName,
//       "bStr": character.bStr,
//       "bDex": character.bDex,
//       "bInt": character.bInt,
//       "lvS": character.lvS,
//       "lvD": character.lvD,
//       "lvI": character.lvI,
//       "src": character.src,
//       "maxSrc": character.maxSrc,
//       "level": character.level,
//       "exp": character.exp,
//       "diceAdv": character.diceAdv,
//       "atBonus": character.atBonus,
//       "dfBonus": character.dfBonus,
//       "combat": character.combat,
//       "gold": character.gold,
//       "skillBook": character.skillBook,
//       "weaponType": character.weaponType,
//       "armorType": character.armorType,
//       "effects": character.effects,
//       "inventory": character.inventory,
//       "itemStats": character.itemStats,
//       "weapon": character.weapon,
//       "armor": character.armor,
//       "accessory": character.accessory,
//       "hero": character.hero,
//       "isAlive": character.isAlive,
//       "job": character.runtimeType.toString()
//     };
//
// Character makeMapToCharacter(Map map) {
//   late Character character;
//   switch (map["job"]) {
//     case "Warrior":
//       character = warrior(map["name"]);
//       break;
//     case "Paladin":
//       character = paladin(map["name"]);
//       break;
//     case "Rogue":
//       character = rogue(map["name"]);
//       break;
//     case "Archer":
//       character = archer(map["name"]);
//       break;
//     case "Wizard":
//       character = wizard(map["name"]);
//       break;
//     case "Priest":
//       character = priest(map["name"]);
//       break;
//     default:
//       character = Enemy(skillBook: defaultSkillBook);
//       break;
//   }
//   character.name = map["name"];
//   character.srcName = map["srcName"];
//   character.bStr = map["bStr"];
//   character.bDex = map["bDex"];
//   character.bInt = map["bInt"];
//   character.lvS = map["lvS"];
//   character.lvD = map["lvD"];
//   character.lvI = map["lvI"];
//   character.src = map["src"];
//   character.maxSrc = map["maxSrc"];
//   character.level = map["level"];
//   character.exp = map["exp"];
//   character.diceAdv = map["diceAdv"];
//   character.atBonus = map["atBonus"];
//   character.dfBonus = map["dfBonus"];
//   character.combat = map["combat"];
//   character.gold = map["gold"];
//   character.skillBook = map["skillBook"];
//   character.weaponType = map["weaponType"];
//   character.armorType = map["armorType"];
//   character.effects = <Effect>[for (Effect e in map["effects"]) e];
//   character.inventory = <Item>[for (Item e in map["inventory"]) e];
//   character.itemStats = <String>[for (String e in map["itemStats"]) e];
//   character.weapon = map["weapon"];
//   character.armor = map["armor"];
//   character.accessory = map["accessory"];
//   character.hero = map["hero"];
//   character.isAlive = map["isAlive"];
//   return character;
// }
