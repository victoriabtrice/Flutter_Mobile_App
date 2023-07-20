import 'dart:math';
import 'package:intl/intl.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/officialmenu_provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/components/menu_card.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/components/stack_burger.dart';
import 'package:b_kreazi/pages/create_burger.dart';
import 'package:b_kreazi/pages/detail_burger.dart';
import 'package:b_kreazi/pages/all_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});

  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provCreation = Provider.of<CreationProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);
    final provMenu = Provider.of<OfficialMenuProvider>(context);
    final provOrder = Provider.of<OrderProvider>(context);

    randomRecommend() {
      List rekomen = [];
      for (var i = 0; i < (provMenu.allMenu.length/2.2).floor(); i++) {
        final random =  Random();
        var num = random.nextInt(provMenu.allMenu.length);
        if (rekomen.contains(provMenu.allMenu[num])) { i -= 1; }
        else { rekomen.add(provMenu.allMenu[num]); }
      }
      return rekomen;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CarouselSlider(
              options: CarouselOptions(
                enlargeCenterPage: true,
                initialPage: 2,
                aspectRatio: 3.4,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 400),
                viewportFraction: 0.835,
              ),
              items: [
                for (int i = 1; i < 4 ; i++)
                // n Image of Slider
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: AssetImage('assets/banner$i.png'),
                      fit: BoxFit.cover,
                    )
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15,),
            InkWell(
              onTap: () {
                provBurger.resetAll();
                provNav.orderState = 'Choose';
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: true,)));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: myCustomColor())
                ),
                child: Image.asset('assets/Kreazikan Banner.png', width: MediaQuery.of(context).size.width,)
              )
            ),
            const SizedBox(height: 20,),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 22),
                  child: Divider(),
                ),
                CircleAvatar(
                  radius: 30,
                  backgroundColor: myCustomColor(),
                  child: const Icon(Icons.emoji_events_rounded, color: Colors.black, size: 30,),
                )
              ],
            ),
            const SizedBox(height: 5,),
            const Center(child: Text('Kreazi Teratas #1 Minggu Ini', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)),
            const SizedBox(height: 8,),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.5, color: myCustomDarkerColor()),
                borderRadius: BorderRadius.circular(8),
                color: myCustomLighterColor()
              ),
              child: InkWell(
                onTap: () {
                  provBurger.resetAll();
                  provBurger.orderCreation = provCreation.topCreation();
                  provNav.orderState = 'Addition';
                  provOrder.quickOrder? 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: false,))) : 
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMenu(menu: provCreation.topCreation(),)));
                },
                child: Wrap(
                  alignment: WrapAlignment.center,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 15,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 8, 0, 8),
                      child: StackBurger(source: provCreation.topCreation(), padding: 8.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 5, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(provCreation.topCreation()['Name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                          Text('${provCreation.topCreation()['Creator']}', style: const TextStyle(fontSize: 17, color: Colors.black54),),
                          const SizedBox(height: 5,),
                          Text('Harga : ${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(provCreation.topCreation()['TtlPrice'])},-', style: const TextStyle(fontSize: 16),),
                          Text('Jumlah suka : ${provCreation.topCreation()['TtlLikes']}', style: const TextStyle(fontSize: 16),),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Text('Rekomendasi Untukmu', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17.5),),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllMenu(title: 'Menu Official',)));
                  }, 
                  child: const Text('Lihat Semua')
                )
              ],
            ),
            const SizedBox(height: 5,),
            MenuCard(product: randomRecommend())
          ],
        ),
      ),
    );
  }
}