import 'dart:math';
import 'character.dart';

enum ItemType {
  weapon,
  armor,
  accessory,
}

enum Type {
  // Weapon
  shield,
  dagger,
  bow,
  staff,
  // Armor
  plate,
  leather,
  cloth,
  // Accessory
  // Etc
  money,
}

enum Grade {
  normal,
  uncommon,
  heroic,
  legendary,
  epic,
}

class Item {
  String name;
  int cost, quantity;
  ItemType itemType;
  Type type;
  double atBonus, combat, dfBonus, strength, dex, intel, diceAdv;
  Grade grade;
  bool isChecked = false;
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
