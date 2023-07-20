import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/wishlist_provider.dart';
import 'package:baloonblooms/providers/custom_provider.dart';
import 'package:baloonblooms/providers/login_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';
import 'package:baloonblooms/screens/minggu3.dart';
import 'package:baloonblooms/screens/image.dart';
import 'package:baloonblooms/screens/custom.dart';

class DetailProduct extends StatefulWidget {
  const DetailProduct({super.key, required this.product});
  final Map product;

  @override
  State<DetailProduct> createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  
  @override
  Widget build(BuildContext context) {
    final provWishlist = context.watch<WishlistProvider>();
    final provCustom = context.watch<CustomProvider>();
    final provLogin = context.watch<LoginProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Produk'),
        actions: [
          IconButton(
            splashRadius: 15,
            onPressed: () {
              showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Info', style: TextStyle(fontWeight: FontWeight.bold),),
                    content: const Text('Harga tertera hanyalah estimasi. Penambahan aksesoris lain yang belum include didalam produk akan dikenakan biaya tambahan.'),
                    actions: [
                      TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('OK'))
                    ],
                  );
                }
              );
            }, 
            icon: const Icon(Icons.info_outline, size: 28,)
          ),
          const SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(img: widget.product['code'])));
              },
              child: Image.asset(
                'assets/${widget.product['code']}.jpg', 
                width: MediaQuery.of(context).size.width, 
                height: MediaQuery.of(context).size.width, 
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.7, child: Text(widget.product['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)),
                      provWishlist.wishlist.any((element) => element==widget.product['code'])?
                        // kode produk cocok dgn salah satu aja value product code di wishlist  TT
                        IconButton(
                          splashRadius: 15,
                          tooltip: 'Hapus dari Wishlist',
                          onPressed: () {provWishlist.delWishlist = widget.product['code'];},   // utk unlike krn skrg msh like
                          icon : const Icon(Icons.favorite_rounded, color: Colors.red, size: 32,)
                        ) :
                        IconButton(
                          splashRadius: 15,
                          tooltip: 'Tambahkan ke Wishlist',
                          onPressed: () {provWishlist.addWishlist = widget.product['code'];},   // utk like krn skrg msh unlike
                          icon : const Icon(Icons.favorite_border_rounded, size: 32,),
                        )
                    ],
                  ),
                  Text('Rp. ${widget.product['price']~/1000}.000,-', style: const TextStyle(fontSize: 20),),
                  const Divider(thickness: 1.5,),
                  const Text('Include', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  const SizedBox(height: 5,),
                  for (var inc in widget.product['include']) 
                    Padding(
                      padding: const EdgeInsets.fromLTRB(6, 0, 0, 7),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(0, 2, 6, 0),
                            child: Icon(Icons.star_rounded, size: 17,),
                          ),
                          SizedBox(width: MediaQuery.of(context).size.width*0.8, child: Text(inc, style: const TextStyle(fontSize: 18),))
                        ],
                      ),
                    ),
                ]
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ProductComment(title: 'Comment', product: widget.product['code'])));
        },
        tooltip: 'Komentar',
        backgroundColor: myCustomColor(),
        child: const Icon(Icons.comment_outlined),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(5),
        height: 45,
        elevation: 5,
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => CustomProduct(reference: widget.product)));
            provCustom.resetAll();
            provLogin.resetField();
          },
          child: const Text('CUSTOM NOW', style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}