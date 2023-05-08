import 'package:flutter/material.dart';

import '../characters/character.dart';
import '../effect.dart';

class EnemySkills {
  static bool strike(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(), me);
    targets[0].getHp(-2 * damage, me, targets[0]);
    return true;
  }

  static bool stomp(List<Character> targets, Character me) {
    for (var target in targets) {
      double damage = me.getDamage(target, me.cInt, me.actionSuccess(), me);
      target.getHp(-0.5 * damage, me, target);
    }
    return true;
  }

  static bool shoot(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(), me);
    targets[0].getHp(-2.5 * damage, me, targets[0]);
    return true;
  }

  static bool pierce(List<Character> targets, Character me) {
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(), me);
    targets[0].getHp(-0.5 * damage, me, targets[0]);
    targets[0].effects.add(
          Effect(
            hp: -0.5 * damage,
            name: "출혈",
            duration: 3,
            buff: false,
            by: me,
            image: Image.asset(
              "assets/imgs/effects/vampiricaura.png",
              scale: 0.4,
            ),
          ),
        );
    return true;
  }

  static bool breakingArmor(List<Character> targets, Character me) {
    int duration = 4;
    double damage = me.getDamage(targets[0], me.cInt, me.actionSuccess(), me);
    targets[0].getHp(-2 * damage, me, targets[0]);
    for (var effect in targets[0].effects) {
      if (effect.name == "방어구 부수기") {
        effect.dfBonus *= 2;
        effect.duration = duration;
        return true;
      }
    }
    targets[0].getEffect(
      Effect(
        by: me,
        name: "방어구 부수기",
        duration: duration,
        dfBonus: -2 - me.level * 0.2,
        buff: false,
        image: Image.asset(
          "assets/imgs/effects/shieldbreak.png",
          scale: 0.4,
        ),
      ),
    );
    return true;
  }

  static void enemyGetHp(double hp, Character by, Character me) {
    if (hp == 0) {
      return;
    }
    Character.baseGetHp(hp, by, me);
    if (hp < 0 && me.hp > 0) {
      double agg = by.job == "전사" || by.job == "성기사" ? hp * -5 : -hp;
      if (me.aggro.keys.contains(by)) {
        me.aggro[by] = me.aggro[by]! + agg;
      } else {
        me.aggro[by] = agg;
      }
    }
    if (me.name == "고블린 폭발병" && me.hp == 0) {
      bomb(me);
    }
  }

  static bool bomb(Character me) {
    for (var hero in me.heroes) {
      double damage = me.getDamage(hero, me.cInt, me.actionSuccess(), me) * 0.3;
      hero.getHp(damage, me, hero);
    }
    return true;
  }
}
