import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/components/stack_burger.dart';
import 'package:b_kreazi/pages/create_burger.dart';
import 'package:b_kreazi/pages/detail_burger.dart';

class MenuCard extends StatefulWidget {
  const MenuCard({super.key, required this.product});
  final List product;

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  Widget _buildCard(produk, provBurger, provNav, provOrder) => GridView.extent(
    maxCrossAxisExtent: 250,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    childAspectRatio: 2/2.7,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    children: _buildGridTileList(produk, provBurger, provNav, provOrder)
  );
  List<Card> _buildGridTileList(List products, provBurger, provNav, provOrder) => List.generate(
    products.length, (i) => Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          provBurger.resetAll();
          provBurger.orderCreation = products[i];
          provNav.orderState = 'Addition';
          provOrder.quickOrder? 
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: false,))) : 
            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailMenu(menu: products[i],)));
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: LayoutBuilder(   // biar ukuran ikut mamak
                      builder: (BuildContext context, BoxConstraints constraints) {
                        double padding = 15;
                        if (products[i]['TtlQty'] > 4) {
                          padding = (constraints.maxHeight-55)/products[i]['TtlQty'];
                          if (padding > 15.5) {
                            padding = 15.5;
                          }
                        }
                        return StackBurger(source: products[i], padding: padding, width: (constraints.maxHeight/products[i]['TtlQty'])*5);
                      }
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('${products[i]['Name']}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text(
                        '${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(products[i]['TtlPrice'])},-', 
                        style: const TextStyle(fontSize: 13, color: Colors.grey, decoration: TextDecoration.lineThrough),
                      ),
                      Text(
                        '${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(products[i]['TtlPrice']-products[i]["Discount"])},-', 
                        style: const TextStyle(fontSize: 16, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    )
  );
  
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);
    final provOrder = Provider.of<OrderProvider>(context);

    return _buildCard(widget.product, provBurger, provNav, provOrder);
  }
}