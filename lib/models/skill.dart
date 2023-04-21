import 'package:hive/hive.dart';

part 'skill.g.dart';

@HiveType(typeId: 101)
class Skill {
  @HiveField(0)
  String name;
  @HiveField(1)
  double turn;

  Skill({
    this.name = "No Skill",
    this.turn = 1,
  });

  @HiveField(2)
  @override
  String toString() => name;
}

@HiveType(typeId: 102)
class SkillBook {
  @HiveField(0)
  Skill skill1;
  @HiveField(1)
  Skill skill2;
  @HiveField(2)
  Skill skill3;
  @HiveField(3)
  Skill skill4;
  @HiveField(4)
  Skill skill5;

  SkillBook(
    this.skill1,
    this.skill2,
    this.skill3,
    this.skill4,
    this.skill5,
  );

  @HiveField(5)
  @override
  String toString() =>
      '1. ${skill1.name} 2. ${skill2.name} 3. ${skill3.name} 4. ${skill4.name} a. 평타';
}

SkillBook defaultSkillBook = SkillBook(
  Skill(),
  Skill(),
  Skill(),
  Skill(),
  Skill(),
);
