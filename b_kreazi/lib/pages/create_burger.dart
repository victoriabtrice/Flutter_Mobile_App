import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/providers/notification_provider.dart';
import 'package:b_kreazi/providers/user_provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/providers/officialmenu_provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/pages/choose_burger.dart';
import 'package:b_kreazi/pages/custom_burger.dart';
import 'package:b_kreazi/pages/final_burger.dart';
import 'package:b_kreazi/pages/user_info.dart';

class CreateBurger extends StatefulWidget {
  const CreateBurger({super.key, required this.back});

  final bool back;

  @override
  State<CreateBurger> createState() => _CreateBurgerState();
}

class _CreateBurgerState extends State<CreateBurger> {
  @override
  Widget build(BuildContext context) {
    final provNav = Provider.of<NavigationProvider>(context);
    final provBurger = Provider.of<BurgerProvider>(context);
    final provOrder = Provider.of<OrderProvider>(context);
    final provUser = Provider.of<UserProvider>(context);
    final provNotif = Provider.of<NotificationProvider>(context);
    final provCreate = Provider.of<CreationProvider>(context);
    final provMenu = Provider.of<OfficialMenuProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);
    
    final Map state = {
      'Choose': const ChooseBurger(title: 'Tahap 1 : Pilih bahan-bahan'),
      'Custom': const CustomBurger(title: 'Tahap 2 : Sesuaikan bahan-bahan'),
      'Addition': FinalBurger(title: 'Tahap 3 : Tambahkan pelengkap', back: widget.back),
      'Contact': const UserInfo(title: 'Tahap 4 : Lengkapi data diri'),
    };
    final List states = ['Choose', 'Custom', 'Addition', 'Contact'];
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kreazi-kan Burger-mu'),
        leading: IconButton(
          onPressed: () {
            showDialog(
              context: context, 
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Peringatan!', style: TextStyle(fontWeight: FontWeight.bold),),
                  content: const Text('Kamu akan kehilangan semua progres kustomisasi yang telah kamu lakukan. Yakin ingin kembali?', textAlign: TextAlign.justify,),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal', style: TextStyle(color: Colors.grey),)),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                        provNav.orderState = 'Choose';
                        provBurger.resetAll();
                      },
                      child: const Text('Ya')
                    )
                  ],
                );
              }
            );
          },
          tooltip: 'Cancel Order',
          icon: const Icon(Icons.close_rounded)
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: myCustomColor()[400],
            ),
            padding: const EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width,
            child: Text(state[provNav.orderState].title, style: const TextStyle(fontSize: 17),),
          ),
          Expanded(
            child: state[provNav.orderState],
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        height: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: states.indexOf(provNav.orderState)/3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    onPressed: provNav.orderState == 'Choose' || (provNav.orderState == 'Addition' && !state[provNav.orderState].back)? null : () {
                      provNav.orderState = states[states.indexOf(provNav.orderState)-1];
                    }, 
                    icon: const Icon(Icons.arrow_back_ios_rounded),
                    splashRadius: 40,
                    tooltip: provNav.orderState=='Choose'? 'Batalkan' : state[states[states.indexOf(provNav.orderState)-1]].title,
                  ),
                ),
                provNav.orderState=='Contact'? Container() : Text(provNav.orderState, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: provNav.orderState=='Contact'? 
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: provCreate.allCreations.any((creation) => creation['Burger'].toString() == provBurger.finalComponent['Burger'].toString()) || provMenu.allMenu.any((menu) => menu['Burger'].toString() == provBurger.finalComponent['Burger'].toString())? null : () {
                          provBurger.addContactInfo();
                          if (provBurger.nama.text.trim().isNotEmpty && provBurger.noHp.text.trim().isNotEmpty && provBurger.userInfo['No HP'].toString().length>=8 && provBurger.selPembayaran!='Pilih') {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                final provBurger = Provider.of<BurgerProvider>(context);
                                return AlertDialog(
                                  title: const Text('Masukkan nama Kreazi-mu', style: TextStyle(fontWeight: FontWeight.bold),),
                                  content: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextFormField(
                                        controller: provBurger.creationName,
                                        autofocus: true,
                                        maxLength: 15,
                                        decoration: InputDecoration(
                                          hintText: 'Nama Kreazi-mu disini',
                                          errorText: provBurger.creationName.text.trim().isEmpty? 'Wajib diisi' : provCreate.allCreations.any((creation) => creation['Name'].toLowerCase()==provBurger.creationName.text.trim().toLowerCase())? 'Nama Kreazi ini sudah terdaftar' : provBurger.creationName.text.trim().toLowerCase().contains('kreazi')? 'Tidak boleh memakai nama ini' : null
                                        ),
                                      ),
                                      const SizedBox(height: 10,),
                                      Text('Kamu akan membuat pesanan senilai ${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(provBurger.myOrder(provLogin.username.text)['FinalPrice'])},- dengan metode pembayaran ${provBurger.selPembayaran} dan Kreazi ini juga akan diposting dihalaman Creation.', textAlign: TextAlign.justify, style: const TextStyle(fontSize: 14),)
                                    ],
                                  ),
                                  actions: [
                                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Batal', style: TextStyle(color: Colors.grey),)),
                                    TextButton(
                                      onPressed: () async {
                                        provBurger.addContactInfo();
                                        if (provBurger.creationName.text.trim().isNotEmpty && !provCreate.allCreations.any((creation) => creation['Name'].toLowerCase()==provBurger.creationName.text.trim().toLowerCase())) {
                                          if (provBurger.waktu.difference(DateTime.now().add(const Duration(minutes: 5))).inMinutes<=0) {
                                            provBurger.resetTime();
                                            provBurger.addContactInfo();
                                          }
                                          provCreate.addCreations = provBurger.myCreation(provLogin.username.text);
                                          provCreate.addMyCreation = provBurger.myCreation(provLogin.username.text);
                                          final pesananSaya = provBurger.myOrder(provLogin.username.text);
                                          provOrder.addOrder = pesananSaya;  // add to order
                                          if (provBurger.saveUser) {
                                            provUser.saveUser = {
                                              'Nama' : provBurger.nama.text.trim(),
                                              'No HP' : provBurger.noHp.text.trim(),
                                              'Gender' : provBurger.gender
                                            };
                                          }
                                          else if (provUser.userInfo.isEmpty) {
                                            provBurger.resetContactInfo();
                                          }
                                          else {
                                            provBurger.userInfo = provUser.userInfo;
                                          }
                                          
                                          Navigator.popUntil(context, (route) => route.isFirst);
                                          provNav.orderState = 'Choose';
                      
                                          // auto send notif setelah ... menit 
                                          final now = DateTime.now();
                                          final time = DateTime(now.year, now.month, now.day, provBurger.waktu.hour, provBurger.waktu.minute);
                                          await Future.delayed(
                                            time.difference(now),
                                            () {
                                              if (pesananSaya['Order']['Status']!='Sudah di Pick-Up') { // status pesanan belum berubah
                                                provNotif.autoSend = {
                                                  'title': 'Sudah waktunya Pick-Up', 'body': 'Kriinggg... Masih inget pesanan Burger yang kamu jadwalkan untuk diambil pukul ${DateFormat('HH').format(time)}:${DateFormat('mm').format(time)}? Kamu udah bisa datang ke store untuk cek apakah Burger-mu udah siap dan nikmatilah selagi fresh *chef kiss* (Ini adalah pesan otomatis)',
                                                  'date': DateFormat('dd-MM-yyyy HH:mm').format(time),
                                                  'type': 'Order', 
                                                  'read': false
                                                }; 
                                              }
                                            }
                                          );
                                        }
                                      }, 
                                      child: const Text('Posting dan Pesan')
                                    )
                                  ],
                                );
                              }
                            );
                            provNav.currentIndex = 2;   // tampilkan halaman order
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(provCreate.allCreations.any((creation) => creation['Burger'].toString() == provBurger.finalComponent['Burger'].toString())? 'Kreazi terdaftar' : provMenu.allMenu.any((menu) => menu['Burger'].toString() == provBurger.finalComponent['Burger'].toString())? 'Menu terdaftar' : 'Posting', style: const TextStyle(fontSize: 18),),
                        )
                      ),
                      const SizedBox(width: 10,),
                      ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(Colors.orangeAccent),
                        ),
                        onPressed: () {
                          provBurger.addContactInfo();
                          if (provBurger.nama.text.trim().isNotEmpty && provBurger.noHp.text.trim().isNotEmpty && provBurger.userInfo['No HP'].toString().length>=8 && provBurger.selPembayaran!='Pilih') {
                            showDialog(
                              context: context, 
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Konfirmasi Ulang', style: TextStyle(fontWeight: FontWeight.bold),),
                                  content: Text('Hai, ${provBurger.nama.text.trim()}. Kamu yakin akan membuat pesanan senilai ${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(provBurger.myOrder(provLogin.username.text)['FinalPrice'])},- dengan metode pembayaran ${provBurger.selPembayaran}?', textAlign: TextAlign.justify,),
                                  actions: [
                                    TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Batal', style: TextStyle(color: Colors.grey),)),
                                    TextButton(
                                      onPressed: () async {
                                        if (provBurger.waktu.difference(DateTime.now().add(const Duration(minutes: 5))).inMinutes<=0) {
                                          provBurger.resetTime();
                                          provBurger.addContactInfo();
                                        }
                                        final pesananSaya = provBurger.myOrder(provLogin.username.text);
                                        provOrder.addOrder = pesananSaya;  // add to order
                                        if (provBurger.saveUser) { // jika mau disave data
                                          provUser.saveUser = {
                                            'Nama' : provBurger.nama.text.trim(),
                                            'No HP' : provBurger.noHp.text.trim(),
                                            'Gender' : provBurger.gender
                                          };
                                        }
                                        else if (provUser.userInfo.isEmpty) {  // jk tdk di save dan data profile mmg kosong
                                          provBurger.resetContactInfo();
                                        }
                                        else {  // jk tdk di save dan data profile ada
                                          provBurger.userInfo = provUser.userInfo;
                                        }

                                        Navigator.popUntil(context, (route) => route.isFirst); // back/ exit ampe home
                                        provNav.orderState = 'Choose';

                                        // auto send notif setelah ... menit 
                                        final now = DateTime.now();
                                        final time = DateTime(now.year, now.month, now.day, provBurger.waktu.hour, provBurger.waktu.minute);
                                        await Future.delayed(
                                          time.difference(now),
                                          () {
                                            if (pesananSaya['Order']['Status'] != 'Sudah di Pick-Up') { // status pesanan belum berubah
                                              provNotif.autoSend = {
                                                'title': 'Sudah waktunya Pick-Up', 'body': 'Kriinggg... Masih inget pesanan Burger yang kamu jadwalkan untuk diambil pukul ${DateFormat('HH').format(time)}:${DateFormat('mm').format(time)}? Kamu udah bisa datang ke store untuk cek apakah Burger-mu udah siap dan nikmatilah selagi fresh *chef kiss* (Ini adalah pesan otomatis)',
                                                'date': DateFormat('dd-MM-yyyy HH:mm').format(time), 
                                                'type': 'Order', 
                                                'read': false
                                              };
                                            }
                                          }
                                        );
                                      },
                                      child: const Text('Ya')
                                    )
                                  ],
                                );
                              }
                            );
                          }
                          provNav.currentIndex = 2;   // tampilkan halaman order
                        },
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(13, 10, 13, 10),
                          child: Text('Pesan', style: TextStyle(fontSize: 18),),
                        ),
                      ),
                    ],
                  )
                  : IconButton(
                    onPressed: () {
                      if (provNav.orderState=='Custom' || provNav.orderState=='Choose') {
                        provBurger.addFinal();
                      }
                      else if (provNav.orderState=='Addition') {
                        provBurger.addAddition();
                        if (provBurger.finalAddition.isNotEmpty && provBurger.finalAddition.values.any((element) => element.isEmpty)) {
                          provNav.orderState = states[states.indexOf(provNav.orderState)-1];
                        }
                      }
                      provNav.orderState = states[states.indexOf(provNav.orderState)+1];
                      provBurger.resetTime();
                    }, 
                    icon: const Icon(Icons.arrow_forward_ios_rounded),
                    splashRadius: 40,
                    tooltip: state[states[states.indexOf(provNav.orderState)+1]].title,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 3,)
          ],
        ),
      ),
    );
  }
}