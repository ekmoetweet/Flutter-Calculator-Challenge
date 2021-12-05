import 'dart:convert';

import 'package:challenge/models/history_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Calculator extends ChangeNotifier {
  var _count = 0;
  double _total = 0;
  late HistoryModel _history;

  double get getTotal {
    return _total;
  }

  void calculate(double? _firstNumber, double? _secondNumber) {
    if (_firstNumber != null && _secondNumber != null) {
      _total = (_firstNumber + _secondNumber);
      saveCalculation("$_firstNumber + $_secondNumber = $_total");
    }
    notifyListeners();
  }
}

Future<List<HistoryItem>?> getHistory() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HistoryModel _history = HistoryModel();
  String? jsonFromPrefs = prefs.getString("history");

  if (jsonFromPrefs != null) {
    _history = HistoryModel.fromJson(Map<String, dynamic>.from(json.decode(jsonFromPrefs)));
  } else {
    _history.history = [];
  }

  return _history.history;
}

Future<void> saveCalculation(String _calculationString) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  HistoryModel _history = HistoryModel();
  String? jsonFromPrefs = prefs.getString("history");

  if (jsonFromPrefs != null) {
    _history = HistoryModel.fromJson(Map<String, dynamic>.from(json.decode(jsonFromPrefs)));
  } else {
    _history.history = [];
  }
  dynamic currentTime = DateTime.now();
  HistoryItem historyItem = HistoryItem(time: currentTime.toString(), calculation: _calculationString);

  _history.history?.add(historyItem);
  jsonFromPrefs = jsonEncode(_history.toJson());
  await prefs.setString("history", jsonFromPrefs);
}
