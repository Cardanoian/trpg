import 'package:hive_flutter/hive_flutter.dart';

const String boxName = "TRPG";

class HiveRepository {
  static late final Box<List> saveBox;

  static Future openBox() async {
    saveBox = await Hive.openBox(boxName);
  }

  static Future<void> deleteAllBox() async {
    saveBox.deleteFromDisk();
  }

  static Future<void> put(String name, List gameData) async {
    saveBox.put(name, gameData);
  }

  static List? getData(String key) => saveBox.get(key);

  static List<List> getAllData() => saveBox.values.toList();

  static Future<List?> getAtIndex(int index) async => saveBox.getAt(index);

  static Future update(int index, List mapData) async =>
      saveBox.putAt(index, mapData);

  static Future delete(String name) async {
    saveBox.delete(name);
  }

  static Future deleteAll() async {
    saveBox.clear();
  }
}
