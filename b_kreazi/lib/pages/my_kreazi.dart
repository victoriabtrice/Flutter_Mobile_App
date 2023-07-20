import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/components/creation_card.dart';
import 'package:b_kreazi/pages/create_burger.dart';

class MyKreazi extends StatefulWidget {
  const MyKreazi({super.key});

  @override
  State<MyKreazi> createState() => _MyKreaziState();
}

class _MyKreaziState extends State<MyKreazi> {
  @override
  Widget build(BuildContext context) {
    final provCreation = Provider.of<CreationProvider>(context);
    final provBurger = Provider.of<BurgerProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);
    final allKreazi = provCreation.myCreation + provCreation.allCreations;
    final unique = allKreazi.map((kreazi) => kreazi['Name']).toSet();
    allKreazi.retainWhere((val) => unique.remove(val['Name']));

    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kreazi-ku'),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(child: Text('Kreazi-ku', textAlign: TextAlign.center,),),
              Tab(child: Text('Favorit-ku', textAlign: TextAlign.center,),),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            provCreation.myCreation.isEmpty? 
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Idea.png', width: 180,),
                    const SizedBox(height: 15,),
                    const Text('Kamu belum ber-Kreazi', style: TextStyle(fontSize: 17),),
                  ],
                ),
              ) :
              Padding(
                padding: const EdgeInsets.all(10),
                child: CreationCard(product: provCreation.myCreation, provider: provCreation),
              ),
            allKreazi.where((creation) => creation['liked']).isEmpty?
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Favorite.png', width: 200,),
                    const SizedBox(height: 15,),
                    const Text('Belum ada Kreazi yang kamu sukai', style: TextStyle(fontSize: 17),),
                  ],
                ),
              ) :
              Padding(
                padding: const EdgeInsets.all(10),
                child: CreationCard(product: allKreazi.where((creation) => creation['liked'],).toList(), provider: provCreation),
              )
          ]
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            provBurger.resetAll();
            provNav.orderState = 'Choose';
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: true,)));
          },
          backgroundColor: myCustomColor(),
          tooltip: 'Posting Kreazi',
          child: const Icon(Icons.add_rounded),
        ),
      )
    );
  }
}