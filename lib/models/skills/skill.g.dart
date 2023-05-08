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
      name: fields[1] as String,
      turn: fields[2] as double,
      src: fields[4] as String,
      func: fields[3] as Function,
    );
  }

  @override
  void write(BinaryWriter writer, Skill obj) {
    writer
      ..writeByte(4)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.turn)
      ..writeByte(3)
      ..write(obj.func)
      ..writeByte(4)
      ..write(obj.src);
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
