import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 101)
class Skill {
  @HiveField(0)
  String name;
  @HiveField(1)
  double turn;

  @HiveField(2)
  Function? func;

  @HiveField(3)
  Skill({
    this.name = "",
    this.turn = 1,
    this.func,
  });

  @HiveField(3)
  @override
  String toString() => name;
}

bool defaultSkill(List targets) => false;

List<Skill> defaultSkillBook = [Skill(), Skill(), Skill(), Skill(), Skill()];
