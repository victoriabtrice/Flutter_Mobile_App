import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/components/stack_burger.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/pages/create_burger.dart';
import 'package:b_kreazi/pages/detail_order.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.status, required this.orderList});

  final String status;
  final List orderList;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);

    List orderList = widget.orderList.where((order) => order['Username'].isEmpty).toList();
    if (provLogin.isLoggedIn) {
      orderList = widget.orderList.where((order) => (order['Username'].isEmpty || order['Username'] == provLogin.username.text)).toList();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 10, 0, 8),
          child: Text(widget.status, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
        for (var order in orderList)
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
            child: Card(
              clipBehavior: Clip.antiAlias,
              color: myCustomLighterColor(),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderDetail(order: order)));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: myCustomColor()[100]
                      ),
                      // padding: const EdgeInsets.all(8),
                      margin: const EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width*0.98,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(12, 10, 10, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(child: Text(order['Contact']['Waktu'], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),)),
                            Text(widget.status=='Sudah selesai'? '' : order['Order']['Status'], style: const TextStyle(color: Colors.black54, fontSize: 13),),
                          ],
                        ),
                      ),
                    ),
                    Wrap(
                      alignment: WrapAlignment.spaceEvenly,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SizedBox(width: MediaQuery.of(context).size.width*0.25, child: StackBurger(source: order, padding: 12,)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width*0.55,
                          child: Table(
                            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                            columnWidths: const {
                              0: IntrinsicColumnWidth(),
                              1: IntrinsicColumnWidth(),
                            },
                            children: [
                              TableRow(
                                children: [
                                  const Text('Nama Pemesan'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    child: Text(':'),
                                  ),
                                  Text(order['Contact']['Nama'], style: const TextStyle(fontSize: 16),)
                                ]
                              ),
                              TableRow(
                                children: [
                                  const Text('Nama Burger'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    child: Text(':'),
                                  ),
                                  Text(order['Name'], style: const TextStyle(fontSize: 16),)
                                ]
                              ),
                              TableRow(
                                children: [
                                  const Text('Waktu Pick-Up'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    child: Text(':'),
                                  ),
                                  Text(order['Contact']['Pick Up'], style: const TextStyle(fontSize: 16),)
                                ]
                              ),
                              TableRow(
                                children: [
                                  const Text('Metode Bayar'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    child: Text(':'),
                                  ),
                                  Text(order['Contact']['Pembayaran'], style: const TextStyle(fontSize: 16),)
                                ]
                              ),
                              TableRow(
                                children: [
                                  const Text('Total Harga'),
                                  const Padding(
                                    padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                                    child: Text(':'),
                                  ),
                                  Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(order["FinalPrice"])},-', style: const TextStyle(fontSize: 16),)
                                ]
                              ),
                            ],
                          )
                        )
                      ],
                    ),
                    order['Order']['Status'] == 'Sudah di Pick-Up'? 
                      SizedBox(
                        width: MediaQuery.of(context).size.width*0.98,
                        child: TextButton(
                          onPressed: () {
                            provBurger.resetAll();
                            provBurger.orderCreation = order;
                            provBurger.reOrderAdditional = order['Addition'];
                            provBurger.spicy = provBurger.spicyLevel.indexOf(order['Spicy']);
                            provBurger.note.text = order['Note'];
                            provNav.orderState = 'Addition';
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: false)));
                          },
                          child: Text('PESAN LAGI', style: TextStyle(color: myCustomDarkerColor(), fontSize: 16, fontWeight: FontWeight.bold),),
                        ),
                      ) : const SizedBox(height: 8,),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}