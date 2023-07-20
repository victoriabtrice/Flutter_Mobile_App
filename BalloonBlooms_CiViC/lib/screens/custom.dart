import 'dart:io';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/custom_provider.dart';
import 'package:baloonblooms/providers/login_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';
import 'package:baloonblooms/components/minggu13.dart';
import 'package:baloonblooms/components/minggu14.dart';
import 'package:baloonblooms/components/minggu15.dart';
import 'package:baloonblooms/screens/image.dart';

class CustomProduct extends StatefulWidget {
  const CustomProduct({super.key, required this.reference});

  final Map reference;

  @override
  State<CustomProduct> createState() => _CustomProductState();
}

class _CustomProductState extends State<CustomProduct> {
  @override
  Widget build(BuildContext context) {

    final provCustom = Provider.of<CustomProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);

    tag(String str) {
      return Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.fromLTRB(8, 10, 8, 8),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: myCustomColor()[400],
        ),
        child: Text(str, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19),),
      );
    }

    smallTag(String str) {
      return Container(
        padding: const EdgeInsets.all(2),
        margin: const EdgeInsets.fromLTRB(12, 8, 5, 5),
        child: Text(str, style: TextStyle(backgroundColor: myCustomColor()[100], fontSize: 17.5),),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom the way u like!'),
      ),
      body: ListView(
        children: [
          tag('REFERENCE'),
          Card(
            elevation: 5,
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Wrap(
                children: [
                  Image.asset('assets/${widget.reference['code']}.jpg', width: MediaQuery.of(context).size.width/3, height: MediaQuery.of(context).size.width/2.6, fit: BoxFit.cover,),
                  const SizedBox(width: 10,),
                  LayoutBuilder(   // biar ukuran ikut parent
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: constraints.maxWidth/1.9,
                            child: Text(widget.reference['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18.5),)
                          ),
                          const SizedBox(height: 2,),
                          Text('Rp. ${widget.reference['price']~/1000}.000,-', style: const TextStyle(fontSize: 16),),
                          const SizedBox(height: 5,),
                          const Text('Include :'),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: widget.reference['include'].map<Widget>((include) {
                              return Container(
                                padding: const EdgeInsets.only(left: 12),
                                width: constraints.maxWidth/1.9,
                                child: Text('° $include'),
                              );
                            }).toList(),
                          ),
                        ],
                      );
                    }
                  ),
                ],
              ),
            ),
          ),
          tag('CUSTOMIZATION'),
          smallTag('BALLOON'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 8),
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Type :', style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Color :', style: TextStyle(fontSize: 16)),
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: DropdownButtonFormField(
                        value: provCustom.balloon,
                        onChanged: (val) => provCustom.balloon = val,
                        items: [ 
                          const DropdownMenuItem(value: 'Choose Type', enabled: false, child: Text('Choose Type', style: TextStyle(color: Colors.black26),)),
                          for (var tipe in provCustom.ballType) DropdownMenuItem(value: tipe, child: Text(tipe)) 
                          ],
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text('Balloon Type'),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.only(left: 8)),
                        elevation: 2,
                        style: const TextStyle(fontSize: 17, color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: DropdownButtonFormField(
                        value: provCustom.bColor,
                        onChanged: (val) => provCustom.bColor = val,
                        items: [ 
                          const DropdownMenuItem(value: 'Choose Color', enabled: false, child: Text('Choose Color', style: TextStyle(color: Colors.black26),)),
                          for (var col in provCustom.colors) DropdownMenuItem(value: col, child: Text(col)) 
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text('Balloon Color'),
                        elevation: 2,
                        style: const TextStyle(fontSize: 17, color: Colors.black54),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.only(left: 8)),
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
          smallTag('RIBBON'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 10, 8),
            child: Table(
              defaultColumnWidth: const IntrinsicColumnWidth(),
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                const TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Type :', style: TextStyle(fontSize: 16),),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5),
                      child: Text('Color :', style: TextStyle(fontSize: 16)),
                    ),
                  ]
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: DropdownButtonFormField(
                        value: provCustom.ribbon,
                        onChanged: (val) => provCustom.ribbon = val,
                        items: [ 
                          const DropdownMenuItem(value: 'Choose Type', enabled: false, child: Text('Choose Type', style: TextStyle(color: Colors.black26),)),
                          for (var type in provCustom.ribType) DropdownMenuItem(value: type, child: Text(type)) 
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text('Ribbon Type'),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.only(left: 8)),
                        elevation: 2,
                        style: const TextStyle(fontSize: 17, color: Colors.black54),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 10, 0),
                      child: DropdownButtonFormField(
                        value: provCustom.rColor,
                        onChanged: (val) => provCustom.rColor = val,
                        items: [ 
                          const DropdownMenuItem(value: 'Choose Color', enabled: false, child: Text('Choose Color', style: TextStyle(color: Colors.black26),)),
                          for (var col in provCustom.colors) DropdownMenuItem(value: col, child: Text(col)) 
                        ],
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        icon: const Icon(Icons.keyboard_arrow_down),
                        hint: const Text('Ribbon Color'),
                        elevation: 2,
                        style: const TextStyle(fontSize: 17, color: Colors.black54),
                        decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.only(left: 8)),
                      ),
                    ),
                  ],
                ),
              ]
            ),
          ),
          smallTag('ACCESSORIES'),
          const SnackBudget(),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 5),
            child: TextField(
              controller: provCustom.accNotes,
              maxLines: 2,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: 'Write your notes here ...',
              ),
            ),
          ),
          smallTag('CELLOPHANE'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 5),
            child: Row(
              children: [
                const Text('Color :'),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButtonFormField(
                      value: provCustom.cellophane,
                      onChanged: (val) => provCustom.cellophane = val,
                      items: [ 
                        const DropdownMenuItem(value: 'Choose Color', enabled: false, child: Text('Choose Color', style: TextStyle(color: Colors.black26),)),
                        for (var cello in provCustom.cellophanes) DropdownMenuItem(value: cello, child: Text(cello)) 
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      icon: const Icon(Icons.keyboard_arrow_down),
                      hint: const Text('Cellophane Color'),
                      elevation: 2,
                      style: const TextStyle(fontSize: 17, color: Colors.black54),
                      decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.only(left: 8)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          smallTag('CARD'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 2, 20, 5),
            child: TextField(
              controller: provCustom.cardNotes,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                hintText: 'Write your notes here ...',
              ),
            ),
          ),
          smallTag('PORTRAIT ART'),
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 5, 30, 8),
            child: 
            provCustom.isImageLoaded? 
            Tooltip(
              message: 'View Full Picture',
              child: GestureDetector(
                onTap: () => 
                Navigator.push(context, MaterialPageRoute(builder: (context) => ImageScreen(source: 'file', img: provCustom.img!.path,))),
                child: 
                Image.file(File(provCustom.img!.path), height: MediaQuery.of(context).size.width*0.5, fit: BoxFit.cover,)
              ),
            )
             : null,
          ),
          const PortraitArtImgPicker(),
          tag('CONTACT INFORMATION'),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: provLogin.username,
                    readOnly: provLogin.userInfo.toString() != {
                      'username'  : '-',
                      'fullname'  : '-',
                      'userphone' : '-',
                      'usermail'  : '-'
                    }.toString(),
                    decoration: InputDecoration(
                      hintText: 'ballonblooms',
                      labelText: 'Username',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    maxLength: 15,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(' ')
                    ],
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: provLogin.fullname,
                    decoration: InputDecoration(
                      hintText: 'Balloon Blooms',
                      labelText: 'Fullname',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    maxLength: 17,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: provLogin.userphone,
                    decoration: InputDecoration(
                      hintText: '082103470515',
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    maxLength: 15,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9*#+]'))
                    ],
                    keyboardType: TextInputType.phone,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: provLogin.usermail,
                    decoration: InputDecoration(
                      hintText: 'blommers@civic.com',
                      labelText: 'Email',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    maxLength: 25,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@._]'))
                    ],
                    keyboardType: TextInputType.emailAddress,
                  )
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: TextField(
                    controller: provCustom.address,
                    decoration: InputDecoration(
                      hintText: 'Jalan road Gang alley No 111',
                      labelText: 'Address',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    maxLength: 50,
                  )
                ),
                const DateTimePicker(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}