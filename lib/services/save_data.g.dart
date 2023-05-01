// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'save_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SaveDataAdapter extends TypeAdapter<SaveData> {
  @override
  final int typeId = 105;

  @override
  SaveData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SaveData(
      heroes: (fields[0] as List).cast<Character>(),
      enemies: (fields[1] as List).cast<Character>(),
      lastPlayTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, SaveData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.heroes)
      ..writeByte(1)
      ..write(obj.enemies)
      ..writeByte(2)
      ..write(obj.lastPlayTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SaveDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
