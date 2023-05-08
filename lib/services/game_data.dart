import 'dart:math';

import 'package:flutter/material.dart';

class GameData with ChangeNotifier {
  final String title = "TRPG";
  double _gold = 0;
  double _exp = 0;
  double _itemRating = 0;
  int _pageIndex = 0;
  int _playIndex = 0;

  int get pageIndex => _pageIndex;

  int get playIndex => _playIndex;

  double get gold => _gold;

  double get exp => _exp;

  double get itemRating => _itemRating;

  void updatePlayIndex(int num) {
    _playIndex = num;
    notifyListeners();
  }

  void updatePageIndex(int pageNum) {
    _pageIndex = pageNum;
    notifyListeners();
  }

  void resetBattlePoint() {
    _gold = 0;
    _exp = 0;
    _itemRating = 0;
    notifyListeners();
  }

  void changeBattlePoint(int level, double hp) {
    _gold += level;
    _exp += pow(level, 2);
    _itemRating += pow(level, 2);
    notifyListeners();
  }
}
