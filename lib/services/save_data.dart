import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:trpg/models/characters/character.dart';

part 'save_data.g.dart';

@HiveType(typeId: 105)
class SaveData with ChangeNotifier {
  @HiveField(0)
  List<Character> heroes;
  @HiveField(1)
  List<Character> enemies;
  @HiveField(2)
  DateTime lastPlayTime;

  void addHero(Character hero) {
    heroes.add(hero);
    notifyListeners();
  }

  void removeHero(Character hero) {
    heroes.remove(hero);
    notifyListeners();
  }

  void clearHero() {
    heroes = <Character>[];
    notifyListeners();
  }

  void addEnemy(Character enemy) {
    enemies.add(enemy);
    notifyListeners();
  }

  void removeEnemy(Character enemy) {
    enemies.remove(enemy);
    notifyListeners();
  }

  void clearEnemy() {
    enemies = <Character>[];
    notifyListeners();
  }

  void resetPlayTime() {
    lastPlayTime = DateTime.now();
    notifyListeners();
  }

  void refreshData() {
    notifyListeners();
  }

  SaveData({
    required this.heroes,
    required this.enemies,
    required this.lastPlayTime,
  });
}
