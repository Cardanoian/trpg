import 'package:hive/hive.dart';
import 'package:trpg/models/characters/character.dart';

part 'job_skills.g.dart';

@HiveType(typeId: 106)
class JobSkills {
  // Priest
  @HiveField(0)
  static void priestLevelUp(Character me) {
    me.level++;
    me.bStr += me.lvS;
    me.bDex += me.lvD;
    me.bInt += me.lvI;
    me.maxSrc = me.level * 10 + me.cInt * 5;
    me.src = me.maxSrc;
    me.refreshStatus();
  }

  @HiveField(1)
  static void priestBattleStart(Character me) {
    me.src = me.maxSrc;
  }

  // Archer
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
        me.useSrc(10);
      }
    }
    me.lastTarget = target;
    return damage;
  }

  @HiveField(4)
  static void archerTurnStart(Character me) {
    me.skillCools[2] = 0;
    me.useSrc(me.cDex.toInt());
    me.blowAvailable = 1;
    Character.baseTurnStart(me);
  }

  @HiveField(5)
  static bool archerBlow(List<Character> targets, Character me) {
    if (me.blowAvailable < 1) {
      return false;
    }
    int action = me.actionSuccess();
    double damage =
        2.0 * me.getDamage(targets[0], me.cDex + me.combat, action, me);
    me.blowAvailable -= 1;
    Character.baseBlow(targets, damage, me);
    return true;
  }

  // Paladin
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

  static void paladinGetHp(double hp, Character by, Character me) {
    if (hp < 0) {
      for (var effect in me.effects) {
        if (effect.name == "신성한 방패") {
          hp /= 2;
          break;
        }
      }
    }
    me.getHp(hp, by, me);
  }

  // Rogue
  static void rogueBattleStart(Character me) {
    Character.baseBattleStart(me);
    me.src = me.maxSrc;
    me.link = 0;
  }

  static void rogueTurnStart(Character me) {
    me.useSrc(me.cDex.toInt());
    Character.baseTurnStart(me);
  }

  static bool rogueBlow(List<Character> targets, Character me) {
    if (me.timePoint < 0.5) {
      return false;
    }
    int action = me.actionSuccess();
    double damage = me.getDamage(targets[0], me.cDex + me.combat, action) * -1;
    Character.baseBlow(targets, damage, me);
    me.useSrc(action == 4 ? 20 : 10);
    me.timePoint -= 0.5;
    return true;
  }

  // Warrior
  static void warriorBattleStart(Character me) {
    Character.baseBattleStart(me);
    me.src = 0;
    me.skillCools[0] = 0;
    me.skillCools[1] = 0;
  }

  static void warriorTurnStart(Character me) {
    me.skillCools[0] -= (me.skillCools[0] > 0 ? 1 : 0);
    me.skillCools[1] -= (me.skillCools[1] > 0 ? 1 : 0);
    Character.baseTurnStart(me);
  }

  static void warriorGetHp(double hp, Character by, Character me) {
    if (hp > 0) {
      me.useSrc(me.cStr ~/ 3);
    }
    me.getHp(hp, by, me);
  }

  // Wizard

  static double wizardGetDamage(
      Character target, String source, Character me, int action) {
    double damage = -me.getSpellPower(action);
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

  static void wizardBattleStart(Character me) {
    me.tripleDamage = false;
    me.lastSource = "";
    Character.baseBattleStart(me);
  }

  // Common
  @HiveField(18)
  static void provocation(Character me, List<Character> targets) {
    double aggro = 0;
    Character target = targets[0];
    for (Character char in target.aggro.keys) {
      if (target.aggro[char]! > aggro) {
        aggro = target.aggro[char]!;
      }
    }
    target.aggro[me] = aggro;
  }
}
