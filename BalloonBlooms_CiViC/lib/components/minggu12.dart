import 'package:flutter/material.dart';
import 'package:baloonblooms/providers/wishlist_provider.dart';
import 'package:baloonblooms/screens/minggu7.dart';

class WishlistCard extends StatefulWidget {
  const WishlistCard({super.key, required this.product, required this.provWishlist});

  final Map product;
  final WishlistProvider provWishlist;

  @override
  State<WishlistCard> createState() => _WishlistCardState();
}

class _WishlistCardState extends State<WishlistCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProduct(product: widget.product)));
        },
        contentPadding: const EdgeInsets.all(6),
        leading: Image.asset(
          'assets/${widget.product['code']}.jpg',
          width: 60,
          fit: BoxFit.cover,
        ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Text('${widget.product['name']}', style: const TextStyle(fontWeight: FontWeight.bold),),
        ),
        subtitle: Text('Include : ${widget.product['include'].join(', ')}'),
        trailing: IconButton(
          splashRadius: 15,
          onPressed: () {
            widget.provWishlist.delWishlist = widget.product['code'];
          },
          icon: const Icon(Icons.heart_broken, color: Colors.red,)
        ),
      ),
    );
  }
}