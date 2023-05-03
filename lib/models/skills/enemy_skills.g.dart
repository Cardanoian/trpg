// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enemy_skills.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EnemySkillsAdapter extends TypeAdapter<EnemySkills> {
  @override
  final int typeId = 108;

  @override
  EnemySkills read(BinaryReader reader) {
    return EnemySkills();
  }

  @override
  void write(BinaryWriter writer, EnemySkills obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EnemySkillsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
