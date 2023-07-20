import 'package:flutter/material.dart';

class FeedbackProvider extends ChangeNotifier {
  String _status = 'new';
  String get status => _status;

  set status(val) {
    _status = val;
    notifyListeners();
  }

  TextEditingController nama = TextEditingController();
  TextEditingController komentar = TextEditingController();
  bool _setuju = false;
  bool get setuju => _setuju;
  bool _hideNama = false;
  bool get hideNama=> _hideNama;
  String _namaHidden = 'inisial';
  String get namaHidden => _namaHidden;

  set setuju(val) {
    _setuju = val;
    notifyListeners();
  }
  set hideNama(val) {
    _hideNama = val;
    notifyListeners();
  }
  set namaHidden(val) {
    _namaHidden = val;
    notifyListeners();
  }

  Map tingkatKepuasan = {
    'Sangat Puas' : false,
    'Puas'        : false,
    'Cukup Puas'  : false,
    'Kurang Puas' : false,
    'Tidak Puas'  : false,
  };
  String _puasTerpilih = '';
  String get puasTerpilih => _puasTerpilih;

  set changeKepuasan(List val) {
    // ubah semua pilihan ke false dulu
    for (var item in tingkatKepuasan.keys) {
      tingkatKepuasan[item] = false;
    }
    String tingkat = val[0];  // hanya tingkatKepuasan
    bool dipilih = val[1];   // yg terpilih
    tingkatKepuasan[tingkat] = dipilih;  // yg akan diubah jd true/ false
    _puasTerpilih = tingkatKepuasan.keys.firstWhere((element) => tingkatKepuasan[element], orElse: () => '');
    notifyListeners();
  }

  Map tags = {
    'Sketsa Potret': false, 
    'Penataan': false, 
    'Kualitas': false, 
    'Harga': false, 
    'Respon': false
  };
  List _chosenTag = [];
  List get chosenTag => _chosenTag;

  set addTags(val) {
    if (_chosenTag.contains(val)) {
      _chosenTag.remove(val);
    }
    else {
      _chosenTag.add(val);
    }
    notifyListeners();
  }

  set selectTag(List val) {
    tags[val[0]] = val[1];
    notifyListeners();
  }

  final List<Map> _reviews = [
    {'nama': 'Mikhaylia Florence', 'anonim': false, 'inisial': false, 'komentar': 'Ud pesan dari jam 10 pagi, sampe jam 2 siang pun masih belum ada respon mengenai pesanan saya. Pas chat di WA katanya suruh tunggu dulu, karna pesanan lagi membludak. Ada-ada saja.', 'kepuasan': 'Kurang Puas', 'tags': ['Respon'], 'tgl': '10-04-2023 13:31', 'spotlight': false},
    {'nama': 'Angela Irena', 'anonim': false, 'inisial': false, 'komentar': 'Suka banget sama hasil sketsanya! Idenya bagus-bagus semua, I like it!', 'kepuasan': 'Sangat Puas', 'tags': ['Sketsa Potret', 'Kualitas'], 'tgl': '01-02-2023 08:52', 'spotlight': false},
    {'nama': 'Antonius', 'anonim': false, 'inisial': true, 'komentar': '', 'kepuasan': 'Cukup Puas', 'tags': ['Harga', 'Respon', 'Penataan'], 'tgl': '21-11-2022 13:31', 'spotlight': false},
    {'nama': 'Crystaline Olivia Ashley', 'anonim': false, 'inisial': false, 'komentar': 'Cantik', 'kepuasan': 'Puas', 'tags': [], 'tgl': '22-08-2022 13:31', 'spotlight': false},
    {'nama': 'Owen Syahputra', 'anonim': true, 'inisial': false, 'komentar': 'Harga gak setimpal sama hasil yang saya dapatkan. Walaupun teman saya merasa puas, tidak dengan saya yang harus merogoh kocek cukup besar hanya untuk sebuah balon yang bisa saya hias dan tiup sendiri.', 'kepuasan': 'Tidak Puas', 'tags': ['Harga'], 'tgl': '13-04-2022 11:12', 'spotlight': false},
  ];
  List<Map> get reviews => _reviews;

  set sendFeedback(val) {
    _reviews.insert(0, val);
    resetFeedback();
    notifyListeners();
  }

  set removeFeedback(idx) {
    _reviews.removeAt(idx);
    notifyListeners();
  }

  spotlight() {
    _reviews[0]['spotlight'] = !_reviews[0]['spotlight'];
    _reviews.sort((a, b) => a['spotlight'].toString().length.compareTo(b['spotlight'].toString().length));
    notifyListeners();
  }

  resetFeedback() {
    nama.text = '';
    komentar.text = '';
    _setuju = false;
    _hideNama = false;
    _namaHidden = 'inisial';
    tingkatKepuasan = {
      'Sangat Puas' : false,
      'Puas'        : false,
      'Cukup Puas'  : false,
      'Kurang Puas' : false,
      'Tidak Puas'  : false,
    };
    tags = {
      'Sketsa Potret': false, 
      'Penataan': false, 
      'Kualitas': false, 
      'Harga': false, 
      'Respon': false
    };
    _chosenTag = [];
    status = 'new';
    notifyListeners();
  }
}