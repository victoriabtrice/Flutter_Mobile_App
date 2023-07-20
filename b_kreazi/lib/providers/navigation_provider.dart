import 'package:flutter/material.dart';

class NavigationProvider extends ChangeNotifier {
  // bottom navigation
  int _currentIndex = 0;  // 0: home, 1: order
  int get currentIndex => _currentIndex;
  set currentIndex(val) {
    _currentIndex = val;
    notifyListeners();
  }

  // burger custom n order navigation
  String _orderState = 'Choose';  // choose: switch ingredients, custom: add ingredients, addition: drink n side dish n dessert, contact: user info, payment method, n pick up time
  String get orderState => _orderState;
  set orderState(val) {
    _orderState = val;
    notifyListeners();
  }
}