import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trpg/models/character.dart';
import 'package:trpg/models/effect.dart';
import 'package:trpg/models/item.dart';
import 'package:trpg/models/skill.dart';
import 'package:trpg/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(CharacterAdapter());
  Hive.registerAdapter(ItemAdapter());
  Hive.registerAdapter(SkillAdapter());
  Hive.registerAdapter(ItemTypeAdapter());
  Hive.registerAdapter(DetailTypeAdapter());
  Hive.registerAdapter(GradeAdapter());
  Hive.registerAdapter(EffectAdapter());
  Box box = await Hive.openBox("myBox");
  box.delete("myBox");
  runApp(MyApp(
    box: box,
  ));
}

class MyApp extends StatelessWidget {
  final Box box;
  final String title = "TRPG";

  const MyApp({
    super.key,
    required this.box,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // initialRoute: "/home",
      // routes: {
      //   "/main": (BuildContext context) => const MainScreen(),
      //   "/newData": (BuildContext context) => NewDataScreen(box: box),
      //   "/home": (BuildContext context) => HomeScreen(box: box),
      // },
      home: HomeScreen(
        box: box,
      ),
    );
  }
}
