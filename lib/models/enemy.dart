import 'package:trpg/models/item.dart';

import 'character.dart';
import 'skill.dart';

class Enemy extends Character {
  Character? lastTarget;
  bool lastShot = false;
  bool blowAvailable = true;

  Enemy({
    String name = "고블린",
    int strength = 3,
    int dex = 11,
    int intel = 4,
    int level = 1,
    int exp = 0,
    int diceAdv = 0,
  }) : super(
          name: name,
          lvS: 1,
          lvD: 2,
          lvI: 1,
          src: 100,
          maxSrc: 100,
          bStr: 0,
          bDex: 0,
          bInt: 0,
          level: 1,
          exp: 0,
          diceAdv: 0,
          weaponType: Type.dagger,
          armorType: Type.leather,
          weapon: baseDagger,
          armor: baseLeather,
          accessory: baseAccessory,
          skillBook: defaultSkillBook,
          itemStats: [],
        );

  @override
  void battleStart() {
    lastTarget = null;
    src = maxSrc;
  }

  @override
  double getDamage(Character target, double stat, int action) {
    double defend = target.dfBonus <= 0 ? 1 / 2 : target.dfBonus;
    double damage = weapon.atBonus * stat * action / defend / 2;
    if (lastTarget != null) {
      if (lastTarget == target) {
        if (level >= 2) {
          damage *= 2;
        }
        if (level >= 4) {
          useSrc(-10);
        }
      }
    }
    lastTarget = target;
    return damage;
  }

  bool useSrc(int src) {
    if (src == 0 || src > this.src) {
      return false;
    }
    this.src -= src;
    if (this.src <= 0) {
      this.src = 0;
    }
    if (this.src >= maxSrc) {
      this.src = maxSrc;
    }
    return true;
  }

  @override
  void turnStart() {
    super.turnStart();
    lastShot = false;
    int src = level >= 4 ? -20 : -10;
    useSrc(src);
    blowAvailable = true;
  }

  @override
  bool blow(List<Character> targets) {
    if (blowAvailable == false) {
      return false;
    }
    targets[0].getHp(getDamage(targets[0], cDex + combat, actionSuccess()) * 2);
    blowAvailable = false;
    return true;
  }

  @override
  bool skill1(List<Character> targets) {
    if (!useSrc(40)) {
      return false;
    }
    targets[0].getHp(getDamage(targets[0], cDex + combat, actionSuccess()) * 3);
    return true;
  }

  @override
  bool skill2(List<Character> targets) {
    if (!useSrc(40) || level < 3) {
      return false;
    }
    for (var target in targets) {
      target.getHp(getDamage(target, cDex + combat, actionSuccess()) * 1);
    }
    return true;
  }

  @override
  bool skill3(List<Character> targets) {
    if (lastShot || targets[0].hp / targets[0].maxHp >= 0.3) {
      return false;
    }
    useSrc(-20);
    targets[0].getHp(getDamage(targets[0], cDex + combat, actionSuccess()) * 3);
    lastShot = true;
    return true;
  }
}
