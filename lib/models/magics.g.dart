// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'magics.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MagicsAdapter extends TypeAdapter<Magics> {
  @override
  final int typeId = 105;

  @override
  Magics read(BinaryReader reader) {
    return Magics();
  }

  @override
  void write(BinaryWriter writer, Magics obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MagicsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
