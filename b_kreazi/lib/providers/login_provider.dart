import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool _showPass = false;
  bool get showPass => _showPass;

  showOrHide() {
    _showPass = !_showPass;
    notifyListeners();
  }

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  Map _currentUser = {};
  Map get currentUser => _currentUser;

  String _status = 'new';
  String get status => _status;

  set status(val) {
    _status = val;
    notifyListeners();
  }

  loggedIn() {
    _currentUser = {
      "username": username.text,
      "password": password.text,
    };
    _isLoggedIn = true;
    notifyListeners();
  }

  loggedOut() {
    _currentUser = {};
    _isLoggedIn = false;
    username.text = '';
    password.text = '';
    notifyListeners();
  }

  final List<Map> _database = [
    {'username' : 'b_kreazi_official', 'password' : '13_K12e4z1', 'fullname' : 'B_Kreazi Official', 'phone' : '08211112137', 'gender' : 'Perempuan'},
    {'username' : 'cindy_0347', 'password' : 'cindygituloh', 'fullname' : 'Cindy Sintiya', 'phone' : '08211110347', 'gender' : 'Perempuan'},
    {'username' : 'victoria_0515', 'password' : 'BKgerVB', 'fullname' : 'Victoria Beatrice', 'phone' : '08211110515', 'gender' : 'Perempuan'},
    {'username' : 'kkkrazy', 'password' : 'bUrGeRg1l4', 'fullname' : 'Kelly K', 'phone' : '087654321234', 'gender' : 'Laki-Laki'},
    {'username' : 'b_nny', 'password' : 'UnyailangXIXI', 'fullname' : 'creazy bunny bun', 'phone' : '081357924680', 'gender' : 'Laki-Laki'},
  ];
  List<Map> get database => _database;

  set addUser(val) {
    _database.add(val);
    notifyListeners();
  }

  resetAll() {
    username.text = '';
    password.text = '';
    _showPass = false;
    notifyListeners();
  }
}