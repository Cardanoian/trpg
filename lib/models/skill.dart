class Skill {
  String name;
  double turn;

  Skill({
    this.name = "No Skill",
    this.turn = 1,
  });

  @override
  String toString() => name;
}

class SkillBook {
  Skill skill1;
  Skill skill2;
  Skill skill3;
  Skill skill4;
  Skill skill5;

  SkillBook(
    this.skill1,
    this.skill2,
    this.skill3,
    this.skill4,
    this.skill5,
  );

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
