import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'characters/character.dart';

part 'item.g.dart';

@HiveType(typeId: 201)
enum ItemType {
  @HiveField(0)
  weapon,
  @HiveField(1)
  armor,
  @HiveField(2)
  accessory,
}

@HiveType(typeId: 202, adapterName: "DetailTypeAdapter")
enum Type {
  // Weapon
  @HiveField(0)
  shield,
  @HiveField(1)
  dagger,
  @HiveField(2)
  bow,
  @HiveField(3)
  staff,
  // Armor
  @HiveField(4)
  plate,
  @HiveField(5)
  leather,
  @HiveField(6)
  cloth,
  // Accessory
  // Etc
  @HiveField(7)
  accessory,
  @HiveField(8)
  money,
}

// @HiveType(typeId: 203)
// enum Grade {
//   @HiveField(0)
//   normal,
//   @HiveField(1)
//   uncommon,
//   @HiveField(2)
//   heroic,
//   @HiveField(3)
//   legendary,
//   @HiveField(4)
//   epic,
// }

@HiveType(typeId: 103)
class Item {
  // @HiveField(0)
  // String name;
  @HiveField(1)
  int cost;
  @HiveField(2)
  int quantity;
  @HiveField(3)
  ItemType itemType;
  @HiveField(4)
  Type type;
  @HiveField(5)
  double atBonus;
  @HiveField(6)
  double combat;
  @HiveField(7)
  double dfBonus;
  @HiveField(8)
  double strength;
  @HiveField(9)
  double dex;
  @HiveField(10)
  double intel;
  @HiveField(11)
  double diceAdv;
  @HiveField(12)
  int grade;
  @HiveField(13)
  bool isChecked = false;
  @HiveField(14)
  List<String> ability;

  Item({
    // this.name = "",
    this.cost = 0,
    this.quantity = 0,
    this.itemType = ItemType.weapon,
    this.atBonus = 0,
    this.combat = 0,
    this.dfBonus = 0,
    this.strength = 0,
    this.dex = 0,
    this.intel = 0,
    this.diceAdv = 0,
    this.type = Type.bow,
    this.grade = 0,
    required this.ability,
  });

  @override
  String toString() {
    return "+$grade ${typeToString(type)} 가치: $cost\n전투력: $combat  주사위 보조: $diceAdv\n무기 공격력: $atBonus  방어력: $dfBonus\n힘: $strength  민첩: $dex  지능: $intel";
  }
}

Item? getRandomGradeItem(
    {required double itemRating, required Character character}) {
  Item item = getRandomItem(character);
  double grade =
      (Random().nextInt(character.level + 1) + 1) * log(itemRating) / log(50);
  if (grade < 1) {
    return null;
  }
  item.grade = grade.floor();
  item.cost = (50 * pow(1.5, grade)).floor();

  while (grade > 0) {
    String choice = item.ability[Random().nextInt(item.ability.length)];
    if (!character.itemStats.contains(choice)) {
      continue;
    }
    if (choice == "atBonus") {
      item.atBonus += 0.7;
    } else if (choice == "combat") {
      item.combat += 1.5;
    } else if (choice == "dfBonus") {
      item.dfBonus += 0.7;
    } else if (choice == "strength") {
      item.strength += 1;
    } else if (choice == "dex") {
      item.dex += 1;
    } else if (choice == "intel") {
      item.intel += 1;
    } else if (choice == "diceAdv") {
      item.diceAdv += 0.5;
    }
    grade -= 1;
  }
  return item;
}

Item getRandomItem(Character character) {
  int randomNum = Random().nextInt(3);
  late Item item;
  if (randomNum == 0) {
    if (character.job == "전사" || character.job == "성기사") {
      item = baseShield;
    } else if (character.job == "도적") {
      item = baseDagger;
    } else if (character.job == "궁수") {
      item = baseBow;
    } else {
      item = baseStaff;
    }
  } else if (randomNum == 1) {
    if (character.job == "전사" || character.job == "성기사") {
      item = basePlate;
    } else if (character.job == "도적" || character.job == "궁수") {
      item = baseLeather;
    } else {
      item = baseCloth;
    }
  } else {
    item = baseAccessory;
  }
  return item;
}

Color itemColor(Item item) {
  return item.grade <= 1
      ? Colors.white.withOpacity(0.5)
      : item.grade <= 4
          ? Colors.grey.withOpacity(0.5)
          : item.grade <= 6
              ? Colors.blue.withOpacity(0.5)
              : item.grade <= 8
                  ? Colors.amberAccent.withOpacity(0.5)
                  : Colors.redAccent.withOpacity(0.5);
}

String typeToString(Type type) {
  late String result;
  switch (type) {
    case Type.cloth:
      result = "로브";
      break;
    case Type.leather:
      result = "가죽 갑옷";
      break;
    case Type.plate:
      result = "판금 갑옷";
      break;
    case Type.staff:
      result = "지팡이";
      break;
    case Type.dagger:
      result = "단검";
      break;
    case Type.bow:
      result = "활";
      break;
    case Type.shield:
      result = "방패";
      break;
    case Type.accessory:
      result = "악세사리";
      break;
    default:
      result = "골드";
  }
  return result;
}

Item baseShield = Item(
  // name: "방패",
  cost: 50,
  quantity: 1,
  itemType: ItemType.weapon,
  type: Type.shield,
  dfBonus: 1,
  atBonus: 1,
  ability: ["combat", "dfBonus", "strength", "intel", "diceAdv"],
);

Item baseDagger = Item(
  // name: "단검",
  cost: 50,
  quantity: 1,
  itemType: ItemType.weapon,
  type: Type.dagger,
  atBonus: 2,
  ability: ["atBonus", "combat", "strength", "dex", "diceAdv"],
);

Item baseBow = Item(
  // name: "활",
  cost: 50,
  quantity: 1,
  itemType: ItemType.weapon,
  type: Type.bow,
  atBonus: 2,
  ability: ["atBonus", "combat", "strength", "dex", "diceAdv"],
);

Item baseStaff = Item(
  // name: "지팡이",
  cost: 50,
  quantity: 1,
  intel: 2,
  itemType: ItemType.weapon,
  type: Type.staff,
  ability: ["atBonus", "combat", "strength", "intel", "diceAdv"],
);

Item baseCloth = Item(
  // name: "로브",
  cost: 50,
  quantity: 1,
  itemType: ItemType.armor,
  type: Type.cloth,
  dfBonus: 1,
  intel: 1,
  ability: ["combat", "dfBonus", "strength", "intel", "diceAdv"],
);

Item baseLeather = Item(
  // name: "가죽",
  cost: 50,
  quantity: 1,
  itemType: ItemType.armor,
  type: Type.leather,
  dfBonus: 2,
  dex: 1,
  ability: ["combat", "dfBonus", "strength", "dex", "diceAdv"],
);

Item basePlate = Item(
  // name: "갑옷",
  cost: 50,
  quantity: 1,
  itemType: ItemType.armor,
  type: Type.plate,
  dfBonus: 3,
  strength: 1,
  ability: ["combat", "dfBonus", "strength", "intel", "diceAdv"],
);

Item baseAccessory = Item(
  // name: "장신구",
  cost: 0,
  quantity: 1,
  itemType: ItemType.accessory,
  type: Type.accessory,
  ability: [
    "atBonus",
    "combat",
    "dfBonus",
    "strength",
    "dex",
    "intel",
    "diceAdv"
  ],
);
