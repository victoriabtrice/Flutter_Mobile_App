import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';

class ChooseBurger extends StatefulWidget {
  const ChooseBurger({super.key, required this.title});

  final String title;

  @override
  State<ChooseBurger> createState() => _ChooseBurgerState();
}

class _ChooseBurgerState extends State<ChooseBurger> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Text.rich(
                TextSpan(
                  text: 'ROTI ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '  *Wajib',
                      style: TextStyle(fontSize: 12, color: Colors.red)
                    )
                  ]
                ),
              ),
            ),
            Wrap(
              children: ['Atas', 'Bawah'].map((item) => 
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: myCustomColor()),
                    color: myCustomColor()[100],
                  ),
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(5),
                  width: MediaQuery.of(context).size.width/((MediaQuery.of(context).size.width/150).floor())-20,
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        'assets/Roti $item.png', 
                      ),
                      const SizedBox(width: 7,),
                      Text('Roti $item', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                      const Text('Rp. 3.000,-', style: TextStyle(fontSize: 13),),
                    ],
                  ),
                ),
              ).toList()
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
              child: Text.rich(
                TextSpan(
                  text: 'ISIAN ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: '  *Bebas Pilih',
                      style: TextStyle(fontSize: 12, color: Colors.green)
                    )
                  ]
                ),
              ),
            ),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              children: provBurger.burgerComponent.entries.map((component) {
                return GestureDetector(
                  onTap: () {
                    provBurger.chosenComponent = component.key;
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.8, color: component.value['on']? myCustomColor(): Colors.black54),
                      color: component.value['on']? myCustomColor()[100]: Colors.white,
                    ),
                    margin: const EdgeInsets.all(5),
                    padding: const EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width/((MediaQuery.of(context).size.width/150).floor())-20,
                    height: 140,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/${component.key}.png', 
                        ),
                        const SizedBox(width: 7,),
                        Text(component.key, style: TextStyle(fontWeight: component.value['on']? FontWeight.bold : null, fontSize: 17),),
                        Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(component.value["price"])},-', style: const TextStyle(fontSize: 13),),
                      ],
                    )
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}