import 'dart:math';

import 'package:hive/hive.dart';

import 'character.dart';

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
  money,
}

@HiveType(typeId: 203)
enum Grade {
  @HiveField(0)
  normal,
  @HiveField(1)
  uncommon,
  @HiveField(2)
  heroic,
  @HiveField(3)
  legendary,
  @HiveField(4)
  epic,
}

@HiveType(typeId: 103)
class Item {
  @HiveField(0)
  String name;
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
  Grade grade;
  @HiveField(13)
  bool isChecked = false;
  @HiveField(14)
  List<String> ability;

  Item({
    this.name = "",
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
    this.grade = Grade.normal,
    required this.ability,
  });

  @HiveField(15)
  void randomGrade({required int itemRating, required Character character}) {
    double gradeNum = Random().nextInt(101) * log(itemRating) / log(100);
    Grade grade = Grade.normal;
    int abilityBonus = 0;
    if (gradeNum >= 95) {
      grade = Grade.epic;
      abilityBonus = 6;
      cost = 1000;
    } else if (gradeNum >= 85) {
      grade = Grade.legendary;
      abilityBonus = 4;
      cost = 500;
    } else if (gradeNum >= 70) {
      grade = Grade.heroic;
      abilityBonus = 2;
      cost = 200;
    } else if (gradeNum >= 30) {
      grade = Grade.uncommon;
      abilityBonus = 1;
      cost = 100;
    }
    this.grade = grade;

    while (abilityBonus > 0) {
      String choice = ability[Random().nextInt(ability.length)];
      if (!character.itemStats.contains(choice)) {
        continue;
      }
      if (choice == "atBonus") {
        atBonus += 0.5;
      } else if (choice == "combat") {
        combat += 1;
      } else if (choice == "dfBonus") {
        dfBonus += 0.5;
      } else if (choice == "strength") {
        strength += 1;
      } else if (choice == "dex") {
        dex += 1;
      } else if (choice == "intel") {
        intel += 1;
      } else if (choice == "diceAdv") {
        diceAdv += 0.5;
      }
      abilityBonus -= 1;
    }
  }
}

Item baseShield = Item(
  name: "방패",
  cost: 50,
  quantity: 1,
  itemType: ItemType.weapon,
  type: Type.shield,
  dfBonus: 1,
  atBonus: 1,
  ability: ["combat", "dfBonus", "strength", "intel", "diceAdv"],
);

Item baseDagger = Item(
  name: "단검",
  cost: 50,
  quantity: 1,
  itemType: ItemType.weapon,
  type: Type.dagger,
  atBonus: 2,
  ability: ["atBonus", "combat", "strength", "dex", "diceAdv"],
);

Item baseBow = Item(
  name: "활",
  cost: 50,
  quantity: 1,
  itemType: ItemType.weapon,
  type: Type.bow,
  atBonus: 2,
  ability: ["atBonus", "combat", "strength", "dex", "diceAdv"],
);

Item baseStaff = Item(
  name: "지팡이",
  cost: 50,
  quantity: 1,
  intel: 2,
  itemType: ItemType.weapon,
  type: Type.staff,
  ability: ["atBonus", "combat", "strength", "intel", "diceAdv"],
);

Item baseCloth = Item(
  name: "천",
  cost: 50,
  quantity: 1,
  itemType: ItemType.armor,
  type: Type.cloth,
  dfBonus: 1,
  intel: 1,
  ability: ["combat", "dfBonus", "strength", "intel", "diceAdv"],
);

Item baseLeather = Item(
  name: "가죽",
  cost: 50,
  quantity: 1,
  itemType: ItemType.armor,
  type: Type.leather,
  dfBonus: 2,
  dex: 1,
  ability: ["combat", "dfBonus", "strength", "dex", "diceAdv"],
);

Item basePlate = Item(
  name: "갑옷",
  cost: 50,
  quantity: 1,
  itemType: ItemType.armor,
  type: Type.plate,
  dfBonus: 3,
  strength: 1,
  ability: ["combat", "dfBonus", "strength", "intel", "diceAdv"],
);

Item baseAccessory = Item(
  name: "장신구",
  cost: 50,
  quantity: 1,
  diceAdv: 0.5,
  itemType: ItemType.accessory,
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
