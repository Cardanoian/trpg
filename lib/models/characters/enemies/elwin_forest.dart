import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/characters/enemies/enemy.dart';
import 'package:trpg/models/skills/enemy_skills.dart';
import 'package:trpg/models/skills/skill.dart';

Character goblin(
  int level,
  List<Character> heroes,
  List<Character> enemies,
) =>
    enemy(
      name: "고블린",
      job: "적",
      bStr: 20 + level * 2,
      bDex: 3,
      bInt: 4 + level * 1.5,
      skillBook: [
        Skill(name: "후려치기", turn: 1, func: EnemySkills.strike),
        Skill(name: "꿰뚫기", turn: 1, func: EnemySkills.pierce),
      ],
      heroes: heroes,
      enemies: enemies,
    );

Character goblinArcher(
  int level,
  List<Character> heroes,
  List<Character> enemies,
) =>
    enemy(
      name: "고블린 궁수",
      job: "적",
      level: level,
      bStr: 15 + level * 1.5,
      bDex: 3,
      bInt: 5 + level * 1.5,
      skillBook: [
        Skill(name: "사격", turn: 1, func: EnemySkills.shoot),
      ],
      heroes: heroes,
      enemies: enemies,
    );

Character goblinBomber(
  int level,
  List<Character> heroes,
  List<Character> enemies,
) =>
    enemy(
      name: "고블린 폭발병",
      job: "적",
      level: level,
      bStr: 20 + level * 1.5,
      bDex: 3,
      bInt: 4 + level * 1.5,
      skillBook: [
        Skill(name: "폭발", turn: 1, func: EnemySkills.bomb),
      ],
      heroes: heroes,
      enemies: enemies,
    );

Character goblinChief(
  int level,
  List<Character> heroes,
  List<Character> enemies,
) =>
    enemy(
      name: "고블린 대장",
      job: "적",
      level: level + 1,
      bStr: 100 + level * 10,
      bDex: 3,
      bInt: 12 + level * 3.0,
      skillBook: [
        Skill(name: "발 구르기", turn: 1, func: EnemySkills.stomp),
        Skill(name: "꿰뚫기", turn: 1, func: EnemySkills.pierce),
        Skill(name: "방어구 부수기", turn: 1, func: EnemySkills.breakingArmor),
      ],
      heroes: heroes,
      enemies: enemies,
    );

Character wolf(
  int level,
  List<Character> heroes,
  List<Character> enemies,
) =>
    enemy(
      name: "호랑이",
      job: "적",
      level: level,
      bStr: 20 + 2,
      bDex: 3,
      bInt: 5 + level * 1.5,
      skillBook: [
        Skill(name: "물기", turn: 1, func: EnemySkills.pierce),
      ],
      heroes: heroes,
      enemies: enemies,
    );
