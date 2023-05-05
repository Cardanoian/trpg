import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 101)
class Skill {
  @HiveField(1)
  String name;
  @HiveField(2)
  double turn;
  @HiveField(3)
  Function func;
  @HiveField(4)
  String src;

  Skill({
    this.name = "",
    this.turn = 1,
    this.src = "0",
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
