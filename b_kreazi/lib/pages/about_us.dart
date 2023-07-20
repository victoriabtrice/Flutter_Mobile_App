import 'dart:math';
import 'package:b_kreazi/pages/webview_about_us.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:b_kreazi/components/custom_color.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors:[Colors.white, myCustomColor()],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('About Us - CiViC'),
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset('assets/B_Kreazi.png', width: 150,),
              ),
              Divider(
                indent: 20, 
                endIndent: 20, 
                height: 30, 
                thickness: 2, 
                color: myCustomDarkerColor(),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Text('B_Kreazi mulai beroperasi di Indonesia pada tahun 2023 dibawah naungan grup CiViC. Saat ini, pelanggan di seluruh kota dapat menikmati kehangatan burger yang kami sajikan.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.5),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: myCustomColor(),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                  child: const Text('MISI KAMI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 25),
                child: Text('Memberikan pengalaman yang unik dan berkesan kepada pelanggan kami dengan pemilihan bahan makanan sesuai selera dan keinginan mereka setiap kali mereka berkunjung ke tempat kami.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.5),),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: myCustomColor(),
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
                  child: const Text('VISI KAMI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 25),
                child: Text('Setiap pelanggan yang berkunjung maupun yang memesan dapat tersenyum dan memiliki suasana hati yang lebih baik melalui penggunaan barang dan jasa yang kami sediakan', textAlign: TextAlign.justify, style: TextStyle(fontSize: 16.5),),
              ),
              // Container(
              //   decoration: const BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.all(Radius.elliptical(1000, 100)),
              //     gradient: RadialGradient(
              //       colors: [Colors.white, Color.fromRGBO(255, 255, 255, 0)],
              //       radius: 8,
              //     )
              //   ),
              //   width: MediaQuery.of(context).size.width*0.9,
              //   height: 30,
              //   alignment: Alignment.center,
              //   child: const Text('TIM KAMI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
              // ),
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/base-label.png'),
                  const Text('TIM KAMI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                ],
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                child: Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Image.asset('assets/burger-card.png'),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/cindy.jpg', 
                                width: MediaQuery.of(context).size.width>=430? MediaQuery.of(context).size.width*0.25 : MediaQuery.of(context).size.width*0.7,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Cindy Sintiya', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                                  Text('App Developer & Project Manager', style: TextStyle(color: myCustomColor()),),
                                  const SizedBox(height: 8,),
                                  const Text('Bussiness Hours :', style: TextStyle(fontSize: 15.5),),
                                  const Text('Mon - Fri: 10:00 AM - 8:00 PM', style: TextStyle(fontSize: 15.5),),
                                  const Text('Saturday : 10:00 AM - 6:PM', style: TextStyle(fontSize: 15.5),),
                                  const SizedBox(height: 8,),
                                  TextButton.icon(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      iconColor: MaterialStatePropertyAll(Colors.black),
                                      padding: MaterialStatePropertyAll(EdgeInsets.zero)
                                    ),
                                    icon: const Icon(Icons.email_outlined), 
                                    label: const Text('211110347@students.mikroskil.ac.id', style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),)
                                  ),
                                  TextButton.icon(
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewAboutUs(title: 'GitHub', url: 'https://github.com/cindysintiya/'))),
                                    style: const ButtonStyle(
                                      iconColor: MaterialStatePropertyAll(Colors.black),
                                      padding: MaterialStatePropertyAll(EdgeInsets.zero)
                                    ),
                                    icon: const Icon(FontAwesomeIcons.github), 
                                    label: const Text('https://github.com/cindysintiya/', style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),)
                                  )
                                ],
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Image.asset('assets/B_kreazi_ribbon.png')
                  ]
                ),
              ),
              Card(
                elevation: 5,
                margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        Transform(
                          alignment: Alignment.center,
                          transform: Matrix4.rotationY(pi),
                          child: Image.asset('assets/burger-card.png',),
                        ),
                        Wrap(
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          verticalDirection: VerticalDirection.up,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Victoria Beatrice', style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),),
                                  Text('App Developer & UI Designer', style: TextStyle(color: myCustomColor()),),
                                  const SizedBox(height: 8,),
                                  const Text('Bussiness Hours :', style: TextStyle(fontSize: 15.5),),
                                  const Text('Mon - Fri: 10:00 AM - 8:00 PM', style: TextStyle(fontSize: 15.5),),
                                  const Text('Saturday : 10:00 AM - 6:PM', style: TextStyle(fontSize: 15.5),),
                                  const SizedBox(height: 8,),
                                  TextButton.icon(
                                    onPressed: () {},
                                    style: const ButtonStyle(
                                      iconColor: MaterialStatePropertyAll(Colors.black),
                                      padding: MaterialStatePropertyAll(EdgeInsets.zero)
                                    ),
                                    icon: const Icon(Icons.email_outlined), 
                                    label: const Text('211110515@students.mikroskil.ac.id', style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),)
                                  ),
                                  TextButton.icon(
                                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewAboutUs(title: 'GitHub', url: 'https://github.com/victoriabtrice/'))),
                                    style: const ButtonStyle(
                                      iconColor: MaterialStatePropertyAll(Colors.black),
                                      padding: MaterialStatePropertyAll(EdgeInsets.zero)
                                    ),
                                    icon: const Icon(FontAwesomeIcons.github), 
                                    label: const Text('https://github.com/victoriabtrice/', style: TextStyle(decoration: TextDecoration.underline, color: Colors.black),)
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset(
                                'assets/VB_pic.png', 
                                width: MediaQuery.of(context).size.width>=430? MediaQuery.of(context).size.width*0.25 : MediaQuery.of(context).size.width*0.7,
                                height: 180,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationZ(pi/2),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset('assets/B_kreazi_ribbon.png'),
                      ),
                    ),
                  ]
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: myCustomLighterColor(),
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(8), topLeft: Radius.circular(8)),
                  ),
                  padding: const EdgeInsets.fromLTRB(15, 12, 20, 12),
                  child: const Text('LOKASI B_KREAZI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                ),
              ),
              Wrap(
                alignment: WrapAlignment.spaceBetween,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Image.asset('assets/location.png', width: 160,),
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text('Jl. Sukses No.1, Bahagia,\nKec. Hebat, Kota Maju,\nSumatera Utara 21012', style: TextStyle(fontSize: 16.5),),
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: myCustomDarkerColor(),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(top: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Expanded(child: Text('Terms & Conditions | Privacy Policy', style: TextStyle(color: Colors.white, fontSize: 8), overflow: TextOverflow.ellipsis,)),
                    SizedBox(width: 10,),
                    Text('TM & Copyright 2023 B_Kreazi Indonesia. All Rights Reserved.', style: TextStyle(color: Colors.white, fontSize: 8),),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}