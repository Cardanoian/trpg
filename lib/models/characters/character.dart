import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skills/skill.dart';
import 'package:trpg/services/analysis.dart';
import 'package:trpg/services/skill_result.dart';

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
  @HiveField(47)
  List<Character> heroes;
  @HiveField(48)
  List<Character> enemies;
  @HiveField(49)
  double timePoint = 1;
  @HiveField(50)
  bool _onTurn = false;

  bool get onTurn => _onTurn;

  void turnOn() {
    _onTurn = true;
    notifyListeners();
  }

  void turnOff() {
    _onTurn = false;
    notifyListeners();
  }

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
    required this.heroes,
    required this.enemies,
  }) {
    refreshStatus();
    hp = maxHp;
    src = maxSrc;
    refreshStatus();
  }

  void getEffect(Effect effect) {
    for (Effect myEffect in effects) {
      if (myEffect.name == effect.name && myEffect.by == effect.by) {
        myEffect.duration = effect.duration;
        notifyListeners();
        return;
      }
    }
    cStr += effect.strength;
    cDex += effect.dex;
    cInt += effect.intel;
    atBonus += effect.atBonus;
    combat += effect.combat;
    dfBonus += effect.dfBonus;
    diceAdv += effect.diceAdv;
    effects.add(effect);
    notifyListeners();
  }

  void refreshStatus() {
    Effect tmpEffect = Effect(
      by: this,
      name: 'tmp',
      duration: 0,
      strength: 0,
      dex: 0,
      intel: 0,
      hp: 0,
      atBonus: 0,
      combat: 0,
      dfBonus: 0,
      diceAdv: 0,
      image: Image.asset(
        "assets/imgs/effects/seal.png",
        scale: 0.4,
      ),
    );
    for (Effect effect in effects) {
      tmpEffect.strength += effect.strength;
      tmpEffect.dex += effect.dex;
      tmpEffect.intel += effect.intel;
      tmpEffect.atBonus += effect.atBonus;
      tmpEffect.combat += effect.combat;
      tmpEffect.dfBonus += effect.dfBonus;
      tmpEffect.diceAdv += effect.diceAdv;
      if (tmpEffect.hp != 0) {
        getHp(hp, effect.by, this);
      }
      // if (tmpEffect.addEffect != null) {
      //   tmpEffect.addEffect!(tmpEffect);
      // }
    }
    cStr = bStr +
        weapon.strength +
        armor.strength +
        accessory.strength +
        tmpEffect.strength;
    cDex = bDex + weapon.dex + armor.dex + accessory.dex + tmpEffect.dex;
    cInt =
        bInt + weapon.intel + armor.intel + accessory.intel + tmpEffect.intel;
    diceAdv = weapon.diceAdv +
        armor.diceAdv +
        accessory.diceAdv +
        tmpEffect.diceAdv +
        (job == "도적" ? 1 : 0);
    atBonus =
        weapon.atBonus + armor.atBonus + accessory.atBonus + tmpEffect.atBonus;
    if (atBonus < 0.1) {
      atBonus = 0.1;
    }
    dfBonus =
        weapon.dfBonus + armor.dfBonus + accessory.dfBonus + tmpEffect.dfBonus;
    maxHp = level * 10 + cStr * 5;
    combat = weapon.combat + armor.combat + accessory.combat + tmpEffect.combat;
    if (hp >= maxHp) {
      hp = maxHp;
    }
    if (job == "마법사" || job == "사제") {
      maxSrc = (level + cInt) * 10;
    }
    if (job == "도적") {
      if (level >= 5) {
        maxSrc = 120;
      } else {
        maxSrc = 100;
      }
    }
    notifyListeners();
  }

  void getExp(int exp) {
    double maxExp = pow(10, level).toDouble();
    this.exp += exp;
    while (this.exp >= maxExp) {
      this.exp -= maxExp.toInt();
      levelUp(this);
      maxExp = pow(10, level).toDouble();
    }
    refreshStatus();
    notifyListeners();
  }

  void lostExp() {
    double maxExp = pow(10, level).toDouble();
    exp -= maxExp * 0.1;
    while (exp < 0) {
      level--;
      bStr -= lvS;
      bDex -= lvD;
      bInt -= lvI;
      maxExp = pow(10, level).toDouble();
      exp += maxExp;
    }
    notifyListeners();
  }

  void defaultGetHp(double hp, Character by) {
    if (hp == 0) {
      return;
    }
    if (hp > 0) {
      if (maxHp - this.hp < hp) {
        AnalysisMap.add(by, this, maxHp - this.hp);
      } else {
        AnalysisMap.add(by, this, hp);
      }
    } else {
      if (hp > this.hp) {
        AnalysisMap.add(by, this, this.hp);
      } else {
        AnalysisMap.add(by, this, hp);
      }
    }
    this.hp += hp;
    if (this.hp >= maxHp) {
      this.hp = maxHp;
    } else if (this.hp <= 0) {
      this.hp = 0;
      isAlive = false;
    }
    notifyListeners();
  }

  void getGold(double gold) {
    this.gold += gold;
    notifyListeners();
  }

  void getItem(Item item) {
    inventory.add(item);
    notifyListeners();
  }

  void wearItem(Item item) {
    if (item.itemType == ItemType.weapon) {
      if (item.type == weaponType) {
        getItem(weapon);
        weapon = item;
      }
    } else if (item.itemType == ItemType.armor) {
      if (item.type == armorType) {
        getItem(armor);
        armor = item;
      }
    } else if (item.itemType == ItemType.accessory) {
      getItem(accessory);
      accessory = item;
    }
    notifyListeners();
  }

  double calcWealth() {
    double wealth = gold;

    for (Item item in inventory) {
      wealth += item.cost * item.quantity;
    }
    return wealth;
  }

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

  int actionSuccess() {
    double dice = actionDice() + diceAdv;
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

  bool useSrc(int src) {
    if (this.src + src < 0) {
      return false;
    }
    this.src += src;
    this.src = this.src >= maxSrc ? maxSrc : this.src;
    notifyListeners();
    return true;
  }

  double getSpellPower(int action) {
    return (cInt + combat) * action / 2;
  }

  static void baseLevelUp(Character me) {
    me.level++;
    me.bStr += me.lvS;
    me.bDex += me.lvD;
    me.bInt += me.lvI;
    me.refreshStatus();
  }

  static void baseTurnStart(Character me) {
    me.timePoint += 1;
    me.refreshStatus();
    List<Effect> tmpEffects = <Effect>[];
    for (Effect effect in me.effects) {
      effect.duration -= 1;
      if (effect.duration > 0) {
        tmpEffects.add(effect);
      }
      me.getHp(effect.hp, effect.by, me);
    }
    me.effects = tmpEffects;
    me.blowAvailable += me.job == "도적"
        ? 2
        : me.job == "마법사" || me.job == "사제"
            ? 0
            : 1;
    me.turnOn();
  }

  static double baseGetDamage(
      Character target, double stat, int action, Character me) {
    double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
    return -1 * me.weapon.atBonus * stat * action / defend / 2;
  }

  static SkillResult baseBlow(
      List<Character> targets, double damage, Character me) {
    targets[0].getHp(damage, targets[0], me);
    SkillResult result = SkillResult(by: me, to: targets[0]);
    result.hp = damage;
    return result;
  }

  static void baseGetHp(double hp, Character by, Character me) {
    return me.defaultGetHp(hp, by);
  }

  static void baseBattleStart(Character me) {
    me.refreshStatus();
  }
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
