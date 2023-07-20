import 'package:flutter/material.dart';

class NotificationProvider extends ChangeNotifier {
  // switch
  bool _unreadOnly = false;
  bool get unreadOnly => _unreadOnly;

  set showUnreadOnly(val) {
    _unreadOnly = val;
    notifyListeners();
  }

  // dropdownbutton
  final List notifType = ['Semua', 'Order', 'Promosi', 'Aplikasi'];
  String selectedType = 'Semua';

  set changeNotifType(val) {
    selectedType = val;
    notifyListeners();
  }

  // notification
  final List<Map> _allNotif = [
    {'id': 5, 'title': 'Pst psst...', 'body': 'Hei kamu! Iya kamu yang lagi baca notifikasi ini. Ada menu kami yang lagi promo lho. Khusus hari ini, dapatkan menu official B_Kreazi dengan diskon hingga 55% dengan minimal belanja Rp. 150.000,-. Harga otomatis terpotong jika minimal belanja tercapai.', 'date': '05-05-2023 05:05', 'type': 'Promosi', 'read': true},
    {'id': 4, 'title': 'Sudah waktunya Pick-Up', 'body': 'Kriinggg... Masih inget pesanan Burger yang kamu jadwalkan untuk diambil pukul 13:47? Kamu udah bisa datang ke store untuk cek apakah Burger-mu udah siap dan nikmatilah selagi fresh *chef kiss* (Ini adalah pesan otomatis)', 'date': '25-04-2023 13:47', 'type': 'Order', 'read': false},
    {'id': 3, 'title': 'Selamat makan Kreazier', 'body': 'Pesanan #211110 sudah kamu pick-up. Terima kasih udah menggunakan aplikasi B_Kreazi untuk memesan Burgermu. Selamat menikmati ~~', 'date': '24-04-2023 15:15', 'type': 'Order', 'read': true},
    {'id': 2, 'title': 'Yuk makan!', 'body': 'Hei, Kreazier *v*! Burger-mu udah siap nih. Yuk datang ke store untuk pick-up pesananmu dan nikmati selagi masih fresh! *yummy*', 'date': '15-04-2023 20:59', 'type': 'Order', 'read': true},
    {'id': 1, 'title': 'Makin baru makin crazy x-x', 'body': 'Update aplikasi kamu ke versi terbaru B_Kreazi untuk menikmati fitur-fitur baru yang kami luncurkan >V<', 'date': '09-04-2023 09:00', 'type': 'Aplikasi', 'read': false},
    {'id': 0, 'title': 'Welcome to B_Kreazi!', 'body': 'Selamat datang, Kreazier! Mulai kreazikan Burger pertama Anda dihalaman Home > Kreazikan dan nikmati sensasi rasa Burger yang paling cucok dengan selera Anda. Selamat Ber-Kreazi!!!', 'date': '02-03-2023 12:34', 'type': 'Promosi', 'read': false},
  ];
  List<Map> get allNotif => _allNotif;

  // read notif
  set readNotif(id) {
    _allNotif.firstWhere((notif) => notif['id']==id)['read'] = true;
    notifyListeners();
  }

  // delete all notif
  resetNotif() {
    _allNotif.clear();
    notifyListeners();
  }

  // delete specific notif
  set delNotif(id) {
    _allNotif.remove(_allNotif.firstWhere((notif) => notif['id']==id));
    notifyListeners();
  }

  // auto notif
  set autoSend(val) {
    int newId = 0;
    if (_allNotif.isNotEmpty) {
      newId = _allNotif[0]['id']+1;
    }
    _allNotif.insert(0, {'id' : newId});
    _allNotif[0].addAll(val);
    notifyListeners();
  }
}