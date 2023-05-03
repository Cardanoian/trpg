import 'package:hive_flutter/hive_flutter.dart';
import 'package:trpg/services/save_data.dart';

const String boxName = "TRPG";

class HiveRepository {
  static late final Box<SaveData> saveBox;

  static Future openBox() async {
    saveBox = await Hive.openBox(boxName);
  }

  static Future<void> deleteAllBox() async {
    saveBox.deleteFromDisk();
  }

  static Future<void> put(String name, SaveData saveData) async {
    saveBox.put(name, saveData);
  }

  static SaveData? getData(String key) => saveBox.get(key);

  static List<SaveData> getAllData() => saveBox.values.toList();

  static Future<SaveData?> getAtIndex(int index) async => saveBox.getAt(index);

  static Future update(int index, SaveData saveData) async =>
      saveBox.putAt(index, saveData);

  static Future delete(String name) async {
    saveBox.delete(name);
  }

  static Future deleteAll() async {
    saveBox.clear();
  }
}
