import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/components/order_card.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key, required this.title});

  final String title;

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  @override
  Widget build(BuildContext context) {
    final provOrder = Provider.of<OrderProvider>(context);
    
    return provOrder.myOrder.isNotEmpty? ListView(
      children: [
        if (provOrder.myOrder.where((order) => order['Order']['Status']!='Sudah di Pick-Up').isNotEmpty)
          OrderCard(status: 'Sedang berlangsung', orderList: provOrder.myOrder.where((order) => order['Order']['Status']!='Sudah di Pick-Up').toList()),
        OrderCard(status: 'Sudah selesai', orderList: provOrder.myOrder.where((order) => order['Order']['Status']=='Sudah di Pick-Up').toList()),
      ]
    ) : 
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/no-order.png', width: 200,),
          const SizedBox(height: 15,),
          const Text('Belum ada pesanan.\n Yuk buat pesanan pertamamu sekarang!', textAlign: TextAlign.center, style: TextStyle(fontSize: 20),),
        ],
      ),
    );
  }
}