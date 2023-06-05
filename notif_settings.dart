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
        child: Column(
          children: [
            ListTile(
              title: Text('Ringtone'),
              subtitle: Text(phring == 'Luna' ? 'Luna' : 'None'),
              onTap: (){
                var dialog = SimpleDialog(
                  title: const Text('Phone Ringtone'),
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SimpleDialogOption(
                            child: ListTile(
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
                              title: Text('None'),
                            ),
                          ),
                          SimpleDialogOption(
                            child: ListTile(
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
                              title: Text('Callisto'),
                            ),
                          ),
                          SimpleDialogOption(
                            child: ListTile(
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
                              title: Text('Ganymede'),
                            ),
                          ),
                          SimpleDialogOption(
                            child: ListTile(
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
                              title: Text('Luna'),
                            ),
                          ),
                          SimpleDialogOption(
                            child: ListTile(
                              leading: Radio(
                                value: 'XXXX',
                                activeColor: Colors.blue,
                                groupValue: phring,
                                onChanged: (value) {
                                  setState(() {
                                    phring = value!;
                                  });
                                },
                              ),
                              title: Text('XXXX'),
                            ),
                          )
                        ]
                      ),
                    ),
                    Row(
                      children: [
                        // Elevated Button
                      ],
                    )
                  ],
                );
                showDialog(context: context, builder: (context){return dialog;});
              },
              trailing: Switch(
                value: isSwitched,
                activeColor: Colors.green,
                onChanged: (value){
                  setState(() {
                    isSwitched = value;
                  });
                },
              ),
            )
          ]
        ),
      ),
    );
  }
}