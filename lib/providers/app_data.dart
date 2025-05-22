import 'package:flutter/material.dart';

class AppData extends ChangeNotifier {
  int _counter = 0;
  String _username = 'Usuario';
  bool _allowReset = true;

  int get counter => _counter;
  String get username => _username;
  bool get allowReset => _allowReset;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void decrementCounter() {
    if (_counter > 0) {
      _counter--;
      notifyListeners();
    }
  }

  void resetCounter() {
    _counter = 0;
    notifyListeners();
  }

  void setUsername(String name) {
    _username = name;
    notifyListeners();
  }

  void toggleReset(bool value) {
    _allowReset = value;
    notifyListeners();
  }
}
