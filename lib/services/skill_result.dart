import 'package:trpg/models/characters/character.dart';

class SkillResult {
  Character by;
  Character to;
  double hp;
  String skillName;

  SkillResult({
    this.hp = 0,
    required this.by,
    required this.to,
    this.skillName = "",
  });

  @override
  String toString() {
    return "$skillName - ${hp > 0 ? "데미지: ${-hp}" : "회복: $hp"}";
  }
}
