import 'dart:math';

import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final List<Map> _products = [
    {'code'  : 'DLB2921', 'name'  : 'Doll Air Balloon', 'price' : 199000, 'include' : ['Satin Ribbon', 'Doll', 'Balloon Hamper (Circular Pot/ Narrowed Pot)']},
    {'code'  : 'MNF2925', 'name'  : 'Money Flowers', 'price' : 179000, 'include' : ['Flowers', 'Satin Ribbon & Organza Ribbon', 'Money', 'Card', 'Flower Wrapping Cellophane'],},
    {'code'  : 'FLB2925', 'name'  : 'Flowers Balloon', 'price' : 129000, 'include' : ['Satin Ribbon', 'Flowers', 'Flower Wrapping Cellophane']},
    {'code'  : 'NDF2922', 'name'  : 'CNY Doll Red Pocket', 'price' : 209000, 'include' : ['Doll (Shio)', 'Flowers', 'Red Pockets', 'Satin Ribbon', 'Balloon Hamper']},
    {'code'  : 'FLD2925', 'name'  : 'Balloon Flowers Doll', 'price' : 169000, 'include' : ['Satin Ribbon', 'Doll (Bear)', 'Flowers', 'Flower Wrapping Cellophane'],},
    {'code'  : 'SNA2921', 'name'  : 'Snacks Air Balloon', 'price' : 179000, 'include' : ['Satin Ribbon & Grosgrain Ribbon', 'Snacks', 'Card', 'Balloon Hamper (Circular Pot/ Narrowed Pot)'],},
    {'code'  : 'MNC2920', 'name'  : 'Money Cake Flower', 'price' : 219000, 'include' : ['Money (clients request)', 'Satin Ribbon', 'Main Flower']},
    {'code'  : 'FLW2921', 'name'  : 'Flower Air Balloon', 'price' : 149000, 'include' : ['Satin Ribbon & Organza Ribbon', 'Flowers', 'Card', 'Balloon Hamper (Circular Pot/ Narrowed Pot)'],},
    {'code'  : 'CDB2923', 'name'  : 'Chocolate Doll Balloon', 'price' : 250000, 'include' : ['Doll', 'Chocolate', 'Shaped Balloon', 'Artificial Flowers', 'Satin Ribbon', 'Balloon Hamper']},
    {'code'  : 'FLW2923', 'name'  : 'Pot Flowers Balloon', 'price' : 139000, 'include' : ['Organza Ribbon', 'Flowers', 'Card', 'Balloon Hamper', 'Bonus Optional Shaped Balloon'],},
    {'code'  : 'CSB2922', 'name'  : 'Rudolf Christmas Balloon', 'price' : 199000, 'include' : ['Doll (Rudolph)', 'Satin Ribbon', 'Balloon Hamper'],}
  ];
  List<Map> get products => _products;

  final List<Map> _searchProducts = [];
  List<Map> get searchProducts => _searchProducts;

  String _searchVal = '';
  String get searchVal => _searchVal;

  set searchVal(val) {
    _searchVal = val;
    notifyListeners();
  }

  set changeProduct(val) {
    _searchProducts.clear();
    for (var i = 0; i < products.length; i++) {
      if (products[i]['name'].toLowerCase().contains(val.toLowerCase())) {
        searchProducts.add(products[i]);
      }
    }
    notifyListeners();
  }

  randomRecommend() {
    List rekomen = [];
    for (var i = 0; i < (products.length/2).ceil(); i++) {
      final random =  Random();
      var num = random.nextInt(products.length);
      if (rekomen.contains(products[num])) { i -= 1; }
      else { rekomen.add(products[num]); }
    }
    return rekomen;
  }
}