import '../character.dart';
import '../effect.dart';
import '../item.dart';
import '../skill.dart';

Character paladin(String name) => Character(
      name: name,
      job: "성기사",
      levelUp: baseLevelUp,
      battleStart: paladinBattleStart,
      getDamage: baseGetDamage,
      getHp: baseGetHp,
      turnStart: paladinTurnStart,
      weapon: baseShield,
      armor: basePlate,
      accessory: baseAccessory,
      weaponType: Type.shield,
      armorType: Type.plate,
      itemStats: [
        "atBonus",
        "combat",
        "dfBonus",
        "strength",
        "intel",
        "diceAdv"
      ],
      skillBook: [
        Skill(name: "심판", turn: 0.5, func: judgement),
        Skill(name: "정의의 방패", turn: 0.5, func: shieldOfRighteous),
        Skill(name: "응징의 방패", turn: 0.5, func: avengersShield),
        Skill(name: "빛의 가호", turn: 0.5, func: flashOfLight),
        Skill(name: "평타", turn: 0.5, func: baseBlow),
      ],
    );

void paladinBattleStart(Character me) {
  me.skillCools[0] = 0;
  me.skillCools[2] = 0;
  me.skillCools[3] = 0;
  me.src = 0;
}

void paladinTurnStart(Character me) {
  baseTurnStart(me);
  for (int i = 0; i < me.skillCools.length; i++) {
    if (me.skillCools[i] > 0) me.skillCools[i]--;
  }
}

bool blow(List<Character> targets, Character me) {
  if (me.blowAvailable == false) {
    return false;
  }
  int action = me.actionSuccess(me);
  targets[0].getHp(
      me.getDamage(
              targets[0], me.cStr / 2.0 + me.cInt + me.combat, action, me) *
          -1,
      me);
  me.blowAvailable = false;
  return true;
}

// Skills

bool judgement(List<Character> targets, Character me) {
  if (me.skillCools[0] != 0) {
    return false;
  }
  me.skillCools[0] = 1;
  int action = me.actionSuccess(me);
  if (action == 4) {
    me.skillCools[3] -= me.skillCools[3] != 0 ? 1 : 0;
  }
  double damage =
      me.getDamage(targets[0], me.cStr / 2.0 + me.cInt + me.combat, action, me);
  targets[0].getHp(damage, targets[0]);
  me.getHp(damage * 0.5, me);
  me.useSrc(action == 4 ? 2 : 1, me);
  return true;
}

bool shieldOfRighteous(List<Character> targets, Character me) {
  if (me.src < 3) {
    return false;
  }
  int action = me.actionSuccess(me);
  me.useSrc(-3, me);
  if (action == 4) {
    me.useSrc(1, me);
  }
  me.getEffect(
      Effect(
        name: "신성한 방패",
        duration: 2,
        dfBonus: me.dfBonus,
      ),
      me);
  for (Character target in targets) {
    double damage =
        me.getDamage(target, me.cStr / 2 + me.cInt + me.combat, action, me) *
            0.5;
    target.getHp(damage, target);
  }
  return true;
}

bool avengersShield(List<Character> targets, Character me) {
  if (me.skillCools[2] != 0) {
    return false;
  }
  me.skillCools[2] = 2;
  int action = me.actionSuccess(me);
  if (action == 4) {
    me.skillCools[3] -= me.skillCools[3] != 0 ? 1 : 0;
  }
  me.useSrc(action == 4 ? 3 : 2, me);
  for (var target in targets) {
    double damage =
        me.getDamage(target, me.cStr / 2 + me.cInt + me.combat, action, me);
    target.getHp(damage, target);
  }
  return true;
}

bool flashOfLight(List<Character> targets, Character me) {
  if (me.skillCools[3] != 0) {
    return false;
  }
  double damage = me.getDamage(
    targets[0],
    me.cStr / 2.0 + me.cInt + me.combat,
    me.actionSuccess(me),
    me,
  );
  me.getHp(damage, me);
  me.useSrc(2, me);
  me.skillCools[2] = 0;
  me.skillCools[0] = 0;
  me.skillCools[3] = 5;
  return true;
}

// class Paladin extends Character {
//   int judCool = 0;
//   int avgCool = 0;
//   int blessCool = 0;
//   bool blowAvailable = true;
//
//   Paladin({
//     String name = "성기사",
//     double strength = 9,
//     double dex = 3,
//     double intel = 6,
//     int level = 1,
//     int exp = 0,
//     double diceAdv = 0,
//   }) : super(
//           name: name,
//           job: "성기사",
//           srcName: "신성한 힘",
//           bStr: strength,
//           bDex: dex,
//           bInt: intel,
//           lvS: 2,
//           lvD: 0,
//           lvI: 2,
//           src: 0,
//           maxSrc: 5,
//           level: 1,
//           exp: 0,
//           diceAdv: diceAdv,
//           weaponType: Type.shield,
//           armorType: Type.plate,
//           weapon: baseShield,
//           armor: basePlate,
//           accessory: baseAccessory,
//           skillBook: [
//             Skill(name: "심판", turn: 0.5),
//             Skill(name: "정의의 방패", turn: 0.5),
//             Skill(name: "응징의 방패", turn: 0.5),
//             Skill(name: "빛의 가호", turn: 0.5),
//             Skill(name: "평타", turn: 0.5),
//           ],
//           itemStats: [
//             "atBonus",
//             "combat",
//             "dfBonus",
//             "strength",
//             "intel",
//             "diceAdv"
//           ],
//         );
//
//   @override
//   void battleStart() {
//     judCool = 0;
//     avgCool = 0;
//     blessCool = 0;
//     src = 0;
//   }
//
//   @override
//   void turnStart() {
//     super.turnStart();
//     judCool -= judCool > 0 ? 1 : 0;
//     avgCool -= avgCool > 0 ? 1 : 0;
//     blessCool -= blessCool > 0 ? 1 : 0;
//   }
//
//   void getSrc(int point) {
//     src += point;
//     if (src > maxSrc) {
//       src = maxSrc;
//     }
//     if (src < 0) {
//       src = 0;
//     }
//   }
//
//   @override
//   bool blow(List<Character> targets) {
//     if (blowAvailable == false) {
//       return false;
//     }
//     targets[0].getHp(
//         getDamage(targets[0], cStr / 2.0 + cInt + combat, actionSuccess()) *
//             -1);
//     blowAvailable = false;
//     return true;
//   }
//
// // Skills
//
//   @override
//   bool skill1(List<Character> targets) {
//     if (judCool != 0) {
//       return false;
//     }
//     judCool = 1;
//     int action = actionSuccess();
//     if (action == 4) {
//       blessCool -= blessCool != 0 ? 1 : 0;
//     }
//     double damage = getDamage(targets[0], cStr / 2.0 + cInt + combat, action);
//     targets[0].getHp(damage);
//     getHp(damage * 0.5);
//     getSrc(action == 4 ? 2 : 1);
//     return true;
//   }
//
//   @override
//   bool skill2(List<Character> targets) {
//     if (src < 3) {
//       return false;
//     }
//     int action = actionSuccess();
//     getSrc(-3);
//     if (action == 4) {
//       getSrc(1);
//     }
//     getEffect(Effect(
//       name: "신성한 방패",
//       duration: 2,
//       dfBonus: dfBonus,
//     ));
//     for (Character target in targets) {
//       double damage = getDamage(target, cStr / 2 + cInt + combat, action) * 0.5;
//       target.getHp(damage);
//     }
//     return true;
//   }
//
//   @override
//   bool skill3(List<Character> targets) {
//     if (avgCool != 0) {
//       return false;
//     }
//     avgCool = 2;
//     int action = actionSuccess();
//     if (action == 4) {
//       blessCool -= blessCool != 0 ? 1 : 0;
//     }
//     getSrc(action == 4 ? 3 : 2);
//     for (var target in targets) {
//       double damage = getDamage(target, cStr / 2 + cInt + combat, action);
//       target.getHp(damage);
//     }
//     return true;
//   }
//
//   @override
//   bool skill4(List<Character> targets) {
//     if (blessCool != 0) {
//       return false;
//     }
//     double damage = getDamage(
//       targets[0],
//       cStr / 2.0 + cInt + combat,
//       actionSuccess(),
//     );
//     getHp(damage);
//     getSrc(2);
//     avgCool = 0;
//     judCool = 0;
//     blessCool = 5;
//     return true;
//   }
// }
