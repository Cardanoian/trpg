import 'dart:math';

import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

class Rogue extends Character {
  int link = 0;

  Rogue({
    String name = "도적",
    int strength = 6,
    int dex = 9,
    int intel = 3,
    int level = 1,
    int exp = 0,
    double diceAdv = 0,
    weapon,
    armor,
    acce,
  }) : super(
          name: name,
          job: "도적",
          srcName: "기력",
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
          skillBook: SkillBook(
            Skill(name: "비열한 일격", turn: 0.5),
            Skill(name: "절개", turn: 0.5),
            Skill(name: "칼날부채", turn: 0.5),
            Skill(name: "없음", turn: 0.5),
            Skill(name: "평타", turn: 0.5),
          ),
          itemStats: [
            "atBonus",
            "combat",
            "dfBonus",
            "strength",
            "dex",
            "diceAdv",
          ],
        );

  @override
  void showTestInfo() {
    print("\n버블: $link / 4");
  }

  @override
  void levelUp() {
    super.levelUp();
    if (level >= 5) {
      src = maxSrc = 120;
      diceAdv += 1;
    }
  }

  @override
  void battleStart() {
    src = maxSrc;
    link = 0;
  }

  @override
  void turnStart() {
    super.turnStart();
    useSrc(10);
  }

  bool useSrc(int src) {
    if (src == 0 || src > this.src) {
      return false;
    }
    this.src += src;
    if (this.src <= 0) {
      this.src = 0;
    }
    if (this.src >= maxSrc) {
      this.src = maxSrc;
    }
    return true;
  }

  @override
  bool blow(List<Character> targets) {
    int action = actionSuccess();
    targets[0].getHp(getDamage(targets[0], cDex + combat, action) * -1);
    useSrc(action == 4 && level >= 5 ? 20 : 10);
    return true;
  }

  @override
  bool skill1(List<Character> targets) {
    if (!useSrc(40)) {
      return false;
    }
    int action = actionSuccess();
    double damage = getDamage(targets[0], cDex + combat, action);
    targets[0].getHp(damage);
    targets[0].getEffect(Debuff(name: "비열한 일격", duration: 2, dfBonus: -1));
    link += action < 3 ? 1 : 2;
    if (link > 4) {
      link = 4;
    }
    if (action == 4) {
      useSrc(-20);
    }
    return true;
  }

  @override
  bool skill2(List<Character> targets) {
    if (link == 0) {
      return false;
    }
    int action = actionSuccess();
    double damage =
        getDamage(targets[0], cDex + combat, action) * pow(1.7, link);
    targets[0].getHp(damage);
    link = action < 4 ? 0 : link ~/ 2;
    return true;
  }

  @override
  bool skill3(List<Character> targets) {
    if (link == 0) {
      return false;
    }
    int action = actionSuccess();
    for (Character target in targets) {
      double damage = getDamage(target, cDex + combat, action);
      target.getHp(damage * pow(1.7, link) * 0.5);
    }
    link = action < 4 ? 0 : link ~/ 2;
    return true;
  }
}