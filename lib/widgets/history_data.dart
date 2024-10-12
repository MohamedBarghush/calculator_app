// ignore_for_file: invalid_use_of_protected_member
import 'package:flutter/material.dart';

class HistoryTile {
  String expression;
  String result;

  HistoryTile({required this.expression, required this.result});
}

class HistoryNotifier with ChangeNotifier {
  final List<HistoryTile> _historyTiles = [];

  List<HistoryTile> get historyTiles => _historyTiles;

  void addHistoryTile(String expression, String result) {
    _historyTiles.add(HistoryTile(expression: expression, result: result));
    notifyListeners();
  }

  void clearHistory() {
    _historyTiles.clear();
    notifyListeners();
  }
}