import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/effect.dart';

class Magics {
  //Priest
  static bool renew(List<Character> targets, Character me) {
    if (!me.useSrc(-3) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double spellPower = me.getSpellPower(action);
    targets[0].getHp(spellPower * 0.3, me, targets[0]);
    int duration = 5;
    targets[0].getEffect(
      Effect(
        name: "소생",
        duration: duration,
        hp: spellPower * 0.3,
        by: me,
        image: Image.asset(
          "assets/imgs/effects/priest/renew.png",
          scale: 0.4,
        ),
      ),
    );
    me.timePoint -= 0.5;
    return true;
  }

  static bool penance(List<Character> targets, Character me) {
    if (me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double spellPower = me.getSpellPower(action);
    targets[0].getHp(-2 * spellPower, me, targets[0]);
    Character target = me;
    for (var hero in me.heroes) {
      if (hero.hp / hero.maxHp < me.hp / me.maxHp) {
        target = hero;
      }
    }
    target.getHp(spellPower * 0.5, me, target);
    me.timePoint -= 0.5;
    return true;
  }

  static bool healing(List<Character> targets, Character me) {
    if (targets[0] == me || me.hp / me.maxHp <= 0.1 || me.timePoint < 0.5) {
      return false;
    }
    me.getHp(me.maxHp * -0.1, me, me);
    targets[0].getEffect(
      Effect(
        name: "보호",
        duration: 1,
        dfBonus: me.cStr / 4,
        by: me,
        image: Image.asset(
          "assets/imgs/effects/priest/atonement.png",
          scale: 0.4,
        ),
      ),
    );
    int action = me.actionSuccess();
    double spellPower = me.getSpellPower(action);
    targets[0].getHp(spellPower, me, targets[0]);
    me.timePoint -= 0.5;
    return true;
  }

  static bool protectionBarrier(List<Character> targets, Character me) {
    if (!me.useSrc(-4) || me.timePoint < 0.5) {
      return false;
    }
    targets[0].getEffect(
      Effect(
        name: "수호의 보호막",
        by: me,
        dfBonus: me.cInt / 5,
        duration: 2,
        diceAdv: me.cStr / 4,
        image: Image.asset("assets/imgs/effects/priest/powerwordshield.png",
            scale: 0.4),
      ),
    );
    me.timePoint -= 0.5;
    return true;
  }

  static bool circleOfHealing(List<Character> targets, Character me) {
    if (!me.useSrc(-10) || me.timePoint < 1) {
      return false;
    }
    int action = me.actionSuccess();
    double spellPower = me.getSpellPower(action);
    for (var target in targets) {
      target.getHp(spellPower * 0.6, me, target);
      target.effects.add(
        Effect(
          name: "빛의 반향",
          duration: 2,
          by: me,
          hp: spellPower * 0.1,
          image: Image.asset(
            "assets/imgs/effects/priest/aspiration.png",
            scale: 0.4,
          ),
        ),
      );
    }
    me.timePoint -= 1;
    return true;
  }

  // Archer
  static bool arcaneShot(List<Character> targets, Character me) {
    if (!me.useSrc(-40) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
    targets[0].getHp(damage * 3, me, targets[0]);
    me.timePoint -= 0.5;
    return true;
  }

  static bool explosiveShot(List<Character> targets, Character me) {
    if (!me.useSrc(-20) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
    targets[0].getHp(damage * 0.2, me, targets[0]);
    targets[0].getEffect(
      Effect(
        name: "폭발 사격",
        by: me,
        duration: 2,
        hp: damage * 0.9,
        image: Image.asset(
          "assets/imgs/effects/archer/explosive_shot.png",
          scale: 0.4,
        ),
      ),
    );
    me.timePoint -= 0.5;
    return true;
  }

  static bool volley(List<Character> targets, Character me) {
    if (!me.useSrc(-40) || me.timePoint < 0.5) {
      return false;
    }
    Character? lastTarget = me.lastTarget;
    int action = me.actionSuccess();
    for (var target in targets) {
      double damage = me.getDamage(target, me.cDex + me.combat, action, me);
      target.getHp(damage * 1, me, target);
    }
    if (lastTarget != null) {
      if (targets.contains(lastTarget)) {
        me.lastTarget = lastTarget;
      }
    }
    me.timePoint -= 0.5;
    return true;
  }

  static bool killShot(List<Character> targets, Character me) {
    if (me.skillCools[2] > 0 ||
        targets[0].hp / targets[0].maxHp >= 0.3 ||
        me.timePoint < 0.5) {
      return false;
    }
    me.useSrc(20);
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
    targets[0].getHp(damage * 3, me, targets[0]);
    me.skillCools[2] = 1;
    me.timePoint -= 0.5;
    return true;
  }

  //Paladin
  static bool judgement(List<Character> targets, Character me) {
    if (me.skillCools[0] != 0 || me.timePoint < 0.5) {
      return false;
    }
    me.skillCools[0] = 1;
    int action = me.actionSuccess();
    if (action == 4) {
      me.skillCools[3] -= me.skillCools[3] != 0 ? 1 : 0;
    }
    double damage =
        me.getDamage(targets[0], me.cStr / 2 + me.cInt + me.combat, action, me);
    targets[0].getHp(damage, me, targets[0]);
    me.getHp(damage * -0.5, me, me);
    me.useSrc(action == 4 ? 2 : 1);
    me.timePoint -= 0.5;
    return true;
  }

  static bool shieldOfRighteous(List<Character> targets, Character me) {
    if (me.src < 3 || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    me.useSrc(-3);
    if (action == 4) {
      me.useSrc(1);
    }
    me.getEffect(
      Effect(
        name: "신성한 방패",
        by: me,
        duration: 2,
        image: Image.asset(
          "assets/imgs/effects/paladin/professionalisation.png",
          scale: 0.4,
        ),
      ),
    );
    for (Character target in targets) {
      double damage =
          me.getDamage(target, me.cStr / 2 + me.cInt + me.combat, action, me);
      target.getHp(damage * 0.5, me, target);
    }
    me.timePoint -= 0.5;
    return true;
  }

  static bool avengersShield(List<Character> targets, Character me) {
    if (me.skillCools[2] != 0 || me.timePoint < 0.5) {
      return false;
    }
    me.skillCools[2] = 2;
    int action = me.actionSuccess();
    if (action == 4) {
      me.skillCools[3] -= (me.skillCools[3] > 0 ? 1 : 0);
    }
    me.useSrc(action == 4 ? 3 : 2);
    for (var target in targets) {
      double damage =
          me.getDamage(target, me.cStr / 2 + me.cInt + me.combat, action, me);
      target.getHp(damage, me, target);
    }
    me.timePoint -= 0.5;
    return true;
  }

  static bool flashOfLight(List<Character> targets, Character me) {
    if (me.skillCools[3] != 0 || me.timePoint < 0.5) {
      return false;
    }
    for (var hero in me.heroes) {
      double heal = me.combat + me.cInt + (me.cStr / 2);
      me.getHp(heal * 0.3, me, hero);
    }
    me.useSrc(2);
    me.skillCools[0] = 0;
    me.skillCools[2] = 0;
    me.skillCools[3] = 5;
    me.timePoint -= 0.5;
    return true;
  }

  // Rogue
  static bool sinisterStrike(List<Character> targets, Character me) {
    if (!me.useSrc(-40) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
    targets[0].getHp(damage, me, targets[0]);
    targets[0].getEffect(
      Effect(
        name: "비열한 일격",
        by: me,
        duration: 2,
        dfBonus: -0.08 * me.cDex,
        buff: false,
        image: Image.asset(
          "assets/imgs/effects/rogue/curseofsargeras.png",
          scale: 0.4,
        ),
      ),
    );
    me.link += action < 3 ? 1 : 2;
    if (me.link > 4) {
      me.link = 4;
    }
    if (action == 4) {
      me.useSrc(20);
    }
    me.timePoint -= 0.5;
    return true;
  }

  static bool eviscerate(List<Character> targets, Character me) {
    if (me.link == 0 || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action, me);
    targets[0].getHp(damage * pow(1.7, me.link), me, targets[0]);
    me.link = action < 4 ? 0 : me.link ~/ 2;
    me.timePoint -= 0.5;
    return true;
  }

  static bool fanOfKnife(List<Character> targets, Character me) {
    if (me.link == 0 || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    for (Character target in targets) {
      double damage = me.getDamage(target, me.cDex + me.combat, action, me);
      target.getHp(damage * pow(1.7, me.link) * 0.4, target);
    }
    me.link = action < 4 ? 0 : me.link ~/ 2;
    me.timePoint -= 0.5;
    return true;
  }

  // Warrior
  static bool thunderClap(List<Character> targets, Character me) {
    if (me.skillCools[0] > 0 || me.timePoint < 0.5) {
      return false;
    }
    me.skillCools[0] = 2;
    me.useSrc((0.5 * me.cStr * targets.length).toInt());
    int action = me.actionSuccess();
    for (Character target in targets) {
      double damage = me.getDamage(target, me.cStr + me.combat, action, me);
      target.getHp(damage, me, target);
      target.getEffect(
        Effect(
          name: "메스꺼움",
          duration: 2,
          atBonus: -log(me.cStr - me.level * 3 - 6) / log(5),
          by: me,
          buff: false,
          image: Image.asset(
            "assets/imgs/effects/emotionafraid.png",
            scale: 0.4,
          ),
        ),
      );
    }
    me.timePoint -= 0.5;
    return true;
  }

  static bool charge(List<Character> targets, Character me) {
    if (me.skillCools[1] > 0 || me.timePoint < 0.5) {
      return false;
    }
    me.useSrc(20);
    me.skillCools[1] = 3;
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cStr + me.combat, action, me);
    targets[0].getHp(damage * -0.5, me, targets[0]);
    me.timePoint -= 0.5;
    return true;
  }

  static bool shieldWall(List<Character> targets, Character me) {
    if (!me.useSrc(-20) || me.timePoint < 0.5) {
      return false;
    }
    me.getEffect(
      Effect(
        name: "방패의 벽",
        by: me,
        duration: 2,
        dfBonus: log(me.cStr - me.level * 3) / log(10),
        diceAdv: 1,
        image: Image.asset(
          "assets/imgs/effects/warrior/shieldwall.png",
          scale: 0.4,
        ),
      ),
    );
    me.timePoint -= 0.5;
    return true;
  }

  static bool shieldSlam(List<Character> targets, Character me) {
    if (!me.useSrc(-20) || me.timePoint < 0.5) {
      return true;
    }
    int action = me.actionSuccess();
    double damage =
        me.getDamage(targets[0], me.cStr + me.combat, action, me) * 2;
    targets[0].getHp(damage, targets[0]);
    me.getEffect(
      Effect(
        name: "강화된 방패",
        by: me,
        duration: 1,
        dfBonus: log(me.cStr - me.level * 3) / log(10),
        diceAdv: 1,
        image: Image.asset(
          "assets/imgs/effects/warrior/safeguard.png",
          scale: 0.4,
        ),
      ),
    );
    me.timePoint -= 0.5;
    return true;
  }

  // Wizard
  static bool arcaneBarrage(List<Character> targets, Character me) {
    if (me.timePoint < 0.5) {
      return false;
    }
    me.useSrc(20);
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], "비전", me, action);
    targets[0].getHp(damage * 0.5, me, targets[0]);
    me.timePoint -= 0.5;
    return true;
  }

  static bool fireBall(List<Character> targets, Character me) {
    if (!me.useSrc(-3) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], "화염", me, action);
    targets[0].getHp(damage * 2, me, targets[0]);
    me.timePoint -= 0.5;
    return true;
  }

  static bool flameStrike(List<Character> targets, Character me) {
    if (!me.useSrc(-7) || me.timePoint < 1) {
      return false;
    }
    int action = me.actionSuccess();
    for (Character target in targets) {
      double damage = me.getDamage(target, "화염", me, action);
      target.getHp(damage, me, target);
    }
    me.timePoint -= 1;
    return true;
  }

  static bool arcaneBlast(List<Character> targets, Character me) {
    if (!me.useSrc(-3) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], "비전", me, action);
    targets[0].getHp(damage, me, targets[0]);
    me.tripleDamage = true;
    me.timePoint -= 0.5;
    return true;
  }

  static bool chainLightning(List<Character> targets, Character me) {
    if (!me.useSrc(-5) || me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    for (int i = 0; i < 3 || i < targets.length; i++) {
      double damage = me.getDamage(targets[i], "전기", me, action);
      targets[i].getHp(damage, me, targets[i]);
    }
    me.timePoint -= 0.5;
    return true;
  }
}
