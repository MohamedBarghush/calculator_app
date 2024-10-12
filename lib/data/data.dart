import 'package:flutter/material.dart';

String valToCalulate = "";

bool showingResult = false;

List buttons = [
  [1, Colors.white60],
  [2, Colors.white60],
  [3, Colors.white60],
  ['+', Colors.orange],
  [4, Colors.white60],
  [5, Colors.white60],
  [6, Colors.white60],
  ['-', Colors.orange],
  [7, Colors.white60],
  [8, Colors.white60],
  [9, Colors.white60],
  ['x', Colors.orange],
  ['C', Colors.red],
  [0, Colors.white60],
  ['=', Colors.orange],
  ['÷', Colors.orange],
];

List darkButtons = [
  [1, const Color(0xFF2C2C2C)],
  [2, const Color(0xFF2C2C2C)],
  [3, const Color(0xFF2C2C2C)],
  ['+', Colors.orange],
  [4, const Color(0xFF2C2C2C)],
  [5, const Color(0xFF2C2C2C)],
  [6, const Color(0xFF2C2C2C)],
  ['-', Colors.orange],
  [7, const Color(0xFF2C2C2C)],
  [8, const Color(0xFF2C2C2C)],
  [9, const Color(0xFF2C2C2C)],
  ['x', Colors.orange],
  ['C', Colors.red],
  [0, const Color(0xFF2C2C2C)],
  ['=', Colors.orange],
  ['÷', Colors.orange],
];

bool isWholeNumber(num value) {
  return value is int || value % 1 == 0;
}