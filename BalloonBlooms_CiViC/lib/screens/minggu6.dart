import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/notification_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key, required this.title});
  final String title;

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    final provNotif = Provider.of<NotifProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Switch(
                      value: provNotif.unreadOnly,
                      onChanged: (val) => provNotif.showUnreadOnly = val,
                      activeColor: myCustomColor(),
                      activeTrackColor: myCustomColor()[200],
                    ),
                    const Text('Belum dibaca', style: TextStyle(fontSize: 17),)
                  ],
                ),
                DropdownButton(
                  value: provNotif.selectedType,
                  onChanged: (val) => provNotif.changeNotifType = val,
                  items: 
                    provNotif.notifType.map((tipe) {
                      return DropdownMenuItem(
                        value: tipe, 
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Text(tipe, overflow: TextOverflow.ellipsis, softWrap: true,),
                        ),
                      );
                    }).toList(),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  icon: const Icon(Icons.keyboard_arrow_down),
                  underline: const SizedBox(),
                  elevation: 2,
                  style: const TextStyle(fontSize: 17, color: Colors.black54),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                child: SingleChildScrollView(
                  child: Column(
                    children: 
                      provNotif.allNotif.map((notif) {
                        return Visibility(
                          visible: (provNotif.unreadOnly? !notif['read'] : true) && (provNotif.selectedType=='Semua'? true : provNotif.selectedType == notif['type']) ,  // slalu tampilkan jk unreadOnly = false n tipeNotif = semua
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                            decoration: BoxDecoration(
                              border: Border.all(width: 0.3),
                              borderRadius: BorderRadius.circular(5),
                              color: notif['read']? null : myCustomColor()[100]
                            ),
                            child: InkWell(
                              onTap: () {
                                if (!notif['read']) {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Tandai sudah dibaca', style: TextStyle(fontWeight: FontWeight.bold),),
                                        content: const Text('Yakin sudah membaca notifikasi ini?'),
                                        actions: [ 
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  provNotif.readNotif = notif['id'];
                                                  Navigator.pop(context);
                                                },
                                                child: const Text('Ya')
                                              ),
                                              TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('Tidak')),
                                            ],
                                          )
                                        ],
                                      );
                                    }
                                  );
                                }
                                else {
                                  showDialog(
                                    context: context, 
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Sudah dibaca', style: TextStyle(fontWeight: FontWeight.bold),),
                                        content: const Text('Tenang... Notifikasi ini sudah kamu baca.'),
                                        actions: [ 
                                          TextButton(onPressed: () {Navigator.pop(context);}, child: const Text('OK'))
                                        ],
                                      );
                                    }
                                  );
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context).size.width <= 375 ? MediaQuery.of(context).size.width*0.55 : null,
                                          child: Text(notif['title'].toString(), overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
                                        Text(notif['date'].split(' ')[0]==DateFormat('dd-MM-yyy').format(DateTime.now())? notif['date'].split(' ')[1] : notif['date'].split(' ')[0],)
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(notif['body'], softWrap: true, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16, color: Colors.black87),)
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}