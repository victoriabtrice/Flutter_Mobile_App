import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/officialmenu_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/components/menu_card.dart';

class AllMenu extends StatefulWidget {
  const AllMenu({super.key, required this.title});

  final String title;

  @override
  State<AllMenu> createState() => _AllMenuState();
}

class _AllMenuState extends State<AllMenu> {
  bool searchMenu = false;
  String searchVal = '';
  TextEditingController searchCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final provMenu = Provider.of<OfficialMenuProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: !searchMenu? Text(widget.title) : Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.5, color: myCustomDarkerColor()),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextField(
            controller: searchCtrl,
            autofocus: true,
            onChanged: (val) {
              setState(() {
                searchVal = '';                  
              });
            },
            onSubmitted: (val) {
              setState(() {
                searchVal = val.trim().toLowerCase();
              });
            },
            decoration: InputDecoration(
              icon: const Icon(Icons.search_rounded),
              suffixIcon: searchCtrl.text.isEmpty? null : 
                IconButton(icon: const Icon(Icons.clear_rounded), 
                  splashRadius: 5,
                  onPressed: () {
                    setState(() {
                      searchCtrl.text = '';
                      searchVal = '';
                    });
                  },
                ),
              border: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: 'Cari Menu ...',
              hintStyle: const TextStyle(fontSize: 18),
            ),
            style: const TextStyle(fontSize: 17),
          ),
        ),
        actions: [
          if (!searchMenu)
            IconButton(
              tooltip: 'Cari Menu',
              onPressed: () {
                setState(() {
                  searchMenu = !searchMenu;
                });
              }, 
              icon: const Icon(Icons.search_rounded)
            ),
          const SizedBox(width: 10,)
        ],
      ),
      body: provMenu.allMenu.where((menu) => menu['Name'].toLowerCase().contains(searchVal) || menu['Burger'].keys.toString().toLowerCase().contains(searchVal)).isEmpty? 
        Center(
          child: Text('Menu "$searchVal" tidak ditemukan', style: const TextStyle(fontSize: 16.5),),
        )
      : 
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: MenuCard(product: provMenu.allMenu.where((menu) => menu['Name'].toLowerCase().contains(searchVal) || menu['Burger'].keys.toString().toLowerCase().contains(searchVal)).toList()),
          ),
        ),
    );
  }
}