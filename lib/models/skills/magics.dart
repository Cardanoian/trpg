import 'dart:math';

import 'package:hive/hive.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/effect.dart';

part 'magics.g.dart';

@HiveType(typeId: 107)
class Magics {
  @HiveField(1)
  static bool renew(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-3, me)) {
      return false;
    }
    double spellPower = me.getSpellPower(me) * 0.3;
    int duration = 5;
    targets[0].getHp(spellPower, targets[0]);
    targets[0].getEffect(
        Effect(
          name: "소생",
          duration: duration,
          hp: spellPower,
          by: me.name,
        ),
        targets[0]);
    return true;
  }

  @HiveField(2)
  static bool penance(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    double spellPower = me.getSpellPower(me);
    targets[0].getHp(-2 * spellPower, targets[0]);
    Character target = me;
    for (var hero in heroes) {
      if (hero.hp / hero.maxHp < me.hp / me.maxHp) {
        target = hero;
      }
    }
    target.getHp(spellPower * 0.5, target);
    return true;
  }

  @HiveField(3)
  static bool healing(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (targets[0] == me || me.hp / me.maxHp <= 0.1) {
      return false;
    }
    me.getHp(me.maxHp * 0.1, me);
    targets[0].getEffect(
        Effect(
          name: "보호",
          duration: 2,
          dfBonus: me.cStr / 4,
          by: me.name,
        ),
        targets[0]);
    targets[0].getHp(me.getSpellPower(me), me);
    return true;
  }

  @HiveField(4)
  static bool protectionBarrier(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-5, me)) return false;
    targets[0].getEffect(
        Effect(
          name: "수호의 보호막",
          by: me.name,
          dfBonus: me.cInt / 5,
          duration: 2,
          diceAdv: me.cStr / 4,
        ),
        me);
    return true;
  }

  @HiveField(5)
  static bool circleOfHealing(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-10, me)) {
      return false;
    }
    double spellPower = me.getSpellPower(me) * 0.7;
    for (dynamic target in targets) {
      target.getHp(spellPower, target);
    }
    return true;
  }

  @HiveField(6)
  static bool arcaneShot(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-40, me)) {
      return false;
    }
    targets[0].getHp(
        me.getDamage(
              targets[0],
              me.cDex + me.combat,
              me.actionSuccess(me),
              me,
            ) *
            3,
        me);
    return true;
  }

  @HiveField(7)
  static bool volley(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-40, me)) {
      return false;
    }
    for (var target in targets) {
      target.getHp(
          me.getDamage(target, me.cDex + me.combat, me.actionSuccess(me)) * 1,
          me);
    }
    return true;
  }

  @HiveField(8)
  static bool killShot(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.skillCools[2] > 0 || targets[0].hp / targets[0].maxHp >= 0.3) {
      return false;
    }
    me.useSrc(20, me);
    targets[0].getHp(
        me.getDamage(
                targets[0], me.cDex + me.combat, me.actionSuccess(me), me) *
            3,
        me);
    me.skillCools[2] = 1;
    return true;
  }

  @HiveField(9)
  static bool judgement(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.skillCools[0] != 0) {
      return false;
    }
    me.skillCools[0] = 1;
    int action = me.actionSuccess(me);
    if (action == 4) {
      me.skillCools[3] -= me.skillCools[3] != 0 ? 1 : 0;
    }
    double damage = me.getDamage(
        targets[0], me.cStr / 2.0 + me.cInt + me.combat, action, me);
    targets[0].getHp(damage, targets[0]);
    me.getHp(damage * 0.5, me);
    me.useSrc(action == 4 ? 2 : 1, me);
    return true;
  }

  @HiveField(10)
  static bool shieldOfRighteous(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.src < 3) {
      return false;
    }
    int action = me.actionSuccess(me);
    me.useSrc(-3, me);
    if (action == 4) {
      me.useSrc(1, me);
    }
    me.getEffect(
        Effect(
          name: "신성한 방패",
          duration: 2,
          dfBonus: me.armor.dfBonus,
        ),
        me);
    for (Character target in targets) {
      double damage =
          me.getDamage(target, me.cStr / 2 + me.cInt + me.combat, action, me) *
              0.5;
      target.getHp(damage, target);
    }
    return true;
  }

  @HiveField(11)
  static bool avengersShield(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.skillCools[2] != 0) {
      return false;
    }
    me.skillCools[2] = 2;
    int action = me.actionSuccess(me);
    if (action == 4) {
      me.skillCools[3] -= me.skillCools[3] != 0 ? 1 : 0;
    }
    me.useSrc(action == 4 ? 3 : 2, me);
    for (var target in targets) {
      double damage =
          me.getDamage(target, me.cStr / 2 + me.cInt + me.combat, action, me);
      target.getHp(damage, target);
    }
    return true;
  }

  @HiveField(12)
  static bool flashOfLight(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.skillCools[3] != 0) {
      return false;
    }
    me.getHp(me.combat, me);
    me.useSrc(2, me);
    me.skillCools[0] = 0;
    me.skillCools[2] = 0;
    me.skillCools[3] = 5;
    return true;
  }

  @HiveField(13)
  static bool sinisterStrike(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-40, me)) {
      return false;
    }
    int action = me.actionSuccess(me);
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
    targets[0].getHp(damage, targets[0]);
    targets[0].getEffect(
        Effect(
          name: "비열한 일격",
          duration: 2,
          dfBonus: -1,
          buff: false,
        ),
        me);
    me.link += action < 3 ? 1 : 2;
    if (me.link > 4) {
      me.link = 4;
    }
    if (action == 4) {
      me.useSrc(20, me);
    }
    return true;
  }

  @HiveField(14)
  static bool eviscerate(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.link == 0) {
      return false;
    }
    int action = me.actionSuccess(me);
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me) *
        pow(1.7, me.link);
    targets[0].getHp(damage, targets[0]);
    me.link = action < 4 ? 0 : me.link ~/ 2;
    return true;
  }

  @HiveField(15)
  static bool fanOfKnife(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.link == 0) {
      return false;
    }
    int action = me.actionSuccess(me);
    for (Character target in targets) {
      double damage = me.getDamage(target, me.cDex + me.combat, action, me);
      target.getHp(damage * pow(1.7, me.link) * 0.5, target);
    }
    me.link = action < 4 ? 0 : me.link ~/ 2;
    return true;
  }

  @HiveField(16)
  static bool thunderClap(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.skillCools[0] > 0) {
      return false;
    }
    me.skillCools[0] = 2;
    me.useSrc(5 * targets.length, me);
    for (Character target in targets) {
      target.getHp(
          me.getDamage(target, me.cStr + me.combat, me.actionSuccess(me), me) *
              -1,
          target);
      target.getEffect(
        Effect(
          name: "메스꺼움",
          duration: 1,
          atBonus: me.cStr * 0.5,
          by: me.name,
          buff: false,
        ),
        target,
      );
    }
    return true;
  }

  @HiveField(17)
  static bool charge(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (me.skillCools[1] > 0) {
      return false;
    }
    me.useSrc(20, me);
    me.skillCools[1] = 3;
    return true;
  }

  @HiveField(18)
  static bool shieldWall(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-20, me)) {
      return false;
    }
    me.getEffect(
      Effect(
        name: "방패의 벽",
        duration: 2,
        dfBonus: me.cStr / 8,
        diceAdv: 1,
      ),
      me,
    );
    return true;
  }

  @HiveField(19)
  static bool shieldSlam(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-20, me)) {
      return false;
    }
    targets[0].getHp(
        me.getDamage(
                targets[0], me.cStr + me.combat, me.actionSuccess(me), me) *
            2,
        targets[0]);
    me.getEffect(
      Effect(
        name: "강화된 방패",
        duration: 1,
        diceAdv: 1,
      ),
      me,
    );
    return true;
  }

  @HiveField(20)
  static bool arcaneBarrage(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    me.useSrc(15, me);
    targets[0].getHp(me.getDamage(targets[0], "비전", me) * 0.5, targets[0]);
    return true;
  }

  @HiveField(21)
  static bool fireBall(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-3, me)) {
      return false;
    }
    targets[0].getHp(me.getDamage(targets[0], "화염", me) * 2, targets[0]);
    return true;
  }

  @HiveField(22)
  static bool flameStrike(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-5, me)) {
      return false;
    }
    for (Character target in targets) {
      target.getHp(me.getDamage(target, "화염", me), target);
    }
    return true;
  }

  @HiveField(23)
  static bool arcaneBlast(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-3, me)) {
      return false;
    }
    targets[0].getHp(me.getDamage(targets[0], "비전", me), targets[0]);
    me.tripleDamage = true;
    return true;
  }

  @HiveField(24)
  static bool chainLightning(List<Character> targets, Character me,
      List<Character> heroes, List<Character> enemies) {
    if (!me.useSrc(-5, me)) {
      return false;
    }
    for (int i = 0; i < 3 || i < targets.length; i++) {
      targets[i].getHp(me.getDamage(targets[i], "전기", me), targets[i]);
    }
    return true;
  }
}
