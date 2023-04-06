import 'dart:collection';

import 'package:flutter/material.dart';

class Pertemuan05Provider extends ChangeNotifier {
  // status soal telah dipeljari saat?

  // Inisialisasi nilai awal
  bool _diSekolah = false;
  bool _diPraktik = true;
  bool _diKursus = false;

  // Ini akan return nilai dari disekolah, dipraktik, dst. Ingat konsep OOP setter || getter
  bool get statusSekolah => _diSekolah;
  bool get statusPraktik => _diPraktik;
  bool get statusKursus => _diKursus;

  // Perubahan state, ingat konsep Listen pada StateManajemen
  set setSekolah(val){
    _diSekolah = val;
    notifyListeners();
  }

  set setPraktik(val) {
    _diPraktik = val;
    notifyListeners();
  }

  set setKursus(val) {
    _diKursus = val;
    notifyListeners();
  }

  // status peminatan saat sekolah?

  // Inisialisasi nilai awal
  bool _minatTKJ = false;
  bool _minatRPL = false;
  bool _minatSMA = false;

  // Ini akan return nilai dari disekolah, dipraktik, dst. Ingat konsep OOP setter || getter
  bool get statusTKJ => _minatTKJ;
  bool get statusRPL => _minatRPL;
  bool get statusSMA => _minatSMA;

  // Perubahan state, ingat konsep Listen pada StateManajemen
  set setTKJ(val){
    _minatTKJ = val;
    // _minatRPL = false;
    // _minatSMA = false;
    notifyListeners();
  }

  set setRPL(val) {
    _minatRPL = val;
    // _minatTKJ = false;
    // _minatSMA = false;
    notifyListeners();
  }

  set setSMA(val) {
    _minatSMA = val;
    // _minatTKJ = false;
    // _minatRPL = false;
    notifyListeners();
  }

  final Set<String> _bag = {};
  Set<String> get bag => _bag;
  set isiBag(val){
    _bag.add(val);
    notifyListeners();
  }

  set removeBag(val){
    _bag.remove(val);
    notifyListeners();
  }

  bool _isTKJAdd = false;
  bool _isRPLAdd = false;
  bool _isSMAAdd = false;
  
  bool get isTKJAdd => _isTKJAdd;
  bool get isRPLAdd => _isRPLAdd;
  bool get isSMAAdd => _isSMAAdd;

  set setTKJStatus(val){
    _isTKJAdd = val;
    notifyListeners();
  }

  set setRPLStatus(val){
    _isRPLAdd = val;
    notifyListeners();
  }

  set setSMAStatus(val){
    _isSMAAdd = val;
    notifyListeners();
  }
}
