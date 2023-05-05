import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';

class Targets extends ChangeNotifier {
  List<Character> items = <Character>[];

  void add(item) {
    items.add(item);
    notifyListeners();
  }

  void remove(item) {
    items.remove(item);
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  void clear() {
    items = [];
    notifyListeners();
  }
}
