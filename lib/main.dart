import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skill.dart';
import 'package:trpg/models/skills/enemy_skills.dart';
import 'package:trpg/models/skills/job_skills.dart';
import 'package:trpg/models/skills/magics.dart';
import 'package:trpg/screens/home_screen.dart';
import 'package:trpg/services/hive_repository.dart';
import 'package:trpg/services/save_data.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(DetailTypeAdapter());
  Hive.registerAdapter(GradeAdapter());
  Hive.registerAdapter(EffectAdapter());
  Hive.registerAdapter(SaveDataAdapter());
  Hive.registerAdapter(MagicsAdapter());
  Hive.registerAdapter(JobSkillsAdapter());
  Hive.registerAdapter(EnemySkillsAdapter());
  await HiveRepository.openBox();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final String title = "TRPG";

  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(
        title: title,
      ),
    );
  }
}
