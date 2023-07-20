import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:b_kreazi/providers/burger_provider.dart';
import 'package:b_kreazi/providers/user_provider.dart';
import 'package:b_kreazi/providers/login_provider.dart';
import 'package:b_kreazi/components/custom_color.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key, required this.title});

  final String title;

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {

    bottomSheets(BuildContext context) {
      final provUser = Provider.of<UserProvider>(context);
      return Builder(builder: (context) {
        return Tooltip(
          message: !provUser.edit? '' : 'Ganti Foto',
          child: InkWell(
            onTap: !provUser.edit? null : () {
              showModalBottomSheet(
                enableDrag: true,
                // elevation: 50,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15))
                ),
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width*0.8
                ),
                context: context, 
                builder: (context) {
                  return Wrap(
                    children: [
                      TextButton(
                        onPressed: () {
                          provUser.img = null;
                          Navigator.pop(context);
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('Default', style: TextStyle(color: myCustomDarkerColor(), fontSize: 17),),
                        ))
                      ),
                      TextButton(
                        onPressed: () {
                          provUser.pickedImage(false);
                          Navigator.pop(context);
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('Buka Kamera', style: TextStyle(color: myCustomDarkerColor(), fontSize: 17),),
                        ))
                      ),
                      TextButton(
                        onPressed: () {
                          provUser.pickedImage(true);
                          Navigator.pop(context);
                        },
                        child: Center(child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text('Buka Galeri', style: TextStyle(color: myCustomDarkerColor(), fontSize: 17),),
                        ))
                      ),
                      TextButton(
                        onPressed: () {Navigator.pop(context);}, 
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Center(child: Text('Batal', style: TextStyle(color: Colors.red, fontSize: 16),)),
                        )
                      ),
                    ],
                  );
                }
              );
            },
            borderRadius: BorderRadius.circular(40),
            child: CircleAvatar(
              radius: 40,
              backgroundColor: !provUser.edit? Colors.black38 : null,
              foregroundColor: !provUser.edit? Colors.white : null,
              child: provUser.userInfo.isNotEmpty && provUser.userInfo['Nama'].isNotEmpty && provUser.img == null? 
                Text(provUser.userInfo['Nama'][0], style: const TextStyle(fontSize: 30),) : 
                provUser.img != null? ClipOval(child: Image.file(File(provUser.img!.path), width: 75, height: 75, fit: BoxFit.cover,)) : 
                const Icon(Icons.camera_alt_rounded, size: 30,),
            ),
          ),
        );
      });
    }

    final provUser = Provider.of<UserProvider>(context);
    final provBurger = Provider.of<BurgerProvider>(context);
    final provLogin = Provider.of<LoginProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          tooltip: 'Back',
          onPressed: () {
            if (provUser.edit) {  // msh ngedit tp maksa back
              provUser.editState();  // matikan mode ngedit
              if (provUser.nama.text.trim().isEmpty || provUser.noHp.text.trim().isEmpty) { // klo isi kosong
                provUser.editState();  // suru edit dulu
                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 5),
                    content: const Text('Tidak boleh ada field yang kosong!'),
                    action: SnackBarAction(
                      label: 'OK',
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  )
                );
              }
              else {
                final userInfo = {
                  'Nama' : provUser.nama.text.trim(),
                  'No HP' : provUser.noHp.text.trim(),
                  'Gender' : provUser.gender
                };
                provBurger.userInfo = userInfo;
                provUser.saveUser = userInfo;
                
                ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                  SnackBar(
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 5),
                    content: const Text('Data diri berhasil diupdate!'),
                    action: SnackBarAction(
                      label: 'OK',
                      textColor: Colors.white,
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  )
                );
              }
            }
            else {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            }
          }, 
          icon: const Icon(Icons.arrow_back)
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              bottomSheets(context),
              const SizedBox(height: 15,),
              Table(
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                columnWidths: const {
                  0 : IntrinsicColumnWidth(),
                },
                children: [
                  TableRow(
                    children: [
                      const Text('Fullname', style: TextStyle(fontSize: 16.5),),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: TextField(
                          controller: provUser.nama,
                          enabled: provUser.edit,
                          maxLength: 20,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            labelText: 'Nama Anda',
                            errorText: provUser.nama.text.isEmpty && provUser.edit? 'Wajib Diisi' : null
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      const Text('Phone Number', style: TextStyle(fontSize: 16.5),),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: TextFormField(
                          controller: provUser.noHp,
                          enabled: provUser.edit,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9*#+]'))
                          ],
                          maxLength: 15,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                            contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            labelText: 'Nomor HP',
                            errorText: provUser.noHp.text.isEmpty && provUser.edit? 'Wajib Diisi' : null,
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                      )
                    ]
                  ),
                  TableRow(
                    children: [
                      const Text('Gender', style: TextStyle(fontSize: 16.5),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 5),
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
                                    groupValue: provUser.gender, 
                                    onChanged: provUser.edit? (val) {
                                      provUser.changeGender = val;
                                    } : null
                                  ),
                                  const Text('Laki-Laki'),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Radio(
                                  value: 'Perempuan', 
                                  groupValue: provUser.gender, 
                                  onChanged: provUser.edit? (val) {
                                    provUser.changeGender = val;
                                  } : null
                                ),
                                const Text('Perempuan'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]
                  ),
                  if (provLogin.isLoggedIn) TableRow(
                    children: [
                      const Text('Username', style: TextStyle(fontSize: 16.5),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 0, 7),
                        child: Tooltip(
                          message: provUser.edit? 'Tidak dapat mengedit Username' : '',
                          child: TextField(
                            controller: provLogin.username,
                            enabled: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                              contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            ),
                          ),
                        ),
                      )
                    ]
                  ),
                  if (provLogin.isLoggedIn) TableRow(
                    children: [
                      const Text('Password', style: TextStyle(fontSize: 16.5),),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 5, 0, 12),
                        child: Tooltip(
                          message: provUser.edit? 'Tidak dapat mengedit Password' : '',
                          child: TextField(
                            controller: provLogin.password,
                            enabled: false,
                            obscureText: true,
                            obscuringCharacter: '*',
                            decoration: InputDecoration(
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                              contentPadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
                            ),
                          ),
                        ),
                      )
                    ]
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provUser.editState();
          if (!provUser.edit) {
            if (provUser.nama.text.trim().isEmpty || provUser.noHp.text.trim().isEmpty) {
              provUser.editState();
              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                  content: const Text('Tidak boleh ada field yang kosong!'),
                  action: SnackBarAction(
                    label: 'OK',
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                )
              );
            }
            else {
              final userInfo = {
                'Nama' : provUser.nama.text.trim(),
                'No HP' : provUser.noHp.text.trim(),
                'Gender' : provUser.gender
              };
              provBurger.userInfo = userInfo;
              provUser.saveUser = userInfo;

              ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
                SnackBar(
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                  content: const Text('Data diri berhasil diupdate!'),
                  action: SnackBarAction(
                    label: 'OK',
                    textColor: Colors.white,
                    onPressed: () {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    },
                  ),
                )
              );
            }
          }
          else {
            ScaffoldMessenger.of(context)..hideCurrentSnackBar()..showSnackBar(
              const SnackBar(
                behavior: SnackBarBehavior.floating,
                duration: Duration(seconds: 5),
                content: Text('Silahkan ubah data diri Anda. Data ini akan otomatis terisi ke form pemesanan.'),
              )
            );
          }
        },
        backgroundColor: provUser.edit? Colors.green : myCustomColor(),
        foregroundColor: Colors.white,
        tooltip: provUser.edit? 'Simpan data' : 'Edit data',
        child: provUser.edit? const Icon(Icons.check_rounded) : const Icon(Icons.edit_rounded),
      ),
    );
  }
}