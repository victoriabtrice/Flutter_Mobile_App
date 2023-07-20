import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/components/stack_burger.dart';

class FinalBurger extends StatefulWidget {
  const FinalBurger({super.key, required this.title, required this.back});

  final String title;
  final bool back;

  @override
  State<FinalBurger> createState() => _FinalBurgerState();
}

class _FinalBurgerState extends State<FinalBurger> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text('Burger', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  StackBurger(source: provBurger.finalComponent, padding: 17.5,),
                  const Divider(height: 25,),
                  const Text('Tambahan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: provBurger.additional.entries.map((additional) {
                      return Column(
                        children: [
                          CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            value: additional.value['on'], 
                            title: Text.rich(
                              TextSpan(
                                text: additional.key,
                                children: [
                                  TextSpan(
                                    text: provBurger.finalAddition.isNotEmpty && provBurger.finalAddition.containsKey(additional.key) && provBurger.finalAddition[additional.key].isEmpty? '    *Wajib pilih salah satu/ minimal satu' : null,
                                    style: const TextStyle(color: Colors.red, fontSize: 11)
                                  )
                                ]
                              ),
                            ),
                            onChanged: (val) {
                              provBurger.additional = [additional.key, val];
                            }
                          ),
                          Visibility(
                            visible: additional.value['on'],
                            child: Padding(
                              padding: const EdgeInsets.only(left: 25, right: 10),
                              child: Wrap(
                                alignment: WrapAlignment.spaceEvenly,
                                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: additional.value['option'].entries.map<Widget>((option) {
                                    return additional.key=='Kentang Goreng'? 
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 5),
                                        child: ChoiceChip(
                                          label: Text(option.value? '${option.key} +${additional.value['price'][option.key]~/1000}.000' : option.key),
                                          selected: option.value,
                                          selectedColor: myCustomColor()[700],
                                          onSelected: (val) {
                                            provBurger.option = ['Kentang Goreng', option.key, val];
                                            provBurger.addAddition();
                                          },
                                        ),
                                      ) :
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 5),
                                        child: FilterChip(
                                          label: Text(option.value? '${option.key} +${additional.value['price'][option.key]~/1000}.000' : option.key), 
                                          selected: option.value,
                                          selectedColor: myCustomColor()[700],
                                          onSelected: (val) {
                                            provBurger.option = [additional.key, option.key, val];
                                            provBurger.addAddition();
                                          },
                                        ),
                                      );
                                  }).toList(),
                              ),
                            )
                          )
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 8,),
                  const Divider(height: 25,),
                  const Text('Level Kepedasan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('0'),
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.7,
                        child: Slider(
                          min: 0, max: 4, divisions: 4,
                          value: provBurger.spicy.toDouble(),
                          label: provBurger.spicyLevel[provBurger.spicy],
                          onChanged: (val) => provBurger.spicy = val.toInt()
                        ),
                      ),
                      const Text('4'),
                    ],
                  ),
                  Text(provBurger.spicyLevel[provBurger.spicy]),
                  const SizedBox(height: 5,),
                  const Divider(),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                    child: Text('Catatan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                    child: TextField(
                      controller: provBurger.note,
                      maxLines: 3,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                        hintText: '(Opsional) Tambahkan catatan terkait pesanan Anda disini ...'
                      ),
                    ),
                  ),
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
              const Text('Total Harga :', style: TextStyle(fontSize: 17.5),),
              Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(provBurger.myOrder(provLogin.username.text)['FinalPrice'])},-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19, backgroundColor: Colors.transparent),)
            ],
          )
        ),
      ],
    );
  }
}