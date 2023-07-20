import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key, required this.title});

  final String title;

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    final provBurger = Provider.of<BurgerProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Table(
                      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                      columnWidths: const {
                        0 : IntrinsicColumnWidth()
                      },
                      children: [
                        TableRow(
                          children: [
                            const Text('Nama'),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, bottom: 10),
                              child: TextField(
                                controller: provBurger.nama,
                                maxLength: 20,
                                onChanged: (value) {
                                  setState(() {
                                    provBurger.userInfo.isNotEmpty? provBurger.addContactInfo() : null;
                                  });
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Pastikan memasukkan nama yang sesuai.',
                                  labelText: 'Nama Anda',
                                  errorText: provBurger.userInfo.isNotEmpty && provBurger.userInfo['Nama'].toString().isEmpty? 'Nama wajib dimasukkan' : provBurger.nama.text.trim().contains('kreazi')? 'Anda tidak diizinkan memakai nama ini.' : null,
                                ),
                                textInputAction: TextInputAction.next,
                              ),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            const Text('No HP'),
                            Padding(
                              padding: const EdgeInsets.only(left: 5, bottom: 5),
                              child: TextField(
                                controller: provBurger.noHp,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9*#+]'))
                                ],
                                maxLength: 15,
                                onChanged: (value) {
                                  provBurger.userInfo.isNotEmpty? provBurger.addContactInfo() : null;
                                },
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Pastikan memasukkan nomor [WhatsApp] yang aktif.',
                                  labelText: 'No HP Anda',
                                  errorText: provBurger.userInfo.isNotEmpty && provBurger.userInfo['No HP'].toString().isEmpty? 'No HP wajib dimasukkan' : provBurger.userInfo.isNotEmpty && provBurger.userInfo['No HP'].toString().length<8? 'Invalid. Masukkan minimal 8 karakter' : null,
                                ),
                                keyboardType: TextInputType.phone,
                              ),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            const Text('Jenis Kelamin'),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Radio(
                                          value: 'Laki-Laki', 
                                          groupValue: provBurger.gender, 
                                          onChanged: (val) {
                                            provBurger.changeGender = val;
                                          }
                                        ),
                                        GestureDetector(
                                          onTap: () => provBurger.changeGender = 'Laki-Laki',
                                          child: const Text('Laki-Laki')
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Radio(
                                        value: 'Perempuan', 
                                        groupValue: provBurger.gender, 
                                        onChanged: (val) {
                                          provBurger.changeGender = val;
                                        }
                                      ),
                                      GestureDetector(
                                        onTap: () => provBurger.changeGender = 'Perempuan',
                                        child: const Text('Perempuan')
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            const Text('Metode Pembayaran'),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: DropdownButtonFormField(
                                value: provBurger.selPembayaran,
                                items: [
                                  const DropdownMenuItem(
                                    value: 'Pilih',
                                    enabled: false,
                                    child: Text('Pilih', style: TextStyle(color: Colors.grey),),
                                  ),
                                  for (var item in provBurger.pembayaran)
                                    DropdownMenuItem(
                                      value: item,
                                      child: Text(item),
                                    ),
                                  DropdownMenuItem(
                                    value: 'COD',
                                    enabled: provLogin.isLoggedIn,
                                    child: provLogin.isLoggedIn? const Text('COD') :  const Text('COD (wajib login)', style: TextStyle(color: Colors.grey),),
                                  )
                                ], 
                                onChanged: (val) {provBurger.changePembayaran = val;},
                                icon: const Icon(Icons.keyboard_arrow_down),
                                borderRadius: const BorderRadius.all(Radius.circular(5)),
                                focusColor: Colors.grey[50],
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    borderSide: BorderSide(color: Colors.black45)
                                  ),
                                  errorText: provBurger.userInfo.isNotEmpty && provBurger.selPembayaran == 'Pilih'? 'Wajib pilih metode pembayaran' : null
                                ),
                              ),
                            ),
                          ]
                        ),
                        TableRow(
                          children: [
                            const Text('Waktu pengambilan'),
                            Row(
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {provBurger.addWaktu='jam';}, 
                                      splashRadius: 16,
                                      icon: const Icon(Icons.keyboard_arrow_up_rounded)
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(3)
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(DateFormat('HH').format(provBurger.waktu))
                                    ),
                                    IconButton(
                                      onPressed: () {provBurger.redWaktu='jam';}, 
                                      splashRadius: 16,
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded)
                                    ),
                                  ],
                                ),
                                const Text(':'),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      onPressed: () {provBurger.addWaktu='menit';}, 
                                      splashRadius: 16,
                                      icon: const Icon(Icons.keyboard_arrow_up_rounded)
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(),
                                        borderRadius: BorderRadius.circular(3)
                                      ),
                                      padding: const EdgeInsets.all(5),
                                      child: Text(DateFormat('mm').format(provBurger.waktu))
                                    ),
                                    IconButton(
                                      onPressed: () {provBurger.redWaktu='menit';}, 
                                      splashRadius: 16,
                                      icon: const Icon(Icons.keyboard_arrow_down_rounded)
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                IconButton(
                                  onPressed: () async {
                                    var res = await showTimePicker(
                                      context: context, 
                                      initialTime: TimeOfDay.fromDateTime(provBurger.waktu),
                                      builder: (context, child) {
                                        return MediaQuery(data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true), child: child!);
                                      },
                                    );
                                    if (res != null) {
                                      setState(() {
                                        final now = DateTime.now().add(const Duration(minutes: 5));
                                        final tmp = DateTime(now.year, now.month, now.day, res.hour, res.minute);
                                        if (now.difference(tmp).inMinutes <= 0) {
                                          if (tmp.hour>=22) {
                                            provBurger.addPickup = DateTime(now.year, now.month, now.day, 22, 0);
                                          }
                                          else if (tmp.hour<=6) {
                                            provBurger.addPickup = DateTime(now.year, now.month, now.day, 6, 0);
                                          }
                                          else {
                                            provBurger.addPickup = tmp;
                                          }
                                        }
                                        else {
                                          provBurger.addPickup = now;
                                        }
                                      });
                                    }
                                  }, 
                                  tooltip: 'Pilih waktumu',
                                  splashRadius: 25,
                                  icon: const Icon(Icons.timer_rounded)
                                )
                              ],
                            ),
                          ]
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(child: Text('Simpan & Update data kontak saya ke Profile', overflow: TextOverflow.fade,)),
                        Switch(
                          value: provBurger.saveUser, 
                          onChanged: (val) {
                            provBurger.saveUser = val;
                          },
                          activeColor: myCustomColor(),
                          activeTrackColor: myCustomColor()[200],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
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