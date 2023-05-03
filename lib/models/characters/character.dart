import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skill.dart';

part 'character.g.dart';

@HiveType(typeId: 102)
class Character with ChangeNotifier {
  @HiveField(0)
  String name;
  @HiveField(1)
  String srcName;
  @HiveField(2)
  String job;
  @HiveField(3)
  double bStr;
  @HiveField(4)
  double bDex;
  @HiveField(5)
  double bInt;
  @HiveField(6)
  double lvS;
  @HiveField(7)
  double lvD;
  @HiveField(8)
  double lvI;
  @HiveField(9)
  double src;
  @HiveField(10)
  double maxSrc;
  @HiveField(11)
  double exp = 0;
  @HiveField(12)
  double diceAdv = 0;
  @HiveField(13)
  double atBonus = 0;
  @HiveField(14)
  double dfBonus = 0;
  @HiveField(15)
  double combat = 0;
  @HiveField(16)
  double gold = 0;
  @HiveField(17)
  int level = 1;
  @HiveField(18)
  List<Skill> skillBook;
  @HiveField(19)
  Type weaponType;
  @HiveField(20)
  Type armorType;
  @HiveField(21)
  double cStr = 0;
  @HiveField(22)
  double cDex = 0;
  @HiveField(23)
  double cInt = 0;
  @HiveField(24)
  double maxHp = 0;
  @HiveField(25)
  double hp = 0;
  @HiveField(26)
  List<Effect> effects = [];
  @HiveField(27)
  List<Item> inventory = [];
  @HiveField(28)
  List<String> itemStats = [];
  @HiveField(29)
  Item weapon;
  @HiveField(30)
  Item armor;
  @HiveField(31)
  Item accessory;
  @HiveField(32)
  bool hero;
  @HiveField(33)
  bool isAlive;
  @HiveField(34)
  List skillCools = [0, 0, 0, 0];
  @HiveField(35)
  double blowAvailable = 1;
  @HiveField(36)
  int link = 0;
  @HiveField(37)
  Character? lastTarget;
  @HiveField(38)
  Map<Character, double> aggro = {};
  @HiveField(39)
  double barrier = 0;
  @HiveField(40)
  bool tripleDamage = false;
  @HiveField(41)
  String lastSource = "";
  @HiveField(42)
  Function levelUp;
  @HiveField(43)
  Function battleStart;
  @HiveField(44)
  Function turnStart;
  @HiveField(45)
  Function getDamage;
  @HiveField(46)
  Function getHp;

  Character({
    this.job = "",
    this.lvS = 0,
    this.lvD = 0,
    this.lvI = 0,
    this.src = 0,
    this.maxSrc = 0,
    this.bStr = 0,
    this.bDex = 0,
    this.bInt = 0,
    this.level = 1,
    this.exp = 0,
    this.diceAdv = 0,
    this.weaponType = Type.shield,
    this.armorType = Type.plate,
    this.hero = false,
    this.isAlive = true,
    this.name = "NoName",
    this.srcName = "마나",
    required this.levelUp,
    required this.battleStart,
    required this.turnStart,
    required this.getDamage,
    required this.getHp,
    required this.itemStats,
    required this.weapon,
    required this.armor,
    required this.accessory,
    required this.skillBook,
  });

  @HiveField(100)
  void getEffect(Effect effect, Character me) {
    for (Effect myEffect in me.effects) {
      if (myEffect.name == effect.name && myEffect.by == effect.by) {
        myEffect.duration = effect.duration;
        myEffect.barrier = effect.barrier;
        notifyListeners();
        return;
      }
    }
    me.cStr += effect.strength;
    me.cDex += effect.dex;
    me.cInt += effect.intel;
    me.atBonus += effect.atBonus;
    me.combat += effect.combat;
    me.dfBonus += effect.dfBonus;
    me.diceAdv += effect.diceAdv;
    me.barrier += effect.barrier;
    me.effects.add(effect);
    notifyListeners();
  }

  @HiveField(101)
  void renewStat(Character me) {
    Effect tmpEffect = Effect(
        by: 'tmp',
        name: 'tmp',
        duration: 0,
        strength: 0,
        dex: 0,
        intel: 0,
        hp: 0,
        atBonus: 0,
        combat: 0,
        dfBonus: 0,
        diceAdv: 0);
    for (Effect effect in me.effects) {
      tmpEffect.strength += effect.strength;
      tmpEffect.dex += effect.dex;
      tmpEffect.intel += effect.intel;
      tmpEffect.atBonus += effect.atBonus;
      tmpEffect.combat += effect.combat;
      tmpEffect.dfBonus += effect.dfBonus;
      tmpEffect.diceAdv += effect.diceAdv;
      if (tmpEffect.addEffect != null) {
        tmpEffect.addEffect!(me, tmpEffect);
      }
    }
    me.cStr = me.bStr +
        me.weapon.strength +
        me.armor.strength +
        me.accessory.strength +
        tmpEffect.strength;
    me.cDex = me.bDex +
        me.weapon.dex +
        me.armor.dex +
        me.accessory.dex +
        tmpEffect.dex;
    me.cInt = me.bInt +
        me.weapon.intel +
        me.armor.intel +
        me.accessory.intel +
        tmpEffect.intel;
    me.atBonus = me.weapon.atBonus +
        me.armor.atBonus +
        me.accessory.atBonus +
        tmpEffect.atBonus;
    me.combat = me.weapon.combat +
        me.armor.combat +
        me.accessory.combat +
        tmpEffect.combat;
    me.dfBonus = me.weapon.dfBonus +
        me.armor.dfBonus +
        me.accessory.dfBonus +
        tmpEffect.dfBonus;
    me.diceAdv = me.weapon.diceAdv +
        me.armor.diceAdv +
        me.accessory.diceAdv +
        tmpEffect.diceAdv;
    me.maxHp = (me.level + me.bStr) * 5;
    if (me.hp >= me.maxHp) {
      me.hp = me.maxHp;
    }
    notifyListeners();
  }

  @HiveField(102)
  void getExp(int exp, Character me) {
    double maxExp = pow(10, me.level).toDouble();
    me.exp += exp;
    while (me.exp >= maxExp) {
      me.exp -= maxExp.toInt();
      me.levelUp(me);
      maxExp = pow(10, level).toDouble();
    }
    notifyListeners();
  }

  @HiveField(103)
  void defaultGetHp(double hp, Character me) {
    if (hp == 0) {
      return;
    }
    me.hp += hp;
    if (me.hp >= me.maxHp) {
      me.hp = me.maxHp;
    } else if (hp <= 0) {
      me.hp = 0;
      me.isAlive = false;
    }
    notifyListeners();
  }

  @HiveField(104)
  void getGold(double gold, Character me) {
    me.gold += gold;
    notifyListeners();
  }

  @HiveField(105)
  void getItem(Item item, Character me) {
    for (Item myItem in me.inventory) {
      if (item.name == myItem.name) {
        myItem.quantity += 1;
        notifyListeners();
        return;
      }
    }
    me.inventory.add(item);
    notifyListeners();
  }

  @HiveField(106)
  void wearItem(Item item, Character me) {
    if (item.itemType == ItemType.weapon) {
      if (item.type == me.weaponType) {
        me.getItem(weapon, me);
        me.weapon = item;
      }
    } else if (item.itemType == ItemType.armor) {
      if (item.type == me.armorType) {
        me.getItem(armor, me);
        me.armor = item;
      }
    } else if (item.itemType == ItemType.accessory) {
      me.getItem(accessory, me);
      me.accessory = item;
    }
    notifyListeners();
  }

  @HiveField(107)
  double calcWealth(Character me) {
    double wealth = me.gold;

    for (Item item in me.inventory) {
      wealth += item.cost * item.quantity;
    }
    return wealth;
  }

  @HiveField(108)
  int actionDice() {
    int randNum = Random().nextInt(36);
    return randNum == 35
        ? 12
        : randNum > 32
            ? 11
            : randNum > 29
                ? 10
                : randNum > 25
                    ? 9
                    : randNum > 20
                        ? 8
                        : randNum > 14
                            ? 7
                            : randNum > 9
                                ? 6
                                : randNum > 5
                                    ? 5
                                    : randNum > 2
                                        ? 4
                                        : randNum > 0
                                            ? 3
                                            : 2;
  }

  @HiveField(109)
  int actionSuccess(Character me) {
    double dice = actionDice() + me.diceAdv;
    if (dice >= 11) {
      return 4;
    } else if (dice >= 8) {
      return 3;
    } else if (dice >= 5) {
      return 2;
    } else {
      return 1;
    }
  }

  @HiveField(110)
  bool useSrc(int src, Character me) {
    if (me.src + src < 0) {
      return false;
    }
    me.src += src;
    me.src = me.src >= me.maxSrc ? me.maxSrc : me.src;
    notifyListeners();
    return true;
  }

  @HiveField(111)
  double getSpellPower(Character me) {
    return (me.cInt + me.combat) * me.actionSuccess(me) / 2;
  }

  @HiveField(112)
  static void baseLevelUp(Character me) {
    me.level++;
    me.bStr += me.lvS;
    me.bDex += me.lvD;
    me.bInt += me.lvI;
    me.renewStat(me);
  }

  @HiveField(113)
  static void baseTurnStart(Character me) {
    for (int i = 0; i < me.effects.length; i++) {
      me.effects[i].duration -= 1;
      if (me.effects[i].duration < 0) {
        me.effects.removeAt(i);
        continue;
      }
      me.getHp(me.effects[i].hp, me);
    }
    me.renewStat(me);
    me.blowAvailable += 1;
  }

  @HiveField(114)
  static double baseGetDamage(
      Character target, double stat, int action, Character me) {
    double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
    return -1 * me.weapon.atBonus * stat * action / defend / 2;
  }

  @HiveField(115)
  static bool baseBlow(List<Character> targets, double damage, Character me) {
    targets[0].getHp(damage, targets[0]);
    return true;
  }

  @HiveField(116)
  static void baseGetHp(double hp, Character me) {
    me.defaultGetHp(hp, me);
  }

  @HiveField(117)
  static void baseBattleStart(Character me) {}
// void showTestInfo() {}
//
// void test(List<Character> targets, Character me) {
//   double turns = 0;
//   bool playing = true;
//   double totalDamage = 0;
//   while (turns <= 10 && playing) {
//     double thisTurn = 0;
//     while (thisTurn <= 1) {
//       targets[0].getHp(500, me);
//       showTestInfo();
//       print(
//           "자원: $src / $maxSrc\n누적 데미지: $totalDamage\n사용 턴: ${turns % 1} / $turns");
//       print(skillBook);
//       String? ipt = stdin.readLineSync();
//       if (ipt == "q") {
//         playing = false;
//         break;
//       }
//       if (ipt == "p") {
//         break;
//       }
//       if (ipt == "1" && skillBook[0].func != null) {
//         skillBook[0].func!(targets, me);
//         thisTurn += skillBook[0].turn;
//         turns += skillBook[0].turn;
//       } else if (ipt == "2" && skillBook[1].func != null) {
//         skillBook[1].func!(targets, me);
//         thisTurn += skillBook[1].turn;
//         turns += skillBook[1].turn;
//       } else if (ipt == "3" && skillBook[2].func != null) {
//         skillBook[2].func!(targets, me);
//         thisTurn += skillBook[2].turn;
//         turns += skillBook[2].turn;
//       } else if (ipt == "4" && skillBook[3].func != null) {
//         skillBook[3].func!(targets, me);
//         thisTurn += skillBook[3].turn;
//         turns += skillBook[3].turn;
//       } else if (ipt == "5" && skillBook[4].func != null) {
//         skillBook[4].func!(targets, me);
//         thisTurn += skillBook[4].turn;
//         turns += skillBook[4].turn;
//       }
//       totalDamage += (targets[0].maxHp - targets[0].hp);
//     }
//     turnStart(me);
//   }
//   print("Total Damage: $totalDamage");
//   print("Used Turns: $turns");
//   print("Damage per Turn: ${totalDamage / turns}");
// }
}
