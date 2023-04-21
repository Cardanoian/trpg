import '../character.dart';
import '../item.dart';
import '../skill.dart';

class Wizard extends Character {
  bool doubleDamage = false;
  String lastSource = "";

  Wizard({
    String name = "마법사",
    int strength = 3,
    int dex = 3,
    int intel = 12,
    int level = 1,
    int exp = 0,
    int diceAdv = 0,
    weapon,
    armor,
    acce,
  }) : super(
          name: name,
          job: "마법사",
          lvS: 1,
          lvD: 1,
          lvI: 2,
          src: 70,
          maxSrc: 70,
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
            Skill(name: "비전 탄막", turn: 1),
            Skill(name: "연쇄 번개", turn: 1),
            Skill(name: "화염 기둥", turn: 1),
            Skill(name: "비전 작렬", turn: 1),
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
    maxSrc = level * 10 + cInt * 5;
  }

  bool useSrc(int src) {
    if (src == 0 || this.src + src < 0) {
      return false;
    }
    this.src += src;
    if (this.src >= maxSrc) {
      this.src = maxSrc;
    }
    return true;
  }

  double getMagicDamage(Character target, String source) {
    double damage = -1 * (cInt + combat) * actionSuccess() / 2;
    if (doubleDamage) {
      damage *= 2;
      doubleDamage = false;
    }
    if (lastSource != "" && lastSource != source) {
      damage *= 2;
    }
    lastSource = source;
    return damage;
  }

  @override
  void battleStart() {
    doubleDamage = false;
    lastSource = "";
  }

  @override
  bool skill1(List<Character> targets) {
    useSrc(20);
    targets[0].getHp(getMagicDamage(targets[0], "비전"));
    return true;
  }

  @override
  bool skill2(List<Character> targets) {
    if (!useSrc(-40) || level < 2) {
      return false;
    }
    for (Character target in targets) {
      target.getHp(getMagicDamage(target, "전기"));
    }
    return true;
  }

  @override
  bool skill3(List<Character> targets) {
    if (!useSrc(-40) || level < 4) {
      return false;
    }
    for (Character target in targets) {
      target.getHp(getMagicDamage(target, "화염") * 0.5);
    }
    return true;
  }

  @override
  bool skill4(List<Character> targets) {
    if (!useSrc(-40) || level < 5) {
      return false;
    }
    targets[0].getHp(getMagicDamage(targets[0], "비전"));
    doubleDamage = true;
    return true;
  }
}
