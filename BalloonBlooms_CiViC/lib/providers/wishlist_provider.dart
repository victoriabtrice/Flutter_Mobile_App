import 'package:flutter/material.dart';

class WishlistProvider extends ChangeNotifier {
  final List _wishlist = ['DLB2921','FLW2923'];  // only store product code utk hemat memory (maybe)
  List get wishlist => _wishlist;

  set addWishlist(val) {
    _wishlist.add(val);
    notifyListeners();
  }
  set delWishlist(val) {
    _wishlist.remove(val);
    notifyListeners();
  }
}