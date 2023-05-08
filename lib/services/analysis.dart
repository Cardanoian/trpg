import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';

class AnalysisClass with ChangeNotifier {
  double _damage = 0;
  double _lostHp = 0;
  double _heal = 0;

  double get damage => _damage;

  double get lostHp => _lostHp;

  double get heal => _heal;

  void update({double damage = 0, double lostHp = 0, double heal = 0}) {
    _damage += damage;
    _lostHp += lostHp;
    _heal += heal;
    notifyListeners();
  }

  void updateWithAnalysisClass(AnalysisClass analysis) {
    _damage += analysis.damage;
    _lostHp += analysis.lostHp;
    _heal += analysis.heal;
    notifyListeners();
  }

  @override
  String toString() {
    return "데미지: $_damage  피해량: $_lostHp  치유량: $_heal";
  }
}

class AnalysisMap {
  static Map<Character, AnalysisClass> _analysis = {};

  static Map<Character, AnalysisClass> get analysis => _analysis;

  static void add(Character by, Character to, double hp) {
    AnalysisClass tmpAnalysis = AnalysisClass();
    late Character character;
    if (by.hero && !to.hero && hp < 0) {
      tmpAnalysis.update(damage: -hp);
      character = by;
    } else if (!by.hero && to.hero && hp < 0) {
      tmpAnalysis.update(lostHp: -hp);
      character = to;
    } else if (by.hero && to.hero && hp > 0) {
      tmpAnalysis.update(heal: hp);
      character = by;
    } else {
      return;
    }
    if (_analysis.keys.contains(character)) {
      _analysis[character]!.updateWithAnalysisClass(tmpAnalysis);
    } else {
      _analysis[character] = tmpAnalysis;
    }
  }

  static void clear() {
    _analysis = {};
  }
}
