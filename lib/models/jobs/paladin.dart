import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

class Paladin extends Character {
  int judCool = 0;
  int avgCool = 0;
  int blessCool = 0;
  bool blowAvailable = true;

  Paladin({
    String name = "성기사",
    int strength = 9,
    int dex = 3,
    int intel = 6,
    int level = 1,
    int exp = 0,
    int diceAdv = 0,
    weapon,
    armor,
    acce,
  }) : super(
          name: name,
          job: "성기사",
          srcName: "신성한 힘",
          bStr: 0,
          bDex: 0,
          bInt: 0,
          src: 0,
          maxSrc: 5,
          level: 1,
          exp: 0,
          diceAdv: 0,
          weaponType: Type.shield,
          armorType: Type.plate,
          weapon: baseShield,
          armor: basePlate,
          accessory: baseAccessory,
          skillBook: SkillBook(
            Skill(name: "심판", turn: 0.5),
            Skill(name: "정의의 방패", turn: 0.5),
            Skill(name: "응징의 방패", turn: 0.5),
            Skill(name: "빛의 가호", turn: 0.5),
            Skill(name: "평타", turn: 0.5),
          ),
          itemStats: [
            "atBonus",
            "combat",
            "dfBonus",
            "strength",
            "intel",
            "diceAdv"
          ],
        );

  @override
  void battleStart() {
    judCool = 0;
    avgCool = 0;
    blessCool = 0;
    src = 0;
  }

  @override
  void turnStart() {
    super.turnStart();
    judCool -= judCool > 0 ? 1 : 0;
    avgCool -= avgCool > 0 ? 1 : 0;
    blessCool -= blessCool > 0 ? 1 : 0;
  }

  void getSrc(int point) {
    src += point;
    if (src > maxSrc) {
      src = maxSrc;
    }
    if (src < 0) {
      src = 0;
    }
  }

  @override
  bool blow(List<Character> targets) {
    if (blowAvailable == false) {
      return false;
    }
    targets[0].getHp(
        getDamage(targets[0], cStr / 2.0 + cInt + combat, actionSuccess()) *
            -1);
    blowAvailable = false;
    return true;
  }

// Skills

  @override
  bool skill1(List<Character> targets) {
    if (judCool != 0) {
      return false;
    }
    judCool = 1;
    int action = actionSuccess();
    if (action == 4 && level >= 5) {
      blessCool -= blessCool != 0 ? 1 : 0;
    }
    double damage = getDamage(targets[0], cStr / 2.0 + cInt + combat, action);
    targets[0].getHp(damage);
    getHp(damage * 0.5);
    getSrc(level >= 5 && action == 4 ? 2 : 1);
    return true;
  }

  @override
  bool skill2(List<Character> targets) {
    if (src < 3 || level < 2) {
      return false;
    }
    int action = actionSuccess();
    getSrc(-3);
    if (action == 4) {
      getSrc(1);
    }
    getEffect(Buff(name: "신성한 방패", duration: 2, dfBonus: dfBonus));
    for (Character target in targets) {
      double damage = getDamage(target, cStr / 2 + cInt + combat, action) * 0.5;
      target.getHp(damage);
    }
    return true;
  }

  @override
  bool skill3(List<Character> targets) {
    if (avgCool != 0 || level < 3) {
      return false;
    }
    avgCool = 2;
    int action = actionSuccess();
    if (action == 4 && level >= 5) {
      blessCool -= blessCool != 0 ? 1 : 0;
    }
    getSrc(level >= 5 && action == 4 ? 3 : 2);
    for (var target in targets) {
      double damage = getDamage(target, cStr / 2 + cInt + combat, action);
      target.getHp(damage);
    }
    return true;
  }

  @override
  bool skill4(List<Character> targets) {
    if (blessCool != 0 || level < 5) {
      return false;
    }
    getSrc(2);
    avgCool = 0;
    judCool = 0;
    blessCool = 5;
    return true;
  }
}
