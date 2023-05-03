import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 101)
class Skill {
  @HiveField(0)
  String name;
  @HiveField(1)
  double turn;
  @HiveField(2)
  Function func;

  Skill({
    this.name = "",
    this.turn = 1,
    required this.func,
  });
}

bool defaultSkill(List targets) => false;

List<Skill> defaultSkillBook = [
  Skill(func: defaultSkill),
  Skill(func: defaultSkill),
  Skill(func: defaultSkill),
  Skill(func: defaultSkill),
  Skill(func: defaultSkill),
];
