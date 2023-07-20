import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/navigation_provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/order_provider.dart';
import 'package:b_kreazi/providers/user_provider.dart';
import 'package:b_kreazi/providers/notification_provider.dart';
import 'package:b_kreazi/providers/officialmenu_provider.dart';
import 'package:b_kreazi/providers/creation_provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';
import 'package:b_kreazi/screens/home_screen.dart';
import 'package:b_kreazi/screens/creation_screen.dart';
import 'package:b_kreazi/screens/order_screen.dart';
import 'package:b_kreazi/pages/user_profile.dart';
import 'package:b_kreazi/pages/all_menu.dart';
import 'package:b_kreazi/pages/notifications.dart';
import 'package:b_kreazi/pages/my_kreazi.dart';
import 'package:b_kreazi/pages/login_page.dart';
import 'package:b_kreazi/pages/about_us.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ChangeNotifierProvider(create: (_) => BurgerProvider()),
      ChangeNotifierProvider(create: (_) => OrderProvider()),
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => NotificationProvider()),
      ChangeNotifierProvider(create: (_) => OfficialMenuProvider()),
      ChangeNotifierProvider(create: (_) => CreationProvider()),
      ChangeNotifierProvider(create: (_) => LoginProvider()),
    ],
    child: const MyApp()
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'B_Kreazi',
      theme: ThemeData(
        primarySwatch: myCustomColor(),
        sliderTheme: const SliderThemeData(valueIndicatorTextStyle: TextStyle(color: Colors.white)),
        fontFamily: 'Gill Sans MT',
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String searchVal = '';
  TextEditingController searchCtrl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final provNav = Provider.of<NavigationProvider>(context);
    final provUser = Provider.of<UserProvider>(context);
    final provNotif = Provider.of<NotificationProvider>(context);
    final provOrder = Provider.of<OrderProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);
    final provBurger = Provider.of<BurgerProvider>(context);
    final List pages = [
      const Home(title: 'B_Kreazi'),
      Creation(title: 'Creation', search: searchVal,),
      const OrderScreen(title: 'Pesanan'),
    ];

    return Scaffold(
      appBar: AppBar(
        title: provNav.currentIndex == 1? 
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: 0.5, color: myCustomDarkerColor()),
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: TextField(
              controller: searchCtrl,
              onChanged: (val) {
                setState(() {
                  searchVal = '';                  
                });
              },
              onSubmitted: (val) {
                setState(() {
                  searchVal = val.trim().toLowerCase();
                });
              },
              decoration: InputDecoration(
                icon: const Icon(Icons.search_rounded),
                suffixIcon: searchCtrl.text.isEmpty? null : 
                  IconButton(icon: const Icon(Icons.clear_rounded), 
                  splashRadius: 5,
                    onPressed: () {
                      setState(() {
                        searchCtrl.text = '';
                        searchVal = '';
                      });
                    },
                  ),
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Cari Kreazi ...',
                hintStyle: const TextStyle(fontSize: 18),
              ),
              style: const TextStyle(fontSize: 17),
            ),
          )
        :
          Text(pages[provNav.currentIndex].title, style: const TextStyle(fontWeight: FontWeight.bold),),
        actions: [
          if (provNav.currentIndex != 1)
            IconButton(
              // splashRadius: 20,
              tooltip: 'Cari Kreazi',
              onPressed: () {
                provNav.currentIndex = 1;
              }, 
              icon: const Icon(Icons.search_rounded)
            ),
          const SizedBox(width: 10,)
        ],
      ),
      drawer: Drawer(
        semanticLabel: 'Menu',
        child: ListView(
          children: [
            DrawerHeader(
              padding: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(color: myCustomColor()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset('assets/B_Kreazi.png', width: 100,),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30,
                          // child: ClipOval(child: Image.asset('assets/pics.jpg', fit: BoxFit.cover,)),
                          backgroundColor: provUser.userInfo.isNotEmpty? provUser.img == null? provUser.userInfo['Gender'] == 'Laki-Laki'? Colors.blue : Colors.pink : Colors.black54 : null,
                          child: provUser.img == null? Text(provUser.userInfo.isEmpty? '?' : provUser.userInfo['Nama'][0], style:  const TextStyle(fontSize: 30, color: Colors.white),) : ClipOval(child: Image.file(File(provUser.img!.path), width: 60, height: 60, fit: BoxFit.cover,))
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(provUser.userInfo.isEmpty? 'username' : provUser.userInfo['Nama'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
                              Text(provUser.userInfo.isEmpty? 'phone number' : provUser.userInfo['No HP'], style: const TextStyle(color: Colors.white),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ),
            ListTile(
              leading: const Icon(Icons.flash_on_rounded),
              title: const Text('Pesan cepat', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Langsung ke halaman Custom Burger'),
              trailing: Switch(
                value: provOrder.quickOrder, 
                onChanged: (val) => provOrder.quickOrder = val,
                activeColor: myCustomColor(),
                activeTrackColor: myCustomColor()[200],
              ),
              onTap: () {
                provOrder.quickOrder = !provOrder.quickOrder;
              },
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const UserProfile(title: 'Profil Pengguna',)));
              },
              leading: const Icon(Icons.person_rounded),
              title: const Text('Profil Pengguna', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Lihat, Edit detail informasi pribadi'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AllMenu(title: 'Menu Official',)));
              },
              leading: const Icon(Icons.flatware_rounded),
              title: const Text('Menu', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Daftar menu original B_Kreazi'),
            ),
            ListTile(
              onTap: () {
                provNotif.changeNotifType = 'Semua';
                provNotif.showUnreadOnly = false;
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications(title: 'Notifikasi',)));
              },
              leading: provNotif.allNotif.where((notif) => notif['read']==false).isEmpty?
              const Icon(Icons.notifications_none_rounded) : 
              Stack(
                alignment: Alignment.topRight,
                children: [
                  provNotif.allNotif.where((notif) => notif['read']==false).isEmpty? 
                  const Icon(Icons.notifications_none_rounded) :
                  CircleAvatar(
                    radius: 6.75,
                    backgroundColor: myCustomDarkerColor(),
                    child: Text(provNotif.allNotif.where((notif) => notif['read']==false).length.toString(), style: const TextStyle(fontSize: 10, color: Colors.white),),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 5),
                    child: Icon(Icons.notifications_none_rounded),
                  ),
                ],
              ),
              title: const Text('Notifikasi', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Pengingat pesananmu'),
            ),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MyKreazi()));
              },
              leading: const Icon(Icons.emoji_objects_outlined),
              title: const Text('Kreazi-ku', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Kreazi saya, Kreazi Favorit'),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutUs()));
              },
              leading: const Icon(Icons.business_rounded),
              title: const Text('About Us', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Tentang kami'),
            ),
            provLogin.isLoggedIn? 
            ListTile(
              onTap: () {
                // provLogin.loggedOut();
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Keluar dari Akun Kreazi', style: TextStyle(fontWeight: FontWeight.bold),),
                      content: const Text('Anda akan Log Out dari akun Kreazi Anda. Tetap tinggalkan data profile Anda?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          child: const Text('Batalkan')
                        ),
                        TextButton(
                          onPressed: () {
                            provLogin.loggedOut();
                            provBurger.changePembayaran = 'Pilih';
                            Navigator.pop(context);
                          }, 
                          child: const Text('Keluar saja')
                        ),
                        TextButton(
                          onPressed: () {
                            provUser.clearUser();
                            provUser.img = null;
                            provUser.isImageLoaded = false;
                            provBurger.resetContactInfo();
                            provBurger.changePembayaran = 'Pilih';
                            provBurger.saveUser = true;
                            provLogin.loggedOut();
                            provBurger.nama.text = '';
                            provBurger.noHp.text = '';
                            provBurger.changeGender = '';
                            provUser.nama.text = '';
                            provUser.noHp.text = '';
                            provUser.changeGender = 'Laki-Laki';
                            Navigator.pop(context);
                          }, 
                          child: const Text('Hapus data')
                        )
                      ],
                    );
                  }
                );
              },
              leading: const Icon(Icons.logout_rounded),
              title: const Text('Log Out', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Keluar'),
            ) :
            ListTile(
              onTap: () {
                provLogin.resetAll();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              leading: const Icon(Icons.login),
              title: const Text('Log In', style: TextStyle(fontSize: 16),),
              subtitle: const Text('Masuk ke akun Kreazi Anda'),
            ),
          ],
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: pages[provNav.currentIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: myCustomDarkerColor(),
        onTap: (val) {
          provNav.currentIndex = val;
        },
        currentIndex: provNav.currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined), 
            activeIcon: Icon(Icons.house_rounded),
            label: 'Home', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb_outline_rounded), 
            activeIcon: Icon(Icons.tips_and_updates_rounded),
            label: 'Creation', 
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_rounded), 
            activeIcon: Icon(Icons.receipt_rounded),
            label: 'Order', 
          ),
        ],
      ),
    );
  }
}