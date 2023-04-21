import 'package:flutter/foundation.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/jobs/archer.dart';
import 'package:trpg/models/jobs/paladin.dart';
import 'package:trpg/models/jobs/priest.dart';
import 'package:trpg/models/jobs/rogue.dart';
import 'package:trpg/models/jobs/wizard.dart';

import '../models/character.dart';
import '../models/enemy.dart';
import '../models/item.dart';
import '../models/jobs/warrior.dart';

class SaveData with ChangeNotifier {
  List<Character> heroes;
  List<Character> enemies;
  DateTime lastPlayTime;

  SaveData({
    required this.heroes,
    required this.enemies,
    required this.lastPlayTime,
  });
}

SaveData boxToData(Map data) {
  List<Character> heroes = [
    for (var charMap in data["heroes"]) makeMapToCharacter(charMap)
  ];
  List<Character> enemies = [
    for (var charMap in data["enemies"]) makeMapToCharacter(charMap)
  ];
  SaveData saveData = SaveData(
      heroes: heroes, enemies: enemies, lastPlayTime: data["lastPlayTime"]);
  return saveData;
}

Map dataToBox(SaveData saveData) {
  List<Map> heroes = [
    for (var hero in saveData.heroes) makeCharacterToMap(hero)
  ];
  List<Map> enemies = [
    for (var hero in saveData.enemies) makeCharacterToMap(hero)
  ];
  Map<String, dynamic> mapData = {
    "heroes": heroes,
    "enemies": enemies,
    "lastPlayTime": DateTime.now(),
  };
  return mapData;
}

Map makeCharacterToMap(Character character) => {
      "name": character.name,
      "srcName": character.srcName,
      "bStr": character.bStr,
      "bDex": character.bDex,
      "bInt": character.bInt,
      "lvS": character.lvS,
      "lvD": character.lvD,
      "lvI": character.lvI,
      "src": character.src,
      "maxSrc": character.maxSrc,
      "level": character.level,
      "exp": character.exp,
      "diceAdv": character.diceAdv,
      "atBonus": character.atBonus,
      "dfBonus": character.dfBonus,
      "combat": character.combat,
      "gold": character.gold,
      "skillBook": character.skillBook,
      "weaponType": character.weaponType,
      "armorType": character.armorType,
      "effects": character.effects,
      "inventory": character.inventory,
      "itemStats": character.itemStats,
      "weapon": character.weapon,
      "armor": character.armor,
      "accessory": character.accessory,
      "hero": character.hero,
      "isAlive": character.isAlive,
      "job": character.runtimeType.toString()
    };

Character makeMapToCharacter(Map map) {
  late Character character;
  switch (map["job"]) {
    case "Warrior":
      character = Warrior();
      break;
    case "Paladin":
      character = Paladin();
      break;
    case "Rogue":
      character = Rogue();
      break;
    case "Archer":
      character = Archer();
      break;
    case "Wizard":
      character = Wizard();
      break;
    case "Priest":
      character = Priest();
      break;
    default:
      character = Enemy();
      break;
  }
  character.name = map["name"];
  character.srcName = map["srcName"];
  character.bStr = map["bStr"];
  character.bDex = map["bDex"];
  character.bInt = map["bInt"];
  character.lvS = map["lvS"];
  character.lvD = map["lvD"];
  character.lvI = map["lvI"];
  character.src = map["src"];
  character.maxSrc = map["maxSrc"];
  character.level = map["level"];
  character.exp = map["exp"];
  character.diceAdv = map["diceAdv"];
  character.atBonus = map["atBonus"];
  character.dfBonus = map["dfBonus"];
  character.combat = map["combat"];
  character.gold = map["gold"];
  character.skillBook = map["skillBook"];
  character.weaponType = map["weaponType"];
  character.armorType = map["armorType"];
  character.effects = <Effect>[for (Effect e in map["effects"]) e];
  character.inventory = <Item>[for (Item e in map["inventory"]) e];
  character.itemStats = <String>[for (String e in map["itemStats"]) e];
  character.weapon = map["weapon"];
  character.armor = map["armor"];
  character.accessory = map["accessory"];
  character.hero = map["hero"];
  character.isAlive = map["isAlive"];
  return character;
}
