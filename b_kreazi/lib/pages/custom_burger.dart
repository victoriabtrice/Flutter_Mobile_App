import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';

class CustomBurger extends StatefulWidget {
  const CustomBurger({super.key, required this.title});

  final String title;

  @override
  State<CustomBurger> createState() => _CustomBurgerState();
}

class _CustomBurgerState extends State<CustomBurger> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(padding: EdgeInsets.only(top: 20)),
                Padding(
                  padding: const EdgeInsets.only(right: 185),
                  child: Image.asset(
                    'assets/Roti Atas.png', 
                  ),
                ),
                Column(
                  children: provBurger.chosenComponent.entries.map((component) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/${component.key}.png', 
                          width: 180,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all()
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                splashRadius: 15,
                                onPressed: component.value['qty']>1? () {provBurger.minQty = component.key;provBurger.addFinal();} : null, 
                                icon: const Icon(Icons.remove)
                              ),
                              Text(component.value['qty'].toString(), style: const TextStyle(fontWeight: FontWeight.bold),),
                              IconButton(
                                splashRadius: 15,
                                onPressed: component.value['qty']<3? () {provBurger.addQty = component.key;provBurger.addFinal();} : null, 
                                icon: const Icon(Icons.add)
                              ),
                            ]
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          width: 90,
                          child: Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(component.value["price"])},-'),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 185),
                  child: Image.asset(
                    'assets/Roti Bawah.png', 
                  ),
                ),
                const SizedBox(height: 20,),
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          width: MediaQuery.of(context).size.width,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: myCustomLighterColor()
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Harga Burger :', style: TextStyle(fontSize: 17.5),),
              Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(provBurger.finalComponent['TtlPrice']-(provBurger.finalComponent.containsKey('Discount')?provBurger.finalComponent['Discount']:0))},-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19, backgroundColor: Colors.transparent),)
            ],
          )
        ),
      ],
    );
  }
}