import 'package:flutter/material.dart';
import 'package:trpg/services/save_data.dart';

class SaveDataList with ChangeNotifier {
  List<SaveData?> _saveDataList = [null, null, null, null, null];

  void addSaveData(SaveData data) {
    _saveDataList.add(data);
    notifyListeners();
  }

  void updateList() {
    notifyListeners();
  }

  void clearList() {
    _saveDataList = [];
    notifyListeners();
  }

  void changeSaveData(SaveData? data, int index) {
    _saveDataList[index] = data;
    notifyListeners();
  }

  List<SaveData?> get saveDataList => _saveDataList;
}
