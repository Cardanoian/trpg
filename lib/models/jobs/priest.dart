import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

class Priest extends Character {
  Priest({
    String name = "사제",
    int strength = 4,
    int dex = 3,
    int intel = 11,
    int level = 1,
    int exp = 0,
    int diceAdv = 0,
    weapon,
    armor,
    acce,
  }) : super(
          name: name,
          job: "사제",
          lvS: 2,
          lvD: 0,
          lvI: 2,
          src: 65,
          maxSrc: 65,
          bStr: 0,
          bDex: 0,
          bInt: 0,
          level: 1,
          exp: 0,
          diceAdv: 0,
          weaponType: Type.staff,
          armorType: Type.cloth,
          weapon: baseDagger,
          armor: baseLeather,
          accessory: baseAccessory,
          skillBook: SkillBook(
            Skill(name: "소생", turn: 0.5),
            Skill(name: "회개", turn: 1),
            Skill(name: "치유", turn: 1),
            Skill(name: "치유의 마법진", turn: 1),
            Skill(name: "평타", turn: 1),
          ),
          itemStats: [
            "combat",
            "dfBonus",
            "strength",
            "intel",
            "diceAdv",
          ],
        );

  @override
  void levelUp() {
    super.levelUp();
    src = maxSrc = level * 10 + cInt * 5;
  }

  @override
  void battleStart() {
    src = maxSrc;
  }

  bool useSrc(int src) {
    if (this.src + src < 0) {
      return false;
    }
    this.src += src;
    if (this.src >= maxSrc) {
      this.src = maxSrc;
    }
    return true;
  }

  double getSpellPower() {
    return (cInt + combat) * actionSuccess() / 2;
  }

  @override
  bool skill1(List<Character> targets) {
    if (!useSrc(-10)) {
      return false;
    }
    double spellPower = getSpellPower() * 0.3;
    int duration = 4;
    if (level >= 4) {
      targets[0].getHp(spellPower);
      duration = 5;
    }
    targets[0].getEffect(Buff(name: "소생", duration: duration, hp: spellPower));
    return true;
  }

  @override
  bool skill2(List<Character> targets) {
    int src = level < 4 ? -3 : 0;
    if (!useSrc(src)) {
      return false;
    }
    double spellPower = getSpellPower();
    targets[0].getHp(-2 * spellPower);
    getHp(spellPower);
    return true;
  }

  @override
  bool skill3(List<Character> targets) {
    if (targets[0] == this || level < 2) {
      return false;
    }
    if (level >= 5) {
      if (hp <= 10) {
        return false;
      }
      getHp(-10);
      targets[0].getEffect(Buff(name: "보호", duration: 3, dfBonus: cStr / 3));
    }
    if (level < 5) {
      if (!useSrc(-10)) {
        return false;
      }
    }
    targets[0].getHp(getSpellPower());
    return true;
  }

  @override
  bool skill4(List<Character> targets) {
    if (!useSrc(-40) || level < 3) {
      return false;
    }
    double spellPower = getSpellPower() * 0.5;
    for (dynamic target in targets) {
      target.getHp(spellPower);
    }
    return true;
  }
}
