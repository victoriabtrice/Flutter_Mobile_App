import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/login_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';
import 'package:baloonblooms/components/minggu15.dart';
import 'package:baloonblooms/screens/minggu4.dart';
import 'package:baloonblooms/screens/minggu6.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LoginProvider>(context);
    
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(    // space utk header Drawer
            padding: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(color: myCustomColor()[500]),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 0.5),
                    color: myCustomColor()[500]
                  ),
                  width: 60,
                  height: 60,
                  child: CircleAvatar(child: Image.asset('assets/flower.png', fit: BoxFit.cover,))
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(prov.userInfo['fullname'], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20), overflow: TextOverflow.ellipsis,),
                      Text(prov.userInfo['username'], style: const TextStyle(color: Colors.white, fontSize: 17), overflow: TextOverflow.ellipsis,),
                      Text(prov.userInfo['usermail']=='-'? prov.userInfo['userphone'] : prov.userInfo['usermail'], style: const TextStyle(color: Colors.white), overflow: TextOverflow.ellipsis,),
                    ],
                  ),
                )
              ],
            )
          ),
          ListTile(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Wishlist(title: 'Wishlist',)));
            },
            leading: const Icon(Icons.favorite_rounded),
            title: const Text('Wishlist'),
          ),
          ListTile(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const Notifications(title: 'Notifikasi',)));
            },
            leading: const Icon(Icons.notifications_rounded),
            title: const Text('Notification'),
          ),
          ListTile(
            onTap: () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const WebViewInstagram()));
            },
            leading: const Icon(FontAwesomeIcons.instagram),
            title: const Text('Social Media'),
          ),
          ListTile(
            onTap: prov.userInfo['username']=='-'? () {
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginTabBar()));
            } : () {
              prov.logout();
            },
            leading: Icon(prov.userInfo['username']=='-'? Icons.login_rounded : Icons.logout_rounded),
            title: Text(prov.userInfo['username']=='-'? 'Sign Up' : 'Log Out'),
          ),
        ],
      ),
    );
  }
}

class LoginTabBar extends StatefulWidget {
  const LoginTabBar({super.key});

  @override
  State<LoginTabBar> createState() => _LoginTabBarState();
}

class _LoginTabBarState extends State<LoginTabBar> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<LoginProvider>(context);

    tabBody(TextField sisipan, ElevatedButton loginCheck) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: prov.username,
              decoration: InputDecoration(
                icon: const Icon(Icons.person),
                hintText: 'Username Anda disini',
                label: const Text('Username'),
                errorText: prov.status != 'new' && prov.username.text.trim().isEmpty? 'Wajib diisi' : prov.username.text.trim().toLowerCase() == '-'? 'Username invalid' : null
              ),
              maxLength: 15,
              inputFormatters: [
                FilteringTextInputFormatter.deny(' ')
              ],
            ),
            TextField(
              controller: prov.fullname,
              decoration: InputDecoration(
                icon: const Icon(Icons.card_membership_rounded),
                hintText: 'Nama Lengkap Anda disini',
                label: const Text('Fullname'),
                errorText: prov.status != 'new' && prov.fullname.text.trim().isEmpty? 'Wajib diisi' : prov.fullname.text.trim().toLowerCase() == '-'? 'Fullname invalid' : null
              ),
              maxLength: 17,
            ),
            sisipan,
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      prov.logout();
                    }, 
                    child: const Text('Batal')
                  ),
                  loginCheck
                ],
              ),
            )
          ],
        ),
      );
    }

    return DefaultTabController(
      length: 2, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          actions: [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context, 
                  builder: (BuildContext sheetCtx) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(20, 25, 20, 50),
                      child: Text('Data ini akan dipakai saat Anda melakukan pemesanan nantinya. Anda hanya perlu memilih salah satu opsi kontak agar kami dapat menghubungi Anda jika dibutuhkan.', style: TextStyle(fontSize: 16.5), textAlign: TextAlign.justify,),
                    );
                  }
                );
              },
              icon: const Icon(Icons.help_outline_rounded),
            ),
            const Padding(padding: EdgeInsets.only(right: 10))
          ],
          bottom: TabBar(
            onTap: (val) {
              prov.activeTab = val;
            },
            indicatorColor: myCustomColor(),
            tabs: const [
              Tab(text: 'No HP',),
              Tab(text: 'Email',)
            ]
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: TabBarView(
            children: [
              tabBody(
                TextField(
                  controller: prov.userphone,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.call_rounded),
                    hintText: 'No Hp Anda disini',
                    label: const Text('Phone Number'),
                    errorText: prov.status != 'new' && prov.userphone.text.trim().isEmpty? 'Wajib diisi' : null
                  ),
                  maxLength: 15,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[0-9*#+]'))
                  ],
                  keyboardType: TextInputType.phone,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (prov.activeTab==0 && (prov.username.text.trim().isEmpty || prov.fullname.text.trim().isEmpty || prov.userphone.text.trim().isEmpty || prov.username.text.trim().toLowerCase() == '-' || prov.fullname.text.trim().toLowerCase() == '-')) {
                      prov.status = 'invalid';
                    }
                    else if (prov.activeTab==0) {
                      prov.login = {
                        'username' : prov.username.text.trim(),
                        'fullname' : prov.fullname.text.trim(),
                        'userphone' : prov.userphone.text.trim(),
                        'usermail' : '-',
                      };
                      Navigator.pop(context);
                    }
                  }, 
                  child: const Text('Sign Up')
                )
              ),
              tabBody(
                TextField(
                  controller: prov.usermail,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email_rounded),
                    hintText: 'Email Anda disini',
                    label: const Text('Email'),
                    errorText: prov.status != 'new' && prov.usermail.text.trim().isEmpty? 'Wajib diisi' : prov.status != 'new' && !prov.usermail.text.contains('@')? 'Email invalid' : null
                  ),
                  maxLength: 25,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'[a-z0-9@._]'))
                  ],
                  keyboardType: TextInputType.emailAddress,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (prov.activeTab==1 && (prov.username.text.trim().isEmpty || prov.fullname.text.trim().isEmpty || prov.usermail.text.trim().isEmpty || prov.username.text.trim().toLowerCase() == '-' || prov.fullname.text.trim().toLowerCase() == '-' || !prov.usermail.text.contains('@'))) {
                      prov.status = 'invalid';
                    }
                    else if (prov.activeTab==1) {
                      prov.login = {
                        'username' : prov.username.text.trim(),
                        'fullname' : prov.fullname.text.trim(),
                        'userphone' : '-',
                        'usermail' : prov.usermail.text.trim()
                      };
                      Navigator.pop(context);
                    }
                  }, 
                  child: const Text('Sign Up')
                )
              ),
            ],
          ),
        ),
      )
    );
  }
}