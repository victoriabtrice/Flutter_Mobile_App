import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/components/stack_burger.dart';
import 'package:b_kreazi/pages/create_burger.dart';
import 'package:b_kreazi/pages/detail_burger.dart';

class CreationCard extends StatefulWidget {
  const CreationCard({super.key, required this.product, required this.provider});
  final List product;
  final CreationProvider provider;

  @override
  State<CreationCard> createState() => _CreationCardState();
}

class _CreationCardState extends State<CreationCard> {
  Widget _buildCard(produk, provider, provBurger, provNav, provOrder) => GridView.extent(
    maxCrossAxisExtent: 250,
    mainAxisSpacing: 7,
    crossAxisSpacing: 7,
    childAspectRatio: 2/2.8,
    shrinkWrap: true,
    children: _buildGridTileList(produk, provider, provBurger, provNav, provOrder)
  );
  List<Widget> _buildGridTileList(List products, CreationProvider provider, BurgerProvider provBurger, NavigationProvider provNav, OrderProvider provOrder) => List.generate(
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
        onLongPress: provider.myCreation.toString().contains(products[i].toString())? () {
          showModalBottomSheet(
            enableDrag: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
            ),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width*0.8
            ),
            context: context, 
            builder: (BuildContext bsContext) {
              return Wrap(
                children: [
                  if (provider.allCreations.toString().contains(products[i].toString()))
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (BuildContext dialogContext) {
                            return AlertDialog(
                              title: const Text('Peringatan!', style: TextStyle(fontWeight: FontWeight.bold)),
                              content: const Text('Dengan ini, Anda tidak dapat lagi mengembalikan Kreazi agar terlihat secara Publik dan jika ada orang lain yang memposting Kreazi yang sama (persis) dengan Kreazi ini, Anda juga tidak dapat melakukan komplain.', textAlign: TextAlign.justify,),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(dialogContext);
                                  }, 
                                  child: const Text('Batal', style: TextStyle(color: Colors.grey),)
                                ),
                                TextButton(
                                  onPressed: () {
                                    provider.delCreation = products[i];
                                    Navigator.pop(dialogContext);
                                    Navigator.pop(bsContext);
                                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        duration: const Duration(seconds: 5),
                                        content: const Text('Kreazi berhasil dihapus untuk Publik'),
                                        action: SnackBarAction(
                                          label: 'OK',
                                          textColor: Colors.white,
                                          onPressed: () {
                                            ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          },
                                        ),
                                      )
                                    );
                                  }, 
                                  child: const Text('Ya, hapus saja')
                                )
                              ],
                            );
                          }
                        );
                      },
                      child: const Center(child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Text('Hapus untuk Publik', style: TextStyle(fontSize: 17),),
                      ))
                    ),
                  TextButton(
                    onPressed: () {
                      showDialog(
                        context: context, 
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: const Text('Konfirmasi Penghapusan Postingan', style: TextStyle(fontWeight: FontWeight.bold)),
                            content: const Text('Apakah Anda yakin akan menghapus postingan ini secara permanen (termasuk Publik jika masih ada)?', textAlign: TextAlign.justify,),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(dialogContext);
                                }, 
                                child: const Text('Batal', style: TextStyle(color: Colors.grey),)
                              ),
                              TextButton(
                                onPressed: () {
                                  provider.delMyCreation = products[i];
                                  Navigator.pop(dialogContext);
                                  Navigator.pop(bsContext);
                                  ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                                    SnackBar(
                                      behavior: SnackBarBehavior.floating,
                                      duration: const Duration(seconds: 5),
                                      content: const Text('Kreazi berhasil dihapus secara permanen'),
                                      action: SnackBarAction(
                                        label: 'OK',
                                        textColor: Colors.white,
                                        onPressed: () {
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                        },
                                      ),
                                    )
                                  );
                                }, 
                                child: const Text('Ya')
                              )
                            ],
                          );
                        }
                      );
                    },
                    child: const Center(child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Hapus Permanen', style: TextStyle(fontSize: 17),),
                    ))
                  ),
                  TextButton(
                    onPressed: () {Navigator.pop(bsContext);}, 
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Center(child: Text('Batal', style: TextStyle(color: Colors.red, fontSize: 16),)),
                    )
                  ),
                ],
              );
            }
          );
        } : null,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: LayoutBuilder(   // biar ukuran ikut mamak
                      builder: (BuildContext context, BoxConstraints constraints) {
                        // return StackBurger(source: products[i], padding: 15,);
                        double padding = 15;
                        if (products[i]['TtlQty'] > 4) {
                          padding = (constraints.maxHeight-55)/products[i]['TtlQty'];
                          if (padding > 15.5) {
                            padding = 15.5;
                          }
                        }
                        return StackBurger(source: products[i], padding: padding, width: (constraints.maxHeight/products[i]['TtlQty'])*6);
                      }
                    ),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text('${products[i]['Name']}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text('by : ${products[i]['Creator']}', overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 17),)
                      ),
                      products[i]['liked']?
                        IconButton(
                          splashRadius: 1,
                          tooltip: 'Liked by ${products[i]['TtlLikes']}',
                          onPressed: () {provider.unliked = products[i]['Name'];},   // utk unlike krn skrg msh like
                          icon : const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 32,)
                        ) :
                        IconButton(
                          splashRadius: 1,
                          tooltip: 'Liked by ${products[i]['TtlLikes']}',
                          onPressed: () {provider.liked = products[i]['Name'];},   // utk like krn skrg msh unlike
                          icon : const Icon(Icons.local_fire_department_outlined, size: 32,),
                        )
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

    return _buildCard(widget.product, widget.provider, provBurger, provNav, provOrder);
  }
}