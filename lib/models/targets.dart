import 'package:flutter/material.dart';

class Targets extends ChangeNotifier {
  List items;

  Targets({required this.items});

  void add(item) {
    items.add(item);
    notifyListeners();
  }

  void remove(item) {
    items.remove(item);
    notifyListeners();
  }

  void update() {
    notifyListeners();
  }

  void clear() {
    items = [];
    notifyListeners();
  }
}
