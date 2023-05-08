import 'package:flutter/foundation.dart';
import 'package:trpg/models/characters/character.dart';

class SaveData with ChangeNotifier {
  List<Character> heroes;
  List<Character> enemies;
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
