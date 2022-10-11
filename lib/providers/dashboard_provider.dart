import 'package:flutter/material.dart';

class DashboardProvider with ChangeNotifier {
  int _selectedTab = 0;
  int get getIndex => _selectedTab;

  changeIndex(int val) {
    _selectedTab = val;
    notifyListeners();
  }
}
