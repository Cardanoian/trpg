// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_skills.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class JobSkillsAdapter extends TypeAdapter<JobSkills> {
  @override
  final int typeId = 106;

  @override
  JobSkills read(BinaryReader reader) {
    return JobSkills();
  }

  @override
  void write(BinaryWriter writer, JobSkills obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is JobSkillsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
