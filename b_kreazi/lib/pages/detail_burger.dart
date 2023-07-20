import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/pages/create_burger.dart';
import 'package:b_kreazi/components/stack_burger.dart';

class DetailMenu extends StatefulWidget {
  const DetailMenu({super.key, required this.menu});

  final Map menu;

  @override
  State<DetailMenu> createState() => _DetailMenuState();
}

class _DetailMenuState extends State<DetailMenu> {
  @override
  Widget build(BuildContext context) {
    final provCreation = Provider.of<CreationProvider>(context);
    final provBurger = Provider.of<BurgerProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Menu'),
        actions: provCreation.myCreation.toString().contains(widget.menu.toString())? [
          PopupMenuButton(
            itemBuilder: (BuildContext context) {
              return <PopupMenuEntry> [
                if (provCreation.allCreations.toString().contains(widget.menu.toString()))
                PopupMenuItem(
                  onTap: () async {
                    await Future.delayed(
                      Duration.zero, () {
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
                                    provCreation.delCreation = widget.menu;
                                    Navigator.pop(dialogContext);
                                    Navigator.pop(context);
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
                      }
                    );
                  },
                  child: const Text('Hapus untuk Publik')
                ),
                PopupMenuItem(
                  onTap: () async {
                    await Future.delayed(
                      Duration.zero, () {
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
                                    provCreation.delMyCreation = widget.menu;
                                    Navigator.pop(dialogContext);
                                    Navigator.pop(context);
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
                      }
                    );
                  },
                  child: const Text('Hapus Permanen')
                ),
              ];
            }
          )
        ] : []
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                StackBurger(source: widget.menu, padding: 15),
                const SizedBox(height: 10,),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.menu['Name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                              const SizedBox(height: 5,),
                              Text('by: ${widget.menu['Creator']}', style: const TextStyle(fontSize: 18),),
                            ],
                          ),
                          widget.menu.containsKey('liked')?
                            Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 17),
                                  child: widget.menu['liked']?
                                    IconButton(
                                      splashRadius: 1,
                                      tooltip: 'Liked by ${widget.menu['TtlLikes']}',
                                      onPressed: () {provCreation.unliked = widget.menu['Name'];},   // utk unlike krn skrg msh like
                                      icon : const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 35,)
                                    ) :
                                    IconButton(
                                      splashRadius: 1,
                                      tooltip: 'Liked by ${widget.menu['TtlLikes']}',
                                      onPressed: () {provCreation.liked = widget.menu['Name'];},   // utk like krn skrg msh unlike
                                      icon : const Icon(Icons.local_fire_department_outlined, size: 35,),
                                    ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.5),
                                  child: Text(widget.menu['TtlLikes'].toString(), style: const TextStyle(fontSize: 16)),
                                )
                              ],
                            )
                          :
                            const Padding(
                              padding: EdgeInsets.only(right: 5),
                              child: Icon(Icons.verified, color: Colors.blue, size: 30,),
                            )
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(width: 0.5),
                  ),
                  child: Column(
                    children: [
                      const Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(  // ttl qty
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in widget.menu['Burger'].values)
                                Text('${item['qty'].toString()}x', style: const TextStyle(fontSize: 16),)
                            ],
                          ),
                          Column(  // component
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in widget.menu['Burger'].keys)
                                Text(item.toString(), style: const TextStyle(fontSize: 16),)
                            ],
                          ),
                          Column(  // price
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              for (var item in widget.menu['Burger'].values)
                                Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(item["price"])},-', style: const TextStyle(fontSize: 16),)
                            ],
                          ),
                        ],
                      ),
                      const Divider(),
                      widget.menu.containsKey('Discount')? 
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Diskon', style: TextStyle(fontSize: 16),),
                                Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.menu['Discount'])},-', style: const TextStyle(fontSize: 16),)
                              ],
                            ),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.menu['TtlPrice']-widget.menu['Discount'])},-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                              ],
                            )
                          ],
                        )
                        :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                            Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.menu["TtlPrice"])},-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),)
                          ],
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(8),
        height: 60,
        elevation: 5,
        child: ElevatedButton(
          onPressed: () {
            provBurger.resetAll();
            provBurger.orderCreation = widget.menu;
            provNav.orderState = 'Addition';
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: false)));
          },
          child: const Text('Pesan Sekarang', style: TextStyle(fontSize: 18),),
        ),
      ),
    );
  }
}