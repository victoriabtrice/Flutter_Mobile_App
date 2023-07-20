import 'package:flutter/material.dart';

class NotifProvider extends ChangeNotifier {
  // switch
  bool _unreadOnly = false;
  bool get unreadOnly => _unreadOnly;

  set showUnreadOnly(val) {
    _unreadOnly = val;
    notifyListeners();
  }

  // dropdownbutton
  final List notifType = ['Semua', 'Promosi', 'Aplikasi', 'Order'];
  String selectedType = 'Semua';

  set changeNotifType(val) {
    selectedType = val;
    notifyListeners();
  }

  // notification
  List<Map> allNotif = [
    {'id': '5', 'title': 'Voucher spesial untukmu', 'body': 'Hey, bloomers! Sudah cukup lama sejak pesanan terakhir kamu diterima. Jika ada hal yang kurang memuaskanmu, maukah kamu mengisi Feedback dan kamu akan mendapatkan voucher spesial sebesar Rp. 29.999,-', 'date': '23-06-2023 21:11', 'type': 'Promosi', 'read': true},
    {'id': '4', 'title': 'Pesanan sudah diselesaikan', 'body': 'Pesanan sudah diambil/ diterima. Terima kasih sudah mempercayai BalloonBlooms sebagai hadiah buat orang tersayangmu.', 'date': '25-04-2023 03:47', 'type': 'Order', 'read': false},
    {'id': '3', 'title': 'Pesanan sudah siap dipick-up', 'body': 'Helloo, bloomers. Pesanan kamu sudah selesai dan bisa kamu pick-up di toko kami sekarang.', 'date': '24-04-2023 05:15', 'type': 'Order', 'read': false},
    {'id': '2', 'title': 'Flash Sale Lebaran', 'body': 'Hei, bloomers! Lebaran sudah semakin dekat. Gunakan kode promo LBRNTIBA22 dan dapatkan diskon 22% untuk semua produk BalloonBlooms.', 'date': '15-04-2023 23:59', 'type': 'Promosi', 'read': true},
    {'id': '1', 'title': 'Update baru tersedia', 'body': 'Perbarui aplikasi kamu ke versi terbaru agar aktivitas kamu saat scrolling semakin lancar.', 'date': '09-04-2023 15:28', 'type': 'Aplikasi', 'read': true},
    {'id': '0', 'title': 'BalloonBlooms', 'body': 'Selamat datang, bloomers! \nTerima kasih telah memilih BalloonBlooms sebagai sarana pembelanjaan Anda.', 'date': '02-03-2023 12:34', 'type': 'Promosi', 'read': false},
  ];

  set readNotif(id) {
    allNotif.firstWhere((notif) => notif['id']==id)['read'] = true;
    notifyListeners();
  }
}