import 'package:hive/hive.dart';
import 'package:trpg/models/characters/character.dart';

part 'job_skills.g.dart';

@HiveType(typeId: 106)
class JobSkills {
  @HiveField(0)
  static void priestLevelUp(Character me) {
    me.level++;
    me.bStr += me.lvS;
    me.bDex += me.lvD;
    me.bInt += me.lvI;
    me.maxSrc = me.level * 10 + me.cInt * 5;
    me.src = me.maxSrc;
    me.renewStat(me);
  }

  @HiveField(1)
  static void priestBattleStart(Character me) {
    me.src = me.maxSrc;
  }

  @HiveField(2)
  static void archerBattleStart(Character me) {
    me.lastTarget = null;
    me.src = me.maxSrc;
  }

  @HiveField(3)
  static double archerGetDamage(
      Character target, double stat, int action, Character me) {
    double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
    double damage = me.weapon.atBonus * stat * action / defend / 2;
    if (me.lastTarget != null) {
      if (me.lastTarget == target) {
        damage *= 2;
        me.useSrc(10, me);
      }
    }
    me.lastTarget = target;
    return damage;
  }

  @HiveField(4)
  static void archerTurnStart(Character me) {
    me.skillCools[2] = 0;
    me.useSrc(me.cDex.toInt(), me);
    me.blowAvailable = 1;
    Character.baseTurnStart(me);
  }

  @HiveField(5)
  static bool archerBlow(List<Character> targets, Character me) {
    if (me.blowAvailable < 1) {
      return false;
    }
    targets[0].getHp(
        me.getDamage(
              targets[0],
              me.cDex + me.combat,
              me.actionSuccess(me),
              me,
            ) *
            2,
        me);
    me.blowAvailable -= 1;
    return true;
  }

  @HiveField(6)
  static void paladinBattleStart(Character me) {
    me.skillCools[0] = 0;
    me.skillCools[2] = 0;
    me.skillCools[3] = 0;
    me.src = 0;
  }

  @HiveField(7)
  static void paladinTurnStart(Character me) {
    Character.baseTurnStart(me);
    for (int i = 0; i < me.skillCools.length; i++) {
      if (me.skillCools[i] > 0) me.skillCools[i]--;
    }
  }

  @HiveField(8)
  static void rogueLevelUp(Character me) {
    if (me.level >= 5) {
      me.maxSrc = 120;
      me.src = me.maxSrc;
    }
    Character.baseLevelUp(me);
  }

  @HiveField(9)
  static void battleStart(Character me) {
    me.src = me.maxSrc;
    me.link = 0;
  }

  @HiveField(10)
  static void turnStart(Character me) {
    me.useSrc(me.cDex.toInt(), me);
    Character.baseTurnStart(me);
  }

  @HiveField(11)
  static bool rogueBlow(List<Character> targets, Character me) {
    int action = me.actionSuccess(me);
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action) * -1;
    Character.baseBlow(targets, damage, me);
    me.useSrc(action == 4 ? 20 : 10, me);
    return true;
  }

  @HiveField(12)
  static void warriorBattleStart(Character me) {
    me.src = 0;
    me.skillCools[0] = 0;
    me.skillCools[1] = 0;
  }

  @HiveField(13)
  static void warriorTurnStart(Character me) {
    me.skillCools[0] -= me.skillCools[0] > 0 ? 1 : 0;
    me.skillCools[1] -= me.skillCools[1] > 0 ? 1 : 0;
    Character.baseTurnStart(me);
  }

  @HiveField(14)
  static void warriorGetHp(double hp, Character me) {
    if (hp > 0) {
      me.useSrc(5, me);
    }
    me.defaultGetHp(hp, me);
  }

  @HiveField(15)
  static void wizardLevelUp(Character me) {
    me.maxSrc = me.level * 10 + me.cInt * 5;
    Character.baseLevelUp(me);
  }

  @HiveField(16)
  static double wizardGetDamage(Character target, String source, Character me) {
    double damage = -1 * (me.cInt + me.combat) * me.actionSuccess(me) / 2;
    if (me.tripleDamage) {
      damage *= 3;
      me.tripleDamage = false;
    }
    if (me.lastSource != "" && me.lastSource != source) {
      damage *= 2;
    }
    me.lastSource = source;
    return damage;
  }

  @HiveField(17)
  static void wizardBattleStart(Character me) {
    me.tripleDamage = false;
    me.lastSource = "";
    me.renewStat(me);
  }
}
