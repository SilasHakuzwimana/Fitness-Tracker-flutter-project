import 'package:flutter/material.dart';

class StepProvider extends ChangeNotifier {
  int _steps = 0;

  int get steps => _steps;

  void updateSteps(int steps) {
    _steps = steps;
    notifyListeners();
  }
}
