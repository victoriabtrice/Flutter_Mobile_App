import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/wishlist_provider.dart';
import 'package:baloonblooms/screens/minggu7.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.product});
  final List product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  Widget _buildCard(produk, provWishlist) => GridView.extent(
    maxCrossAxisExtent: 260,
    padding: const EdgeInsets.all(4),
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    childAspectRatio: 2/2.8,
    children: _buildGridTileList(produk, provWishlist)
  );
  List<Card> _buildGridTileList(List products, WishlistProvider provWishlist) => List.generate(
    // products.length, (i) => Container(
    //   decoration: BoxDecoration(
    //     border: Border.all(width: 0.5),
    //     borderRadius: const BorderRadius.all(Radius.circular(5))
    //   ),
    products.length, (i) => Card(
      elevation: 3,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProduct(product: products[i]))),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: LayoutBuilder(   // biar ukuran ikut parent
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Image.asset(
                      'assets/${products[i]['code']}.jpg', 
                      width: constraints.maxWidth,
                      height: constraints.maxWidth*1.1, 
                      fit: BoxFit.cover
                    );
                  }
                ),
              ),
              const Padding(padding: EdgeInsets.all(2.5)),
              Text('${products[i]['name']}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
              Stack(
                children: [
                  Text('Rp. ${products[i]['price']~/1000}.000,-', style: const TextStyle(fontSize: 16),),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Align(
                      alignment: Alignment.bottomRight, 
                      child: provWishlist.wishlist.any((element) => element==products[i]['code'])?
                        // kode produk cocok dgn salah satu aja value product code di wishlist
                        IconButton(
                          splashRadius: 1,
                          tooltip: 'Hapus dari Wishlist',
                          onPressed: () {provWishlist.delWishlist = products[i]['code'];},   // utk unlike krn skrg msh like
                          icon : const Icon(Icons.favorite_rounded, color: Colors.red, size: 28,)
                        ) :
                        IconButton(
                          splashRadius: 1,
                          tooltip: 'Tambahkan ke Wishlist',
                          onPressed: () {provWishlist.addWishlist = products[i]['code'];},   // utk like krn skrg msh unlike
                          icon : const Icon(Icons.favorite_border_rounded, size: 28,),
                        )
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      )
    )
  );
  
  @override
  Widget build(BuildContext context) {
    final provWishlist = Provider.of<WishlistProvider>(context);
    
    return _buildCard(widget.product, provWishlist);
  }
}