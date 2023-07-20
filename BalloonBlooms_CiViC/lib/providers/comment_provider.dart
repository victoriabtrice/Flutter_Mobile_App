import 'package:flutter/material.dart';

class CommentProvider extends ChangeNotifier {
  TextEditingController nama = TextEditingController();
  TextEditingController komentar = TextEditingController();
  String status = 'new';

  final List<Map> _comments = [
    {'kode_produk':'NDF2922', 'nama':'Akhmad', 'komentar':'Request angpaonya isi duit bisa kali yak', 'tgl':'06-04-2022 15:30'},
    {'kode_produk':'MNC2920', 'nama':'Beatrice', 'komentar':'It`s so pretty. I love it', 'tgl':'01-08-2022 20:12'},
    {'kode_produk':'FLD2925', 'nama':'Cindy', 'komentar':'Temenku bilang hadiahnya cantik banget. Makasih kak.', 'tgl':'12-09-2022 12:09'},
    {'kode_produk':'MNC2920', 'nama':'Dita', 'komentar':'Minimal butuh berapa lembar uang supaya bisa disusun 3 tingkat min?', 'tgl':'28-12-2022 23:59'},
    {'kode_produk':'DLB2921', 'nama':'Enzy', 'komentar':'Cocok banget buat hadiah wisuda', 'tgl':'07-01-2023 09:10'},
    {'kode_produk':'SNA2921', 'nama':'Felly', 'komentar':'Bagus bangett. Andai bisa dikirim ke Kalimantan TT', 'tgl':'19-02-2023 17:44'},
    {'kode_produk':'SNA2921', 'nama':'Gonzales', 'komentar':'Warna Goldnya ready kah?', 'tgl':'22-04-2023 05:38'},
  ];
  List<Map> get comments => _comments;

  clearInput() {
    nama.text = '';
    komentar.text = '';
    status = 'new';
    notifyListeners();
  }

  set addComment(val) {
    if (nama.text.trim().isNotEmpty && komentar.text.trim().isNotEmpty) {
      _comments.add(val);
      clearInput();
    }
    else {
      status = 'invalid';
    }
    notifyListeners();
  }
  
  ScrollController scrollCtrl = ScrollController();
}