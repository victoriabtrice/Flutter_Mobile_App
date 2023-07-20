import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';

class ChooseBurger extends StatefulWidget {
  const ChooseBurger({super.key, required this.title, required this.back});

  final String title;
  final bool back;

  @override
  State<ChooseBurger> createState() => _ChooseBurgerState();
}

class _ChooseBurgerState extends State<ChooseBurger> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);

    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.only(top: 20)),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Image.asset(
                'assets/Roti Atas.png', 
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: provBurger.burgerComponent.entries.map((component) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Image.asset(
                        'assets/${component.key}.png', 
                        color: component.value['on']? null : Colors.black26,
                      ),
                    ),
                    const SizedBox(width: 5,),
                    SizedBox(
                      width: 90, 
                      child: Column(
                        children: [
                          Text(component.key, style: TextStyle(fontWeight: component.value['on']? FontWeight.bold : null, fontSize: 17),),
                          Text('Rp. ${component.value['price'].toString()},-', style: const TextStyle(fontSize: 12),),
                        ],
                      )
                    ),
                    Switch(
                      value: component.value['on'], 
                      onChanged: (val) {
                        // provBurger.changeComponent = [component.key, val];
                        provBurger.chosenComponent = component.key;
                      },
                      activeColor: myCustomColor(),
                      activeTrackColor: myCustomColor()[200],
                    ),
                  ],
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 150),
              child: Image.asset(
                'assets/Roti Bawah.png', 
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Peringatan!', style: TextStyle(fontWeight: FontWeight.bold),),
                            content: const Text('Kamu akan kehilangan semua progres kustomisasi yang telah kamu lakukan. Yakin ingin kembali?'),
                            actions: [
                              TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Batal', style: TextStyle(color: Colors.grey),)),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                  provNav.orderState = 'Choose';
                                  provBurger.resetComponent();
                                  provBurger.resetChoosen();
                                  provBurger.resetFinal();
                                },
                                child: const Text('Ya')
                              )
                            ],
                          );
                        }
                      );
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // provBurger.addChosenComponent();
                      provNav.orderState = 'Custom';
                    },
                    child: const Text('Lanjut: Kustom bahan'),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}