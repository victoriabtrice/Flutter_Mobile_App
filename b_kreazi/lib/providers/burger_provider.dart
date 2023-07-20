import 'dart:math';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';

class BurgerProvider extends ChangeNotifier {
  
  // CHOOSE BURGER
  final Map _burgerComponent = {
    'Selada' : {'on': false, 'price': 1000},
    'Bombai' : {'on': false, 'price': 2000},
    'Timun' : {'on': false, 'price': 1000},
    'Tomat' : {'on': false, 'price': 2000},
    'Jamur' : {'on': false, 'price': 4000},
    // 'Saus Keju' : {'on': false, 'price': 3000},
    'Keju' : {'on': false, 'price': 4000},
    'Telur' : {'on': false, 'price': 5000},
    'Sapi' : {'on': false, 'price': 12000},
    'Ayam' : {'on': false, 'price': 9000},
    'Ikan' : {'on': false, 'price': 10000},
    'Acar Timun' : {'on': false, 'price': 2000},
    'Onion Ring' : {'on': false, 'price': 4000},
    'Bayam' : {'on': false, 'price': 3000},
    'Paprika' : {'on': false, 'price': 5000},
    // 'Saus' : {'on': false, 'price': 2000},
  };
  Map get burgerComponent => _burgerComponent;

  set changeComponent(val) {
    _burgerComponent[val]['on'] = !_burgerComponent[val]['on'];
    notifyListeners();
  }
  resetComponent() {
    for (var component in _burgerComponent.keys) {
      _burgerComponent[component]['on'] = false;
    }
    notifyListeners();
  }

  // CUSTOM BURGER
  final Map _chosenComponent = {};
  Map get chosenComponent => _chosenComponent;
  set chosenComponent(val) {
    _burgerComponent[val]['on'] = !_burgerComponent[val]['on'];
    if (_burgerComponent[val]['on'] == true) {
      _chosenComponent.addAll({val: {'qty': 1, 'price': _burgerComponent[val]['price']}});
    }
    else {
      _chosenComponent.remove(val);
    }
    notifyListeners();
  }
  set addQty(val) {
    if (_chosenComponent[val]['qty'] < 3) {
      _chosenComponent[val]['qty'] += 1; 
      _chosenComponent[val]['price'] = burgerComponent[val]['price'] * _chosenComponent[val]['qty']; 
    }
    notifyListeners();
  }
  set minQty(val) {
    if (_chosenComponent[val]['qty'] > 1) {
      _chosenComponent[val]['qty'] -= 1;      
      _chosenComponent[val]['price'] = burgerComponent[val]['price'] * _chosenComponent[val]['qty']; 
    }
    notifyListeners();
  }
  resetChoosen() {
    _chosenComponent.clear();
    notifyListeners();
  }
  
  // FINAL BURGER
  final Map _finalComponent = {};
  Map get finalComponent => _finalComponent;
  set orderCreation(val) {
    _finalComponent.clear();
    _finalComponent.addAll(val);
    notifyListeners();
  }
  addFinal() {
    _finalComponent.clear();
    _finalComponent.addAll({
      'Burger' : {},
      'TtlQty' : 0,
      'TtlPrice' : 0
    });
    _finalComponent['Burger'].addAll({'Roti Atas': {'qty': 1, 'price': 3000}});
    _finalComponent['Burger'].addAll(chosenComponent);
    _finalComponent['Burger'].addAll({'Roti Bawah': {'qty': 1, 'price': 3000}});
    for (var item in _finalComponent['Burger'].values) {
      _finalComponent['TtlQty'] += item['qty'];
      _finalComponent['TtlPrice'] += item['price'];
    }
    notifyListeners();
  }
  resetFinal() {
    _finalComponent.clear();
    _finalComponent.addAll({
      'Burger' : {},
      'TtlQty' : 0,
      'TtlPrice' : 0
    });
    notifyListeners();
  }

  // ADDITION
  final Map _additional = {
    'Minuman' : {'on': false, 'option': {'Coca-Cola': false, 'Fanta': false, 'Sprite': false}, 'price': {'Coca-Cola': 8000, 'Fanta': 8000, 'Sprite': 8000}},
    'Kentang Goreng' : {'on': false, 'option': {'Kecil': false, 'Sedang': false, 'Besar': false}, 'price': {'Kecil': 6000, 'Sedang': 9000, 'Besar': 12000}},
    'Es Krim' : {'on': false, 'option': {'Coklat': false, 'Stroberi': false, 'Vanila': false}, 'price': {'Coklat': 9000, 'Stroberi': 9000, 'Vanila': 9000}},
  };
  Map get additional => _additional;

  set additional(val) {
    _additional[val[0]]['on'] = val[1];
    notifyListeners();
  }
  set option(val) {
    if (val[0]=='Kentang Goreng') { // hny bole pilih 1 size
      for (var key in _additional['Kentang Goreng']['option'].keys) {
        _additional['Kentang Goreng']['option'][key] = false;
      }
    }
    _additional[val[0]]['option'][val[1]] = val[2];
    notifyListeners();
  }
  
  // level pedas
  int _spicy = 0;
  int get spicy => _spicy;
  final List spicyLevel = ['Tidak pedas', 'Agak pedas', 'Pedas', 'Lumayan pedas', 'Pedas gila'];

  set spicy(val) {
    _spicy = val;
    notifyListeners();
  }

  // catatan tambahan
  TextEditingController note = TextEditingController();

  // FINAL ADDITION
  final Map _finalAddition = {};
  Map get finalAddition => _finalAddition;
  addAddition() {
    _finalAddition.clear();
    for (var add in _additional.entries) {
      if (add.value['on']) {
        _finalAddition.addAll({add.key : {}});            
        for (var opt in add.value['option'].entries) {
          if (opt.value) {
            _finalAddition[add.key].addAll({opt.key : add.value['price'][opt.key]});
          }
        }
      }
    }
    notifyListeners();
  }
  resetAddition() {
    _finalAddition.clear();
    for (var add in _additional.entries) {
      _additional[add.key]['on'] = false;
      for (var opt in add.value['option'].keys) {
        _additional[add.key]['option'][opt] = false;
      }
    }
    notifyListeners();
  }
  set reOrderAdditional(val) {
    _finalAddition.addAll(val);
    for (var type in _finalAddition.entries) {
      _additional[type.key]['on'] = true;
      for (var opt in _finalAddition[type.key].keys) {
        _additional[type.key]['option'][opt] = true;
      }
    }
    notifyListeners();
  }

  // USER INFO
  final TextEditingController _nama = TextEditingController();
  final TextEditingController _noHp = TextEditingController();
  TextEditingController get nama => _nama;
  TextEditingController get noHp => _noHp;
  String _gender = 'Laki-Laki';
  String get gender => _gender;

  set changeGender(val) {
    _gender = val;
    notifyListeners();
  }

  final Map _userInfo = {};
  Map get userInfo => _userInfo;

  set userInfo(val) {
    _userInfo.clear();
    _userInfo.addAll(val);
    _nama.text = _userInfo['Nama'];
    _noHp.text = _userInfo['No HP'];
    changeGender = _userInfo['Gender'];
    notifyListeners();
  }

  addContactInfo() {
    _userInfo.clear();
    _userInfo['Nama'] = nama.text.trim();
    _userInfo['No HP'] = noHp.text.trim();
    _userInfo['Gender'] = gender;
    _userInfo['Pembayaran'] = selPembayaran;
    _userInfo['Waktu'] = DateFormat('dd MMMM yyyy  HH:mm').format(DateTime.now()).toString();
    _userInfo['Pick Up'] = DateFormat('HH:mm').format(_waktu);
    notifyListeners();
  }
  resetContactInfo() {
    _userInfo.clear();
    _nama.clear();
    _noHp.clear();
    _gender = 'Laki-Laki';
    notifyListeners();
  }

  // CREATION NAME
  TextEditingController creationName = TextEditingController();

  // SAVE USER CONTACT TO PROFILE
  bool _saveUser = true;
  bool get saveUser => _saveUser;
  set saveUser(val) {
    _saveUser = val;
    notifyListeners();
  }

  // METODE PEMBAYARAN
  List pembayaran = ['OVO', 'GoPay', 'Dana', 'Kartu Kredit', 'Kartu Debit'];
  String _selPembayaran = 'Pilih';
  String get selPembayaran => _selPembayaran;
  set changePembayaran(val) {
    _selPembayaran = val;
    notifyListeners();
  }

  // WAKTU PENGAMBILAN
  DateTime _waktu = DateTime.now().add(const Duration(minutes: 5));
  DateTime get waktu => _waktu;
  set addWaktu(val) {
    if (val == 'jam' && _waktu.hour < 22) {
      _waktu = _waktu.add(const Duration(hours: 1));
    }
    else if(val == 'menit' && _waktu.hour < 22) {
      _waktu = _waktu.add(const Duration(minutes: 1));
    }
    if ((_waktu.hour >= 22 || _waktu.hour <= 6)) {
      _waktu = _waktu.subtract(Duration(minutes: _waktu.minute));
    }
    notifyListeners();
  }
  set redWaktu(val) {
    if (val == 'jam' && _waktu.hour > 6 && _waktu.hour > DateTime.now().add(const Duration(minutes: 5)).hour) {
      _waktu = _waktu.subtract(const Duration(hours: 1));
    }
    else if(val == 'menit' && (_waktu.difference(DateTime.now().add(const Duration(minutes: 5))).inMinutes > 0)) {
      _waktu = _waktu.subtract(const Duration(minutes: 1));
    }
    if (_waktu.difference(DateTime.now().add(const Duration(minutes: 5))).inMinutes <= 0) {
      _waktu = DateTime.now().add(const Duration(minutes: 5));
    }
    if ((_waktu.hour >= 22 || _waktu.hour <= 6)) {
      _waktu = _waktu.subtract(Duration(minutes: _waktu.minute));
    }
    notifyListeners();
  }
  set addPickup(val) {  // time picker
    _waktu = val;
    notifyListeners();
  }
  resetTime() {
    _waktu = DateTime.now().add(const Duration(minutes: 5));
    notifyListeners();
  }

  // PESANAN SAYA
  myCreation(username) {
    Map finalCreation = {};
    finalCreation.addAll(finalComponent);
    if (!finalComponent.containsKey('Creator')) {
      finalCreation.addAll({
        'Creator' : nama.text.trim(),
        'Name' : creationName.text.isNotEmpty? creationName.text.trim() : 'Kreazi-ku',
      });
    }
    finalCreation.addAll({
      'TtlLikes' : 0,
      'liked': false,
      'Username': username
    });
    return finalCreation;
  }
  myOrder(username) {
    Map finalCreation = myCreation(username);
    finalCreation['Addition'] = {};
    for (var item in finalAddition.entries) {
      finalCreation['Addition'].addAll({item.key : item.value});
    }
    finalCreation['Spicy'] = spicyLevel[spicy.toInt()];
    if (note.text.trim().isEmpty) {
      finalCreation['Note'] = '-';
    }
    else {
      finalCreation['Note'] = note.text;
    }
    double ttlPrice = 0;
    for (var item in finalAddition.values) {
      for (var prices in item.entries) {
        ttlPrice += prices.value;
      }
    }
    if (finalComponent.containsKey('Discount')) {
      ttlPrice -= finalComponent['Discount'];
    }
    finalCreation['FinalPrice'] = ttlPrice + finalCreation['TtlPrice'];
    finalCreation['Contact'] = {};
    for (var item in userInfo.entries) {
      finalCreation['Contact'].addAll({item.key : item.value});
    }
    finalCreation.addAll({'Order' : {
      'Code' : Random().nextInt(899999)+100000,   // random 6 digit
      'Status' : 'Pesanan Baru'
    }});
    return finalCreation;
  }

  // CLEAN ALL CUSTOMIZATION
  resetAll() {
    resetComponent();
    resetChoosen();
    resetFinal();
    resetAddition();
    resetTime();
    spicy = 0;
    note.text = '';
    _saveUser = true;
    creationName.text = '';
    notifyListeners();
  }
}