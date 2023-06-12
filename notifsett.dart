// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class NotifSettPage extends StatefulWidget {
  const NotifSettPage({super.key});

  @override
  State<NotifSettPage> createState() => _NotifSettPageState();
}

class _NotifSettPageState extends State<NotifSettPage> {
  bool isSwitched = false;
  bool isSelected = false;
  String phring = 'Luna';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ListTile(
            title: const Text('Ringtone'),
            subtitle: Text(phring),
            onTap: () {
              var dialog = SimpleDialog(
                title: const Text('Phone Ringtone'),
                children: [
                  SingleChildScrollView(
                    child: Column(children: [
                      SimpleDialogOption(
                        child: Column(
                          children: [
                            ListTile(
                              leading: Radio(
                                value: 'None',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('None'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Callisto',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Callisto'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Ganymede',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Ganymede'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Luna',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Luna'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Oberon',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Oberon'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Phobos',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Phobos'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Dione',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Dione'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Light',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Light'),
                            ),
                            ListTile(
                              leading: Radio(
                                value: 'Valley',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: const Text('Valley'),
                            ),
                          ],
                        ),
                      )
                    ]),
                  ),
                  Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              Navigator.pop(context);
                            });
                          },
                          child: const Text('CANCEL')),
                      TextButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context)
                              ..removeCurrentMaterialBanner()
                              ..showMaterialBanner(showBanner(context));
                          },
                          child: const Text('OK'))
                    ],
                  )
                ],
              );
              showDialog(
                  context: context,
                  builder: (context) {
                    return dialog;
                  });
            },
            trailing: Switch(
              value: isSwitched,
              activeColor: Colors.blue,
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
          )
        ]),
      ),
    );
  }

  showBanner(BuildContext context) {
    return MaterialBanner(
      backgroundColor: Colors.indigo,
      content: const Text(
        'Luna',
        style: TextStyle(color: Colors.white),
      ),
      leading: const Icon(
        Icons.phone,
        color: Colors.white,
      ),
      actions: [
        TextButton(
            onPressed: () {
              var snackBar = SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 5),
                content: Text("Ringtone $phring berhasil diterapkan"),
              );
              setState(() {
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              });
            },
            child: const Text(
              'UPDATE',
              style: TextStyle(color: Colors.white),
            )),
        TextButton(
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
          },
          child: const Text('DISMISS', style: TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
