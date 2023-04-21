// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'skill.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SkillAdapter extends TypeAdapter<Skill> {
  @override
  final int typeId = 101;

  @override
  Skill read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Skill(
      name: fields[0] as String,
      turn: fields[1] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Skill obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.turn);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class SkillBookAdapter extends TypeAdapter<SkillBook> {
  @override
  final int typeId = 102;

  @override
  SkillBook read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SkillBook(
      fields[0] as Skill,
      fields[1] as Skill,
      fields[2] as Skill,
      fields[3] as Skill,
      fields[4] as Skill,
    );
  }

  @override
  void write(BinaryWriter writer, SkillBook obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.skill1)
      ..writeByte(1)
      ..write(obj.skill2)
      ..writeByte(2)
      ..write(obj.skill3)
      ..writeByte(3)
      ..write(obj.skill4)
      ..writeByte(4)
      ..write(obj.skill5);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SkillBookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
