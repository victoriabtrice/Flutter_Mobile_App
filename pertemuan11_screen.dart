import 'package:flutter/material.dart';
import 'package:flutter_application_11_latihan/pertemuan11/pertemuan11_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class Pertemuan11Screen extends StatefulWidget {
  const Pertemuan11Screen({super.key});

  @override
  State<Pertemuan11Screen> createState() => _Pertemuan11ScreenState();
}

class _Pertemuan11ScreenState extends State<Pertemuan11Screen> {
  @override
  void initState() {
    Future.microtask(() =>
        Provider.of<Pertemuan11Provider>(context, listen: false).initialData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pertemuan 11'),
        actions: [menuList(context)],
      ),
      body: body(context),
    );
  }

  body(BuildContext context) {
    final prov = Provider.of<Pertemuan11Provider>(context);
    if (prov.data == null) {
      return const CircularProgressIndicator();
    } else {
      return Container(
        child: prov.data['data']!.length == 0
            ? const Center(
                child: Text('Data tidak ditemukan'),
              )
            : ListView(
                children: List.generate(prov.data['data']!.length, (index) {
                  var item = prov.data['data']![index];
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(item['img'])),
                        title: Text(item['model']),
                        isThreeLine: true,
                        subtitle: Text(
                            "${"by " + item['developer']}\nprice : ${NumberFormat.currency(locale: 'ID').format(item['price'])}\nrate : ${item['rating']}"),
                      ),
                      const Divider()
                    ],
                  );
                }),
              ),
      );
    }
  }

  menuList(BuildContext context) {
    final prov = Provider.of<Pertemuan11Provider>(context);
    return PopupMenuButton(
        icon: const Icon(Icons.more_vert),
        itemBuilder: (BuildContext context) {
          return <PopupMenuEntry>[
            PopupMenuItem(
                child: ListTile(
              onTap: () => prov.ubahList('hp'),
              leading: const Icon(Icons.phone),
              title: const Text('HP'),
            )),
            const PopupMenuDivider(),
            PopupMenuItem(
                child: ListTile(
              onTap: () => prov.ubahList('laptop'),
              leading: const Icon(Icons.laptop),
              title: const Text('Laptop'),
            )),
            const PopupMenuDivider(),
            PopupMenuItem(
                child: ListTile(
              onTap: () {
                setState(() {
                  prov.data['data']!.clear();
                });
              },
              leading: const Icon(Icons.delete),
              title: const Text('Clear'),
            )),
          ];
        });
  }
}
