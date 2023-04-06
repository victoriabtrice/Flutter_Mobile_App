import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_application_1/pertemuan05_provider.dart';

class Pertemuan05Screen extends StatefulWidget {
  const Pertemuan05Screen({Key? key}): super(key: key);

  @override
  State<Pertemuan05Screen> createState() => _Pertemuan05ScreenState();
}

class _Pertemuan05ScreenState extends State<Pertemuan05Screen> {
  //Status soal 1
  bool? soal1a = false;
  bool? soal1b = false;

  //Status soal 2
  String soal2 = 'answ';

  //Status pilih kelas
  bool kelasPagi = false;
  bool kelasSiang = false;

  // //Status pilih minat
  // String check = '';
  // void _res() {
  //   if(Provider.of<Pertemuan05Provider>(context).statusTKJ == true){
  //     check = 'TKJ';
  //   }
  //   else if (Provider.of<Pertemuan05Provider>(context).statusRPL == true){
  //     check = 'RPL';
  //   }
  //   else if (Provider.of<Pertemuan05Provider>(context).statusSMA == true){
  //     check = 'SMA';
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // class ini menggunakan provider pertemuan05provider
    final prov = Provider.of<Pertemuan05Provider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('title')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Soal 1: Menggunakan Checkbox
              const Text('1. Memori yang berfungsi untuk tempat penyimpanan data sementara disebut..'),
              Row(
                children: [
                  const Text('a.'),
                  const SizedBox(width: 5),
                  Checkbox(
                    value: soal1a, 
                    onChanged: (val){
                      setState(() {
                        soal1a = val;
                      });
                    }
                  ),
                  const Text('RAM'),
                ],
              ),
              Row(
                children: [
                  const Text('b.'),
                  const SizedBox(width: 5),
                  Checkbox(
                    value: soal1b, 
                    onChanged: (val) {
                      setState(() {
                        soal1b = val;
                      });
                    }
                  ),
                  const Text('Random Access Memory')
                ],
              ),

              //Respon Jawaban Soal1
              if(soal1a == false && soal1b == false)
                Container()
              else if(soal1a == true && soal1b == true)
                const Text('')
              else 
                const Text('Jawaban masih salah, coba lagi', style: TextStyle(color: Colors.red),),
              const Divider(),
              //Soal 2: Menggunakan Checkbox
              const Text('2. Skema desain pembangunan jaringan disebut..'),
              Row(
                children: [
                  const Text('a.'),
                  const SizedBox(width: 5),
                  Radio(
                    value: 'topologi',
                    groupValue: soal2,
                    onChanged: (val){
                      setState(() {
                        soal2 = 'topologi';
                      });
                    },
                  ),
                  const Text('Topologi'),
                ],
              ),
              Row(
                children: [
                  const Text('b.'),
                  const SizedBox(width: 5),
                  Radio(
                    groupValue: soal2,
                    value: 'desain jaringan',
                    onChanged: (val) {
                      setState(() {
                        soal2 = 'desain jaringan';
                      });
                    },
                  ),
                  const Text('Desain Jaringan')
                ],
              ),

              //CheckJawaban
              if (soal2 == 'answ')
                Container()
              else if(soal2 == 'topologi')
                const Text('Benar!', style: TextStyle(color: Colors.green),)
              else
                const Text('Salah!', style: TextStyle(color: Colors.red),),
              //Chips
              //ChoiceChip
              const Divider(),
              const Text('Feedback Soal',),
              const Text('Kelas'),
              Row(
                children: [
                  ChoiceChip(
                    label: Text('Pagi'), 
                    selectedColor: Colors.blue[200],
                    selected: kelasPagi,
                    onSelected: (val){
                      setState(() {
                        kelasPagi = val;
                      });
                    },
                  ),
                  const SizedBox(width: 5),
                  ChoiceChip(
                    label: Text('Siang'), 
                    selectedColor: Colors.blue[200],
                    selected: kelasSiang,
                    onSelected: (val){
                      setState(() {
                        kelasSiang = val;
                      });
                    },
                  )
                ],
              ),
              const Text('Soal di atas telah dipelajari saat?..'),
              Row(
                children: [
                  FilterChip(
                    label: Text('Sekolah'), 
                    // atur color disini
                    selectedColor: Colors.blue[200],
                    selected: prov.statusSekolah,
                    onSelected: (val) {
                      prov.setSekolah = val;
                    }
                  ),
                  const SizedBox(width: 5),
                  FilterChip(
                    label: Text('Praktikum'), 
                    selected: prov.statusPraktik,
                    onSelected: (val) {
                      prov.setPraktik = val;
                    }
                  ),
                  const SizedBox(width: 5),
                  FilterChip(
                    label: Text('Kursus'),
                    selected: prov.statusKursus,
                    onSelected: (val) {
                      prov.setKursus = val;
                    },
                  )
                ],
              ),

              //InputChip
              const Text('Peminatan saat sekolah?'),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(context.watch<Pertemuan05Provider>().bag.toString()),
                    ),
                    // letakkan chip terpilih disini
                    // atur state
                  ]
                ),
              ),
              Row(
                children: [
                  InputChip(
                    label: Text('TKJ'),
                    selectedColor: Colors.blue[200],
                    selected: prov.statusTKJ,
                    // onPressed: _res,
                    onSelected: (val) {
                      print(val);
                      prov.setTKJ = val;
                      // atur state
                      context.read<Pertemuan05Provider>().setTKJStatus = true;
                      if(prov.setTKJ = prov.statusTKJ){
                        context.read<Pertemuan05Provider>().isiBag = 'TKJ';
                      }
                      else {
                        context.read<Pertemuan05Provider>().removeBag = 'TKJ';
                      }
                      
                    },
                  ),
                  SizedBox(width: 5),
                  InputChip(
                    label: Text('RPL'),
                    selectedColor: Colors.blue[200],
                    selected: prov.statusRPL,
                    // onPressed: _res,
                    onSelected: (val){
                      print(val);
                      prov.setRPL = val;
                      // atur state
                      context.read<Pertemuan05Provider>().setRPLStatus = true;
                      if(prov.setRPL = prov.statusRPL){
                        context.read<Pertemuan05Provider>().isiBag = 'RPL';                      }
                      else {
                        context.read<Pertemuan05Provider>().removeBag = 'RPL';
                      }
                    },
                  ),
                  SizedBox(width: 5),
                  InputChip(
                    label: Text('SMA'),
                    selected: prov.statusSMA,
                    selectedColor: Colors.blue[200],
                    // onPressed: _res,
                    onSelected: (val) {
                      print(val);
                      prov.setSMA = val;
                      // atur state
                      context.read<Pertemuan05Provider>().setSMAStatus = true;
                      if(prov.setSMA = prov.statusSMA){
                        context.read<Pertemuan05Provider>().isiBag = 'SMA';
                      }
                      else {
                        context.read<Pertemuan05Provider>().removeBag = 'SMA';
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
