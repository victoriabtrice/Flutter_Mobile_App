import 'package:flutter/material.dart';

class CreationProvider extends ChangeNotifier {
  final List<Map> _allCreations = [
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Selada' : {'qty': 1, 'price': 1000},
        'Jamur' : {'qty': 1, 'price': 4000},
        'Telur' : {'qty': 1, 'price': 5000},
        'Bayam' : {'qty': 1, 'price': 3000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 6,
      'TtlPrice' : 19000,
      'Creator' : 'Evegan',
      'Name' : 'VeGer',
      'TtlLikes' : 19,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Selada' : {'qty': 1, 'price': 1000},
        'Tomat' : {'qty': 1, 'price': 2000},
        'Keju' : {'qty': 1, 'price': 4000},
        'Sapi' : {'qty': 1, 'price': 12000},
        'Acar Timun' : {'qty': 1, 'price': 2000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 7,
      'TtlPrice' : 27000,
      'Creator' : 'CiViC',
      'Name' : 'just normal',
      'TtlLikes' : 20,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Selada' : {'qty': 1, 'price': 1000},
        'Bombai' : {'qty': 1, 'price': 2000},
        'Timun' : {'qty': 1, 'price': 1000},
        'Tomat' : {'qty': 1, 'price': 2000},
        'Jamur' : {'qty': 1, 'price': 4000},
        'Acar Timun' : {'qty': 1, 'price': 2000},
        'Onion Ring' : {'qty': 1, 'price': 4000},
        'Bayam' : {'qty': 1, 'price': 3000},
        'Paprika' : {'qty': 1, 'price': 5000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 11,
      'TtlPrice' : 30000,
      'Creator' : 'Healti',
      'Name' : 'Burger Sehat',
      'TtlLikes' : 0,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Ikan' : {'qty': 1, 'price': 10000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 3,
      'TtlPrice' : 16000,
      'Creator' : 'sintiyaaa',
      'Name' : 'somethin` fishy',
      'TtlLikes' : 1,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Selada' : {'qty': 1, 'price': 1000},
        'Timun' : {'qty': 1, 'price': 1000},
        'Ikan' : {'qty': 1, 'price': 10000},
        'Onion Ring' : {'qty': 1, 'price': 4000},
        'Bayam' : {'qty': 1, 'price': 3000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 7,
      'TtlPrice' : 25000,
      'Creator' : 'btrice',
      'Name' : 'fish n fresh',
      'TtlLikes' : 7,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Selada' : {'qty': 1, 'price': 1000},
        'Bombai' : {'qty': 1, 'price': 2000},
        'Timun' : {'qty': 1, 'price': 1000},
        'Tomat' : {'qty': 1, 'price': 2000},
        'Jamur' : {'qty': 1, 'price': 4000},
        'Keju' : {'qty': 1, 'price': 4000},
        'Telur' : {'qty': 1, 'price': 5000},
        'Sapi' : {'qty': 1, 'price': 12000},
        'Ayam' : {'qty': 1, 'price': 9000},
        'Ikan' : {'qty': 1, 'price': 10000},
        'Acar Timun' : {'qty': 1, 'price': 2000},
        'Onion Ring' : {'qty': 1, 'price': 4000},
        'Bayam' : {'qty': 1, 'price': 3000},
        'Paprika' : {'qty': 1, 'price': 5000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 16,
      'TtlPrice' : 70000,
      'Creator' : 'Cndy',
      'Name' : 'ALL` in!',
      'TtlLikes' : 15,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Selada' : {'qty': 1, 'price': 1000},
        'Telur' : {'qty': 1, 'price': 5000},
        'Bayam' : {'qty': 1, 'price': 3000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 5,
      'TtlPrice' : 15000,
      'Creator' : 'BettyB',
      'Name' : 'basic = hemat',
      'TtlLikes' : 4,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Sapi' : {'qty': 1, 'price': 12000},
        'Ayam' : {'qty': 1, 'price': 9000},
        'Ikan' : {'qty': 1, 'price': 10000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 5,
      'TtlPrice' : 37000,
      'Creator' : 'vctria',
      'Name' : '3rio-meat-combo',
      'TtlLikes' : 12,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Timun' : {'qty': 1, 'price': 1000},
        'Tomat' : {'qty': 1, 'price': 2000},
        'Keju' : {'qty': 1, 'price': 4000},
        'Sapi' : {'qty': 1, 'price': 12000},
        'Ayam' : {'qty': 1, 'price': 9000},
        'Acar Timun' : {'qty': 1, 'price': 2000},
        'Onion Ring' : {'qty': 1, 'price': 4000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 9,
      'TtlPrice' : 40000,
      'Creator' : 'stepen',
      'Name' : 'great meat combi',
      'TtlLikes' : 2,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Ayam' : {'qty': 3, 'price': 27000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 5,
      'TtlPrice' : 33000,
      'Creator' : 'CIKI',
      'Name' : 'ciken 4 laif',
      'TtlLikes' : 4,
      'liked': false,
    },
    {
      'Burger' : {
        'Roti Atas': {'qty': 1, 'price': 3000},
        'Bombai' : {'qty': 1, 'price': 2000},
        'Timun' : {'qty': 1, 'price': 1000},
        'Jamur' : {'qty': 1, 'price': 4000},
        'Telur' : {'qty': 1, 'price': 5000},
        'Sapi' : {'qty': 1, 'price': 12000},
        'Paprika' : {'qty': 1, 'price': 5000},
        'Roti Bawah': {'qty': 1, 'price': 3000},
      },
      'TtlQty' : 8,
      'TtlPrice' :35000,
      'Creator' : 'kr1st0bal',
      'Name' : 'BalenciagA',
      'TtlLikes' : 2,
      'liked': false,
    },
  ];
  List<Map> get allCreations => _allCreations;

  set addCreations(val) {
    _allCreations.insert(0, val);
    notifyListeners();
  }
  set delCreation(val) {
    _allCreations.removeWhere((kreazi) => val['Name']==kreazi['Name']);
    notifyListeners();
  }

  set liked(name) {
    // all creation
    Map creation = _allCreations.firstWhere((creation) => creation['Name'] == name, orElse: () => {});
    if (creation.isNotEmpty) {
      creation['TtlLikes'] += 1;
      creation['liked'] = true;
    }
    // my creation
    Map kreazi = _myCreation.firstWhere((creation) => creation['Name'] == name, orElse: () => {});
    if (kreazi.isNotEmpty) {
      kreazi['TtlLikes'] += 1;
      kreazi['liked'] = true;
    }
    notifyListeners();
  }
  set unliked(name) {
    Map creation = _allCreations.firstWhere((creation) => creation['Name'] == name, orElse: () => {});
    if (creation.isNotEmpty) {
      creation['TtlLikes'] -= 1;
      creation['liked'] = false;
    }
    Map kreazi = _myCreation.firstWhere((creation) => creation['Name'] == name, orElse: () => {});
    if (kreazi.isNotEmpty) {
      kreazi['TtlLikes'] -= 1;
      kreazi['liked'] = false;
    }
    notifyListeners();
  }

  topCreation() {
    int highest = 0;
    Map top = {};
    for (var creation in _allCreations) {
      if (creation['TtlLikes'] > highest) {
        highest = creation['TtlLikes'];
        top = creation;
      }
    }
    return top;
  }

  final List<Map> _myCreation = [];
  List<Map> get myCreation => _myCreation;
  set addMyCreation(val) {
    _myCreation.insert(0, val);
    notifyListeners();
  }
  set delMyCreation(val) {
    try {
      delCreation = val;
      _myCreation.removeWhere((kreazi) => val['Name']==kreazi['Name']);
    } 
    catch (e) {
      _myCreation.removeWhere((kreazi) => val['Name']==kreazi['Name']);      
    }
    notifyListeners();
  }
}