import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/product_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';
import 'package:baloonblooms/components/minggu10.dart';
import 'package:baloonblooms/components/minggu15.dart';
import 'package:baloonblooms/screens/recommend.dart';
import 'package:baloonblooms/screens/minggu7.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final provProduk = Provider.of<ProductProvider>(context);
    final rekomendasi = provProduk.randomRecommend();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const UpdateAvailable(),
            const CarouselHome(),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Ide Balon Populer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Recommendation(title: 'Recommendation', product: rekomendasi)));
                  }, 
                  child: const Text('Lihat Semua')
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 10, 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: 
                    rekomendasi.sublist(0, (rekomendasi.length*0.8).floor()).map<Widget>((produk) =>
                      Container(
                        margin: const EdgeInsets.all(5),
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.width*0.5,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5),
                          borderRadius: const BorderRadius.all(Radius.circular(5))
                        ),
                        child: InkWell(
                          onTap: () {
                            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailProduct(product: produk)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(6.5, 6.5, 6.5, 3),
                            child: Column(
                              children: [
                                Flexible(
                                  child: LayoutBuilder(   // biar ukuran ikut mamak
                                    builder: (BuildContext context, BoxConstraints constraints) {
                                      return Image.asset(
                                        'assets/${produk['code']}.jpg',
                                        width: constraints.maxWidth,
                                        height: constraints.maxWidth*1.1, 
                                        fit: BoxFit.cover
                                      );
                                    }
                                  ),
                                ),
                                const SizedBox(height: 5,),
                                Text(produk['name'], 
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ).toList()
                  ,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text('Testimoni', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                IconButton(
                  splashRadius: 10,
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.all(5),
                        backgroundColor: Color.fromARGB(255, 152, 90, 105),
                        content: Text('Untuk selengkapnya, tersedia di halaman Feedback.')
                      )
                    );
      
                  }, 
                  icon: const Icon(Icons.info_outline_rounded, size: 20,)
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      const Divider(),
                      CircleAvatar(
                        backgroundColor: myCustomColor()[600],
                        radius: 35,
                        // child: const Icon(Icons.local_florist_rounded, color: Colors.black87, size: 32,),
                        child: Image.asset('assets/flower.png', width: 28,),
                      )
                    ],
                  ),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '`` ',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23)
                        ),
                        TextSpan(
                          text: 'BalloonBlooms sudah menjadi kepercayaan kami untuk urusan hampers, baik untuk hadiah grand-opening, hampers hari raya, hadiah hari guru, dan masih banyak lagi acara lainnya.\nTerima kasih BalloonBlooms telah menyediakan hampers terbaik bagi para Bloomers.',
                          style: TextStyle(fontSize: 16, color: Colors.black87)
                        ),
                        TextSpan(
                          text: ' , ,',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
                        ),
                      ]
                    ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}