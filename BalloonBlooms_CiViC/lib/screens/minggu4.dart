import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/product_provider.dart';
import 'package:baloonblooms/providers/wishlist_provider.dart';
import 'package:baloonblooms/components/minggu12.dart';
import 'package:baloonblooms/screens/recommend.dart';

class Wishlist extends StatefulWidget {
  const Wishlist({super.key, required this.title});
  final String title;

  @override
  State<Wishlist> createState() => _WishlistState();
}

class _WishlistState extends State<Wishlist> {

  @override
  Widget build(BuildContext context) {
    final provProduk = context.watch<ProductProvider>();
    final provWishlist = context.watch<WishlistProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: provWishlist.wishlist.isEmpty? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Wishlist mu masih kosong nih'),
              const SizedBox(height: 8,),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Recommendation(title: 'Recommendation', product: provProduk.randomRecommend())));
                }, 
                child: const Text('Cek Rekomendasi')
              ),
            ],
          ),
        ) : 
        ListView(
          children: provWishlist.wishlist.map((item) {
            // cari detail lengkap produk wishlist yg ada di provider dgn kunci product code
            Map product = provProduk.products.firstWhere((produk) => produk.values.contains(item));
            return WishlistCard(product: product, provWishlist: provWishlist,);
          }).toList(),
        ),
      )
    );
  }
}