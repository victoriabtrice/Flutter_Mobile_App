import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController fullname = TextEditingController();
  TextEditingController userphone = TextEditingController();
  TextEditingController usermail = TextEditingController();
  
  int _activeTab = 0;
  int get activeTab => _activeTab;
  String _status = 'new';
  String get status => _status;

  set status(val) {
    _status = val;
    notifyListeners();
  }

  set activeTab(val) {
    _activeTab = val;
    notifyListeners();
  }

  Map _userInfo = {
    'username'  : '-',
    'fullname'  : '-',
    'userphone' : '-',
    'usermail'  : '-'
  };
  Map get userInfo => _userInfo;

  set login(val) {
    _userInfo.clear();
    _userInfo.addAll(val);
    notifyListeners();
  }
  logout() {
    _userInfo = {
      'username' : '-',
      'fullname' : '-',
      'userphone' : '-',
      'usermail' : '-'
    };
    _status = 'new';
    resetField();
    notifyListeners();
  }

  resetField() {
    username.text = '';
    fullname.text = '';
    userphone.text = '';
    usermail.text = '';
    notifyListeners();
  }
}