// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemAdapter extends TypeAdapter<Item> {
  @override
  final int typeId = 103;

  @override
  Item read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Item(
      name: fields[0] as String,
      cost: fields[1] as int,
      quantity: fields[2] as int,
      itemType: fields[3] as ItemType,
      atBonus: fields[5] as double,
      combat: fields[6] as double,
      dfBonus: fields[7] as double,
      strength: fields[8] as double,
      dex: fields[9] as double,
      intel: fields[10] as double,
      diceAdv: fields[11] as double,
      type: fields[4] as Type,
      grade: fields[12] as Grade,
      ability: (fields[14] as List).cast<String>(),
    )..isChecked = fields[13] as bool;
  }

  @override
  void write(BinaryWriter writer, Item obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.cost)
      ..writeByte(2)
      ..write(obj.quantity)
      ..writeByte(3)
      ..write(obj.itemType)
      ..writeByte(4)
      ..write(obj.type)
      ..writeByte(5)
      ..write(obj.atBonus)
      ..writeByte(6)
      ..write(obj.combat)
      ..writeByte(7)
      ..write(obj.dfBonus)
      ..writeByte(8)
      ..write(obj.strength)
      ..writeByte(9)
      ..write(obj.dex)
      ..writeByte(10)
      ..write(obj.intel)
      ..writeByte(11)
      ..write(obj.diceAdv)
      ..writeByte(12)
      ..write(obj.grade)
      ..writeByte(13)
      ..write(obj.isChecked)
      ..writeByte(14)
      ..write(obj.ability);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ItemTypeAdapter extends TypeAdapter<ItemType> {
  @override
  final int typeId = 201;

  @override
  ItemType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ItemType.weapon;
      case 1:
        return ItemType.armor;
      case 2:
        return ItemType.accessory;
      default:
        return ItemType.weapon;
    }
  }

  @override
  void write(BinaryWriter writer, ItemType obj) {
    switch (obj) {
      case ItemType.weapon:
        writer.writeByte(0);
        break;
      case ItemType.armor:
        writer.writeByte(1);
        break;
      case ItemType.accessory:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DetailTypeAdapter extends TypeAdapter<Type> {
  @override
  final int typeId = 202;

  @override
  Type read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Type.shield;
      case 1:
        return Type.dagger;
      case 2:
        return Type.bow;
      case 3:
        return Type.staff;
      case 4:
        return Type.plate;
      case 5:
        return Type.leather;
      case 6:
        return Type.cloth;
      case 7:
        return Type.money;
      default:
        return Type.shield;
    }
  }

  @override
  void write(BinaryWriter writer, Type obj) {
    switch (obj) {
      case Type.shield:
        writer.writeByte(0);
        break;
      case Type.dagger:
        writer.writeByte(1);
        break;
      case Type.bow:
        writer.writeByte(2);
        break;
      case Type.staff:
        writer.writeByte(3);
        break;
      case Type.plate:
        writer.writeByte(4);
        break;
      case Type.leather:
        writer.writeByte(5);
        break;
      case Type.cloth:
        writer.writeByte(6);
        break;
      case Type.money:
        writer.writeByte(7);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DetailTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GradeAdapter extends TypeAdapter<Grade> {
  @override
  final int typeId = 203;

  @override
  Grade read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Grade.normal;
      case 1:
        return Grade.uncommon;
      case 2:
        return Grade.heroic;
      case 3:
        return Grade.legendary;
      case 4:
        return Grade.epic;
      default:
        return Grade.normal;
    }
  }

  @override
  void write(BinaryWriter writer, Grade obj) {
    switch (obj) {
      case Grade.normal:
        writer.writeByte(0);
        break;
      case Grade.uncommon:
        writer.writeByte(1);
        break;
      case Grade.heroic:
        writer.writeByte(2);
        break;
      case Grade.legendary:
        writer.writeByte(3);
        break;
      case Grade.epic:
        writer.writeByte(4);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GradeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
