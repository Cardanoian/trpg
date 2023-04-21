import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

class Warrior extends Character {
  int clapCool = 0;
  int chargingCool = 0;

  Warrior({
    String name = "전사",
    int strength = 11,
    int dex = 4,
    int intel = 3,
    int level = 1,
    int exp = 0,
    int diceAdv = 0,
    weapon,
    armor,
    acce,
  }) : super(
          name: name,
          job: "전사",
          srcName: "분노",
          bStr: 0,
          bDex: 0,
          bInt: 0,
          src: 0,
          maxSrc: 100,
          level: 1,
          exp: 0,
          diceAdv: 0,
          weaponType: Type.shield,
          armorType: Type.plate,
          weapon: baseShield,
          armor: basePlate,
          accessory: baseAccessory,
          skillBook: SkillBook(
            Skill(name: "천둥벼락", turn: 0.5),
            Skill(name: "돌진", turn: 0.5),
            Skill(name: "방패의 벽", turn: 0.5),
            Skill(name: "방패 밀쳐내기", turn: 0.5),
            Skill(name: "평타", turn: 0.5),
          ),
          itemStats: [
            "atBonus",
            "combat",
            "dfBonus",
            "strength",
            "diceAdv",
          ],
        );

  @override
  void battleStart() {
    src = 0;
    clapCool = 0;
    chargingCool = 0;
  }

  @override
  void turnStart() {
    super.turnStart();
    clapCool -= clapCool > 0 ? 1 : 0;
    chargingCool -= chargingCool > 0 ? 1 : 0;
  }

  bool getSrc(int src) {
    if (this.src + src < 0) {
      return false;
    }
    this.src += src;
    if (this.src > maxSrc) {
      this.src = maxSrc;
    }
    return true;
  }

  @override
  void getHp(double hp) {
    super.getHp(hp);
    if (hp < 0 && level >= 4) {
      getSrc(5);
    }
  }

  @override
  bool blow(List<Character> targets) {
    targets[0].getHp(getDamage(targets[0], cStr + combat, actionSuccess()));
    return true;
  }

  // Skills

  @override
  bool skill1(List<Character> targets) {
    if (clapCool > 0) {
      return false;
    }
    clapCool = 2;
    for (Character target in targets) {
      target.getHp(getDamage(target, cStr + combat, actionSuccess()) * -1);
      target.getEffect(
        Effect(
          name: "메스꺼움",
          duration: 1,
          atBonus: cStr * 0.5,
          by: name,
          buff: false,
        ),
      );
    }
    return true;
  }

  @override
  bool skill2(List<Character> targets) {
    if (chargingCool > 0 || level < 2) {
      return false;
    }
    getSrc(20);
    chargingCool = 3;
    return true;
  }

  @override
  bool skill3(List<Character> targets) {
    if (level < 3 || !getSrc(-20)) {
      return false;
    }
    getEffect(
      Effect(
        name: "방패의 벽",
        duration: 2,
        dfBonus: cStr / 8,
        diceAdv: 1,
      ),
    );
    return true;
  }

  @override
  bool skill4(List<Character> targets) {
    if (level < 5 || !getSrc(-20)) {
      return false;
    }
    targets[0].getHp(getDamage(targets[0], cStr + combat, actionSuccess()) * 2);
    getEffect(
      Effect(
        name: "강화된 방패",
        duration: 1,
        diceAdv: 1,
      ),
    );
    return true;
  }
}
