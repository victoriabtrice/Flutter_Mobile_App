import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/providers/user_provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final provLogin = Provider.of<LoginProvider>(context);
    final provUser = Provider.of<UserProvider>(context);
    final provBurger = Provider.of<BurgerProvider>(context);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Your Kreazi Account'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
        children: [
          Image.asset('assets/B_Kreazi.png', width: 100, height: 50,),
          const SizedBox(height: 25,),
          TextField(
            controller: provUser.nama,
            onChanged: (val) {
              provLogin.status = 'process';
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: const Icon(Icons.card_membership_rounded),
              hintText: 'Nama Anda',
              labelText: 'Fullname',
              errorText: provLogin.status == 'not ok'? provUser.nama.text.isEmpty? 'Wajib Diisi' : null : null
            ),
            maxLength: 20,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-z A-Z]'))
            ],
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: provUser.noHp,
            onChanged: (val) {
              provLogin.status = 'process';
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: const Icon(Icons.phone_rounded),
              hintText: 'Nomor telepon Anda',
              labelText: 'Phone number',
              errorText: provLogin.status == 'not ok'? provUser.noHp.text.isEmpty? 'Wajib Diisi' : provUser.noHp.text.length < 8? 'Minimal 8 digit' : null : null
            ),
            maxLength: 15,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9*#+]'))
            ],
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 10,),
          Row(
            children: [
              const Icon(Icons.wc_rounded, color: Colors.black45,),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 8),
                  child: DropdownButtonFormField(
                    items: const  [
                      DropdownMenuItem(value: 'Laki-Laki', child: Text('Laki-Laki'),),
                      DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan'),),
                    ], 
                    value: provUser.gender,
                    onChanged: (val) {
                      provUser.changeGender = val;
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      labelText: 'Gender',
                    ),
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: provLogin.username,
            onChanged: (val) {
              provLogin.status = 'process';
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: const Icon(Icons.person),
              hintText: 'kombinasi huruf kecil dan angka; tanpa spasi',
              label: const Text('Username'),
              errorText: provLogin.status == 'not ok'? provLogin.username.text.trim().isEmpty? 'Wajib diisi' : provLogin.username.text.trim().length < 5? 'Minimal 5 karakter' : provLogin.database.toString().contains("username: ${provLogin.username.text},")? 'Username terdaftar' : null : null
            ),
            maxLength: 15,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[a-z_0-9]'))
            ],
          ),
          const SizedBox(height: 10,),
          TextField(
            controller: provLogin.password,
            obscureText: !provLogin.showPass,
            obscuringCharacter: '*',
            onChanged: (val) {
              provLogin.status = 'process';
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
              icon: const Icon(Icons.password_rounded),
              hintText: 'minimal 6 karakter',
              label: const Text('Password'),
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: IconButton(
                  onPressed: () => provLogin.showOrHide(), 
                  splashRadius: 20,
                  icon: Icon(provLogin.showPass? Icons.visibility_outlined : Icons.visibility_off_outlined)),
              ),
              errorText: provLogin.status == 'not ok'? provLogin.password.text.trim().isEmpty? 'Wajib diisi' : provLogin.password.text.trim().length < 6? 'Minimal 6 karakter' : null : null
            ),
            maxLength: 20,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r' ')),
            ],
          ),
          const SizedBox(height: 30,),
          ElevatedButton(
            onPressed: provUser.nama.text.trim().isEmpty || provUser.noHp.text.trim().isEmpty || provLogin.username.text.trim().isEmpty || provLogin.password.text.trim().isEmpty ? null : () {
              if (provLogin.username.text.length >= 5 && provLogin.password.text.length >= 6 && !provLogin.database.toString().contains("username: ${provLogin.username.text},")) {
                provLogin.status = 'new';
                final Map dataUser = {
                  'username' : provLogin.username.text.trim(), 
                  'password' : provLogin.password.text.trim(), 
                  'fullname' : provUser.nama.text.trim(), 
                  'phone' : provUser.noHp.text.trim(),
                  'gender' : provUser.gender,
                };
                provLogin.addUser = dataUser;
                provLogin.loggedIn();
                final userInfo = {
                  'Nama' : dataUser['fullname'],
                  'No HP' : dataUser['phone'],
                  'Gender' : dataUser['gender']
                };
                provBurger.userInfo = userInfo;
                provUser.saveUser = userInfo;
                provBurger.nama.text = dataUser['username'];
                provBurger.noHp.text = dataUser['phone'];
                provBurger.changeGender = dataUser['gender'];
                Navigator.popUntil(context, (route) => route.isFirst);
              }
              else {
                provLogin.status = 'not ok';
              }
            }, 
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Daftarkan', style: TextStyle(fontSize: 17),),
            )
          ),
          const SizedBox(height: 8,),
          OutlinedButton(
            onPressed: () {
              Navigator.pop(context);
            }, 
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text('Batal', style: TextStyle(fontSize: 17),),
            )
          )
        ],
      ),
    );
  }
}