import 'package:trpg/services/save_data.dart';

List saveDataToMap(SaveData saveData) {
  List result = [];
  for (var hero in saveData.heroes) {
    Map<String, dynamic> heroMap = {};
    heroMap["job"] = hero.job;
    heroMap["name"] = hero.name;
    heroMap["level"] = hero.level;
    heroMap["exp"] = hero.exp;
    heroMap["inventory"] = hero.inventory;
    heroMap["hp"] = hero.hp;
    heroMap["src"] = hero.src;
    heroMap["gold"] = hero.gold;
    heroMap["weapon"] = hero.weapon;
    heroMap["armor"] = hero.armor;
    heroMap["accessory"] = hero.accessory;
    heroMap["isAlive"] = hero.isAlive;
    result.add(heroMap);
  }
  return result;
}
