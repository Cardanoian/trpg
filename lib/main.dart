import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:trpg/models/characters/character.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skills/skill.dart';
import 'package:trpg/models/targets.dart';
import 'package:trpg/screens/home_screen.dart';
import 'package:trpg/services/game_data.dart';
import 'package:trpg/services/hive_repository.dart';
import 'package:trpg/services/save_data_list.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(DetailTypeAdapter());
  Hive.registerAdapter(EffectAdapter());
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (BuildContext context) => SaveDataList()),
        ChangeNotifierProvider<Targets>(
            create: (BuildContext context) => Targets()),
        ChangeNotifierProvider<GameData>(
            create: (BuildContext context) => GameData()),
      ],
      child: MaterialApp(
        title: title,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
