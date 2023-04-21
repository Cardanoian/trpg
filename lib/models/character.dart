import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';

import 'effect.dart';
import 'item.dart';
import 'skill.dart';

class Character with ChangeNotifier {
  String name, srcName, job;
  double bStr,
      bDex,
      bInt,
      lvS,
      lvD,
      lvI,
      src,
      maxSrc,
      level = 1,
      exp = 0,
      diceAdv = 0,
      atBonus = 0,
      dfBonus = 0,
      combat = 0,
      gold = 0;
  SkillBook skillBook;
  Type weaponType;
  Type armorType;
  double cStr = 0, cDex = 0, cInt = 0, maxHp = 0, hp = 0;
  List<Effect> effects = [];
  List<Item> inventory = [];
  List<String> itemStats = [];
  Item weapon, armor, accessory;
  bool hero, isAlive;

  Character(
      {this.job = "",
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
      required this.itemStats,
      required this.weapon,
      required this.armor,
      required this.accessory,
      required this.skillBook}) {
    renewStat();
    hp = maxHp;
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

  void renewStat() {
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
    for (Effect effect in effects) {
      tmpEffect.strength += effect.strength;
      tmpEffect.dex += effect.dex;
      tmpEffect.intel += effect.intel;
      tmpEffect.atBonus += effect.atBonus;
      tmpEffect.combat += effect.combat;
      tmpEffect.dfBonus += effect.dfBonus;
      tmpEffect.diceAdv += effect.diceAdv;
    }
    cStr = bStr +
        weapon.strength +
        armor.strength +
        accessory.strength +
        tmpEffect.strength;
    cDex = bDex + weapon.dex + armor.dex + accessory.dex + tmpEffect.dex;
    cInt =
        bInt + weapon.intel + armor.intel + accessory.intel + tmpEffect.intel;
    atBonus =
        weapon.atBonus + armor.atBonus + accessory.atBonus + tmpEffect.atBonus;
    combat = weapon.combat + armor.combat + accessory.combat + tmpEffect.combat;
    dfBonus =
        weapon.dfBonus + armor.dfBonus + accessory.dfBonus + tmpEffect.dfBonus;
    diceAdv =
        weapon.diceAdv + armor.diceAdv + accessory.diceAdv + tmpEffect.diceAdv;
    maxHp = (level + bStr) * 5;
    notifyListeners();
  }

  void getExp(int exp) {
    double maxExp = pow(17, level).toDouble();
    this.exp += exp;
    while (this.exp >= maxExp) {
      this.exp -= maxExp.toInt();
      levelUp();
      maxExp = pow(17, level).toDouble();
    }
    notifyListeners();
  }

  void levelUp() {
    level++;
    bStr += lvS;
    bDex += lvD;
    bInt += lvI;
    renewStat();
  }

  void turnStart() {
    for (int i = 0; i < effects.length; i++) {
      effects[i].duration -= 1;
      if (effects[i].duration < 0) {
        effects.removeAt(i);
        continue;
      }
      getHp(effects[i].hp);
    }
    renewStat();
  }

  void getHp(double hp) {
    if (hp == 0) {
      return;
    }
    this.hp += hp;
    if (this.hp >= maxHp) {
      this.hp = maxHp;
    } else if (hp <= 0) {
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
    for (Item myItem in inventory) {
      if (item.name == myItem.name) {
        myItem.quantity += 1;
        notifyListeners();
        return;
      }
    }
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

  double getDamage(Character target, double stat, int action) {
    double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
    return -1 * weapon.atBonus * stat * action / defend / 2;
  }

  void battleStart() {
    // Not implemented yet
  }

  bool skill1(List<Character> targets) => false;

  bool skill2(List<Character> targets) => false;

  bool skill3(List<Character> targets) => false;

  bool skill4(List<Character> targets) => false;

  bool blow(List<Character> targets) => false;

  void showTestInfo() {}

  void test(List<Character> targets) {
    double turns = 0;
    bool playing = true;
    double totalDamage = 0;
    while (turns <= 10 && playing) {
      double thisTurn = 0;
      while (thisTurn <= 1) {
        targets[0].getHp(500);
        showTestInfo();
        print(
            "자원: $src / $maxSrc\n누적 데미지: $totalDamage\n사용 턴: ${turns % 1} / $turns");
        print(skillBook);
        String? ipt = stdin.readLineSync();
        if (ipt == "q") {
          playing = false;
          break;
        }
        if (ipt == "p") {
          break;
        }
        if (ipt == "a") {
          blow(targets);
          thisTurn += skillBook.skill5.turn;
          turns += skillBook.skill5.turn;
        }
        if (ipt == "1") {
          skill1(targets);
          thisTurn += skillBook.skill1.turn;
          turns += skillBook.skill1.turn;
        } else if (ipt == "2") {
          skill2(targets);
          thisTurn += skillBook.skill2.turn;
          turns += skillBook.skill2.turn;
        } else if (ipt == "3") {
          skill3(targets);
          thisTurn += skillBook.skill3.turn;
          turns += skillBook.skill3.turn;
        } else if (ipt == "4") {
          skill4(targets);
          thisTurn += skillBook.skill4.turn;
          turns += skillBook.skill4.turn;
        }
        totalDamage += (targets[0].maxHp - targets[0].hp);
      }
      turnStart();
    }
    print("Total Damage: $totalDamage");
    print("Used Turns: $turns");
    print("Damage per Turn: ${totalDamage / turns}");
  }
}
