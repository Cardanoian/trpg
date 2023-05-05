import 'dart:math';

import 'package:flutter/material.dart';

class BattlePoint with ChangeNotifier {
  double _gold = 0;
  double _exp = 0;
  double _itemRating = 0;

  double get gold => _gold;

  double get exp => _exp;

  double get itemRating => _itemRating;

  void resetBattlePoint() {
    _gold = 0;
    _exp = 0;
    _itemRating = 0;
    notifyListeners();
  }

  void changeBattlePoint(int level, double hp) {
    _gold += level;
    _exp += pow(level, 2);
    _itemRating += level * 2;
    notifyListeners();
  }
}
