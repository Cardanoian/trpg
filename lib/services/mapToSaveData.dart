import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/characters/jobs/archer.dart';
import 'package:trpg/models/characters/jobs/paladin.dart';
import 'package:trpg/models/characters/jobs/priest.dart';
import 'package:trpg/models/characters/jobs/rogue.dart';
import 'package:trpg/models/characters/jobs/warrior.dart';
import 'package:trpg/models/characters/jobs/wizard.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/services/save_data.dart';

SaveData mapToSaveData(List mapData) {
  SaveData result = SaveData(
    heroes: [],
    enemies: [],
    lastPlayTime: DateTime.now(),
  );
  for (var heroData in mapData) {
    late Character hero;
    if (heroData["job"] == "전사") {
      hero = warrior(
        heroData["name"],
        result.heroes,
        result.enemies,
      );
    } else if (heroData["job"] == "성기사") {
      hero = paladin(
        heroData["name"],
        result.heroes,
        result.enemies,
      );
    } else if (heroData["job"] == "도적") {
      hero = rogue(
        heroData["name"],
        result.heroes,
        result.enemies,
      );
    } else if (heroData["job"] == "궁수") {
      hero = archer(
        heroData["name"],
        result.heroes,
        result.enemies,
      );
    } else if (heroData["job"] == "마법사") {
      hero = wizard(
        heroData["name"],
        result.heroes,
        result.enemies,
      );
    } else {
      hero = priest(
        heroData["name"],
        result.heroes,
        result.enemies,
      );
    }
    hero.level = heroData["level"];
    hero.exp = heroData["exp"];
    hero.inventory = <Item>[for (Item item in heroData["inventory"]) item];
    hero.hp = heroData["hp"];
    hero.src = heroData["src"];
    hero.gold = heroData["gold"];
    hero.weapon = heroData["weapon"];
    hero.armor = heroData["armor"];
    hero.accessory = heroData["accessory"];
    hero.isAlive = heroData["isAlive"];
    result.addHero(hero);
  }
  return result;
}
