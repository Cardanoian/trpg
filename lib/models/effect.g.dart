// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'effect.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class EffectAdapter extends TypeAdapter<Effect> {
  @override
  final int typeId = 104;

  @override
  Effect read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Effect(
      by: fields[0] as String?,
      name: fields[1] as String,
      duration: fields[2] as int,
      strength: fields[3] as double,
      dex: fields[4] as double,
      intel: fields[5] as double,
      hp: fields[6] as double,
      atBonus: fields[7] as double,
      combat: fields[8] as double,
      dfBonus: fields[9] as double,
      diceAdv: fields[10] as double,
      buff: fields[11] as bool,
      addEffect: fields[12] as Function?,
    );
  }

  @override
  void write(BinaryWriter writer, Effect obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.by)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.duration)
      ..writeByte(3)
      ..write(obj.strength)
      ..writeByte(4)
      ..write(obj.dex)
      ..writeByte(5)
      ..write(obj.intel)
      ..writeByte(6)
      ..write(obj.hp)
      ..writeByte(7)
      ..write(obj.atBonus)
      ..writeByte(8)
      ..write(obj.combat)
      ..writeByte(9)
      ..write(obj.dfBonus)
      ..writeByte(10)
      ..write(obj.diceAdv)
      ..writeByte(11)
      ..write(obj.buff)
      ..writeByte(12)
      ..write(obj.addEffect);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is EffectAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
