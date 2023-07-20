import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/providers/notification_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/components/stack_burger.dart';
import 'package:b_kreazi/pages/create_burger.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({super.key, required this.order});

  final Map order;

  @override
  State<OrderDetail> createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {

  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provNav = Provider.of<NavigationProvider>(context);
    final provNotif = Provider.of<NotificationProvider>(context);

    noHp() {
      RegExp exp = RegExp(r'[0-9+*#]{1,4}');   // [allowed char]{length}
      String str = widget.order['Contact']['No HP'].toString();
      Iterable<Match> matches = exp.allMatches(str);
      var list = matches.map((m) => m.group(0));
      return list.join(" ");
    }
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesanan  ${widget.order['Contact']['Waktu']}'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: myCustomColor()[200],
                    borderRadius: BorderRadius.circular(8)
                  ),
                  padding: const EdgeInsets.all(15),
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('B_Kreazi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1),),
                          widget.order['Username'].isNotEmpty? const Icon(Icons.verified_rounded, color: Colors.blue, size: 30,) : const SizedBox()
                        ],
                      ),
                      const SizedBox(height: 30,),
                      // Text(widget.order['Contact']['No HP'], style: const TextStyle(fontSize: 18, letterSpacing: 3),),
                      Text(noHp().toString(), style: const TextStyle(fontSize: 20, letterSpacing: 4),),
                      const SizedBox(height: 30,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Penerima', style: TextStyle(fontSize: 12),),
                              Text(widget.order['Contact']['Nama'], style: const TextStyle(fontSize: 18),)
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text('Jenis Kelamin', style: TextStyle(fontSize: 12),),
                              Text(widget.order['Contact']['Gender'], style: const TextStyle(fontSize: 18),)
                            ],
                          )
                        ]
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Text('PIN', style: TextStyle(fontSize: 20),),
                    ),
                    widget.order['Order']['Status'] == 'Sudah di Pick-Up'? Text(widget.order['Order']['Code'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23, letterSpacing: 3),) : 
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context, 
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Shhh... RAHASIA!', style: TextStyle(fontWeight: FontWeight.bold),),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text('Jangan sampai orang lain melihat kode ini. Hanya berikan kode dibawah pada kasir untuk mengambil pesananmu.', textAlign: TextAlign.justify,),
                                  const SizedBox(height: 10,),
                                  // Text(widget.order['Order']['Code'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 6)),
                                  Tooltip(
                                    message: 'Klik untuk salin PIN',
                                    child: TextButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(text: widget.order['Order']['Code'].toString()));
                                        if (mounted) {
                                          // Navigator.pop(context);
                                          // ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                                          //   const SnackBar(
                                          //     behavior: SnackBarBehavior.floating,
                                          //     duration: Duration(seconds: 3),
                                          //     content: Text('Kode PIN disalin ke clipboard.'),
                                          //   )
                                          // );
                                          Fluttertoast.showToast(
                                            msg: 'Kode PIN disalin ke clipboard.',
                                            backgroundColor: Colors.black54,
                                            textColor: Colors.white,
                                            // gravity: ToastGravity.CENTER,   // klo di web jd top
                                            timeInSecForIosWeb: 3,
                                            webBgColor: "rgba(0, 0, 0, 0.7)",
                                            webPosition: "center"
                                          );
                                        }
                                      },
                                      child: Text(widget.order['Order']['Code'].toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 40, letterSpacing: 6.5, color: Colors.black))
                                    ),
                                  ),
                                  // const Text('Berikan pada kasir untuk mengambil pesananmu.', textAlign: TextAlign.justify,)
                                ]
                              ),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
                              ],
                            );
                          }
                        );
                      }, 
                      child: const Text('Lihat Kode', style: TextStyle(fontSize: 17),)
                    )
                  ]
                ),
                StackBurger(source: widget.order, padding: 16),
                const Center(child: Text('*Gambar hanya ilustrasi', style: TextStyle(fontSize: 12),)),
                const SizedBox(height: 10,),
                Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    // border: Border.all(width: 0.5),
                    color: myCustomColor()[100]
                  ),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text('B_Kreazi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 1.5), textAlign: TextAlign.center,),
                          const SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Waktu Pemesanan'),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                child: Text(widget.order['Contact']['Waktu'], style: const TextStyle(fontSize: 16),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Waktu Pengambilan'),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
                                child: Text(widget.order['Contact']['Pick Up'], style: TextStyle(fontSize: 17, color: myCustomDarkerColor()),),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Status Pesanan'),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Text(widget.order['Order']['Status'], style: const TextStyle(fontSize: 16),),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(height: 5,),
                      const Divider(height: 5,),
                      const SizedBox(height: 5,),
                      Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text('Burger ${widget.order['Name']} ', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text('(by : ${widget.order['Creator']})'),
                        ],
                      ),
                      const Divider(),
                      Table(
                        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                        columnWidths: const {
                          1: IntrinsicColumnWidth()
                        },
                        children: [ for (var item in widget.order['Burger'].entries)
                          TableRow(
                            children: [
                              Column(  // ttl qty
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.key, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
                                  Text('${item.value['qty']}x ${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(item.value["price"]/item.value['qty'])},-', style: const TextStyle(fontSize: 16),),
                                  const SizedBox(height: 3,)
                                ],
                              ),
                              Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(item.value["price"])},-', style: const TextStyle(fontSize: 16),)
                            ]
                          )
                        ],
                      ),
                      const Divider(),
                      if (widget.order['Addition'].isNotEmpty)
                        Column(
                          children: [
                            const Text('Pendamping', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(  // component
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var addition in widget.order['Addition'].keys)
                                      for (var type in widget.order['Addition'][addition].entries)
                                        Text('$addition ${type.key}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),)
                                  ],
                                ),
                                Column(  // price
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var addition in widget.order['Addition'].keys)
                                      for (var type in widget.order['Addition'][addition].entries)
                                        Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(type.value)},-', style: const TextStyle(fontSize: 16),)
                                  ],
                                ),
                              ],
                            ),
                            const Divider(),
                          ],
                        ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(child: Text('Catatan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
                          const Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Level Pedas', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                              Text(widget.order['Spicy'], style: const TextStyle(fontSize: 17),)
                            ]
                          ),
                          const SizedBox(height: 5,),
                          RichText(
                            text: TextSpan(
                              text: 'Note : ',
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Gill Sans MT'),
                              children: [
                                TextSpan(
                                  text: widget.order['Note'], 
                                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
                                )
                              ]
                            ), 
                          ),
                          const Divider(),
                        ],
                      ),
                      if (widget.order.containsKey('Discount'))
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Diskon', style: TextStyle(fontSize: 16),),
                                Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.order["Discount"])},-', style: const TextStyle(fontSize: 16),)
                              ],
                            ),
                            const Divider(),
                          ]
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text('${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.order["FinalPrice"])},-', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
                        ],
                      ),
                      Row( 
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Metode Pembayaran', style: TextStyle(fontSize: 17),),
                          Container(
                            margin: const EdgeInsets.fromLTRB(5, 5, 3.5, 0),
                            padding: const EdgeInsets.fromLTRB(5, 2.5, 5, 2.5),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: Text(widget.order['Contact']['Pembayaran'])
                          )
                        ],
                      ),
                      const SizedBox(height: 10,),
                      const Divider(height: 5,),
                      const Divider(height: 5,),
                      const SizedBox(height: 10,),
                      Text(
                        widget.order['Contact']['Pembayaran']=='COD'? 
                        'Harap lakukan pembayaran sebesar ${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.order["FinalPrice"])},- dikasir saat pick-up pesanan Anda.' : 
                        'Saldo sebesar ${NumberFormat.currency(locale: "id_ID", symbol: "Rp. ", decimalDigits: 0).format(widget.order["FinalPrice"])},- akan otomatis terpotong dari ${widget.order['Contact']['Pembayaran']}-mu saat pesanan selesai di pick-up.', 
                        textAlign: TextAlign.justify,
                        style: const TextStyle(fontSize: 14),
                      ),
                      const SizedBox(height: 8,),
                      const Text('Terima Kasih', style: TextStyle(fontSize: 16),)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.all(8),
        height: 60,
        elevation: 5,
        child: widget.order['Order']['Status'] != 'Sudah di Pick-Up'?
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context, 
                barrierDismissible: false,
                builder: (BuildContext context) {
                  final provOrder = Provider.of<OrderProvider>(context);
                  return AlertDialog(
                    title: const Text('Update Status Pesanan', style: TextStyle(fontWeight: FontWeight.bold),),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Apakah Anda yakin sudah mengambil pesanan Anda? Dengan ini,  Anda tidak dapat melakukan komplain jika pesanan Anda salah atau belum diterima.', textAlign: TextAlign.justify,),
                        SizedBox(
                          width: MediaQuery.of(context).size.width >= 400? 280 : null,
                          child: PinCodeTextField(
                            appContext: context, 
                            length: 6, 
                            // controller: provOrder.confirmCode,
                            autoFocus: true,
                            autoDisposeControllers: false,
                            enablePinAutofill: false,
                            onChanged: (val) async {
                              provOrder.confirmCode = val;
                              if (val.isEmpty && provOrder.confirmStatus!='Masukkan PIN konfirmasi') {
                                provOrder.confirmStatus = 'Wajib diisi';
                              }
                              else if (val.length == 6) {
                                if (val.trim() == widget.order['Order']['Code'].toString()) {
                                  provOrder.sudahPickup = provOrder.myOrder.indexOf(widget.order);
                                  provOrder.confirmStatus = 'PIN benar!';
                                  await Future.delayed(const Duration(seconds: 1));
                                  if (mounted) {
                                    ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                                      const SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        duration: Duration(seconds: 3),
                                        content: Text('PIN benar! Pesanan berhasil di pick-up.'),
                                      )
                                    );
                                    // Navigator.pop(context);
                                    Navigator.popUntil(context, (route) => route.isFirst);
                                    provOrder.confirmCode = '';    // eek
                                    provOrder.confirmStatus = 'Masukkan PIN konfirmasi';
                                  }
                                  await Future.delayed(
                                    const Duration(seconds: 8),
                                    () {
                                      provNotif.autoSend = {
                                        'title': 'Selamat makan Kreazier', 
                                        'body': 'Pesanan #${widget.order['Order']['Code']} sudah kamu pick-up. Terima kasih udah menggunakan aplikasi B_Kreazi untuk memesan Burgermu. Selamat menikmati ~~',
                                        'date': DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()), 
                                        'type': 'Order', 
                                        'read': false
                                      };
                                    }
                                  );
                                }
                                else {
                                  provOrder.confirmStatus = 'Kode tidak cocok';
                                }
                              }
                              
                            },
                          ),
                        ),
                        Text(provOrder.confirmStatus, style: TextStyle(fontSize: 13, color: provOrder.confirmStatus.contains('PIN')? null : Colors.red),)
                        // TextFormField(
                        //   autofocus: true,
                        //   controller: provOrder.confirmCode,
                        //   decoration: InputDecoration(
                        //     hintText: 'Masukkan Kode PIN disini',
                        //     errorText: provOrder.confirmStatus.isEmpty? null : provOrder.confirmStatus,
                        //   ),
                        //   onFieldSubmitted: (val) async {
                        //     if (val.isEmpty) {
                        //       provOrder.confirmStatus = 'Wajib diisi';
                        //     }
                        //     else if (val.trim() == widget.order['Order']['Code'].toString()) {
                        //       provOrder.sudahPickup = provOrder.myOrder.indexOf(widget.order);
                        //       provOrder.confirmCode.text = '';
                        //       provOrder.confirmStatus = '';
                        //       ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                        //         SnackBar(
                        //           behavior: SnackBarBehavior.floating,
                        //           duration: const Duration(seconds: 3),
                        //           content: const Text('PIN benar! Pesanan berhasil di pick-up.'),
                        //           action: SnackBarAction(
                        //             label: 'OK',
                        //             textColor: Colors.white,
                        //             onPressed: () {
                        //               ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        //             },
                        //           ),
                        //         )
                        //       );
                        //       // Navigator.pop(context);
                        //       Navigator.popUntil(context, (route) => route.isFirst);
                        //       await Future.delayed(
                        //         const Duration(seconds: 8),
                        //         () {
                        //           provNotif.autoSend = {
                        //             'title': 'Selamat makan Kreazier', 
                        //             'body': 'Pesanan #${widget.order['Order']['Code']} sudah kamu pick-up. Terima kasih udah menggunakan aplikasi B_Kreazi untuk memesan Burgermu. Selamat menikmati ~~',
                        //             'date': DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()), 
                        //             'type': 'Order', 
                        //             'read': false
                        //           };
                        //         }
                        //       );
                        //     }
                        //     else {
                        //       provOrder.confirmStatus = 'Kode PIN tidak cocok';
                        //     }
                        //   },
                        // )
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          provOrder.confirmCode = '';
                          provOrder.confirmStatus = 'Masukkan PIN konfirmasi';
                        }, 
                        child: const Text('Batal', style: TextStyle(color: Colors.black45),)
                      ),
                      TextButton(
                        onPressed: () {
                          if (provOrder.confirmCode.isEmpty) {
                            provOrder.confirmStatus = 'Wajib diisi';
                          }
                          else {
                            provOrder.confirmStatus = 'Kode tidak cocok';
                          }
                        }, 
                        child: const Text('Update')
                      )
                    ],
                  );
                }
              );
            },
            child: const Text('Sudah di Pick-Up', style: TextStyle(fontSize: 18),),
          )
        :
          ElevatedButton(
            onPressed: () {
              provBurger.resetAll();
              provBurger.orderCreation = widget.order;
              provBurger.reOrderAdditional = widget.order['Addition'];
              provBurger.spicy = provBurger.spicyLevel.indexOf(widget.order['Spicy']);
              provBurger.note.text = widget.order['Note'];
              provNav.orderState = 'Addition';
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CreateBurger(back: false)));
            },
            child: const Text('Pesan Lagi', style: TextStyle(fontSize: 18),),
          ),
      ),
    );
  }
}