import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:trpg/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Box box = await Hive.openBox("myBox");
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
