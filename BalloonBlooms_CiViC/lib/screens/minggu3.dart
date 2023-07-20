import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/comment_provider.dart';

class ProductComment extends StatefulWidget {
  const ProductComment({super.key, required this.title, required this.product});
  final String title;
  final String product;

  @override
  State<ProductComment> createState() => _ProductCommentState();
}

class _ProductCommentState extends State<ProductComment> {
  @override
  Widget build(BuildContext context) {
    final provKomentar = Provider.of<CommentProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Komentar'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          provKomentar.comments.any((element) => element['kode_produk'] == widget.product)?
            Expanded(
              child: SingleChildScrollView(
                controller: provKomentar.scrollCtrl,
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:
                    List.from(provKomentar.comments.where((comment) => comment['kode_produk'] == widget.product)).map((item) {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                child: Text(item['nama'][0].toUpperCase()),
                              ),
                              const Padding(padding: EdgeInsets.only(left: 10)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(item['nama'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                                        if (item['tgl'].substring(0, 10) == DateFormat('dd-MM-yyy').format(DateTime.now()))
                                          Text(item['tgl'].substring(11, 16), style: const TextStyle(color: Colors.black54),)
                                        else
                                          Text(item['tgl'], style: const TextStyle(color: Colors.black54),)
                                      ],
                                    ),
                                    const SizedBox(height: 5,),
                                    Text(item['komentar']),
                                  ],
                                )
                              )
                            ],
                          ),
                          const Divider(height: 25,)
                        ],
                      );
                    }).toList()
                ),
              ),
            )
          : 
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(0, 15, 0, 20),
            //   child: Image.asset('assets/krik-krik.png', width: MediaQuery.of(context).size.width*0.7,),
            // ),
            const Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Text('Belum ada komentar untuk produk ini.')
              ),
            ),
                    
          Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextField(
                  controller: provKomentar.nama,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.person),
                    border: const OutlineInputBorder(),
                    labelText: 'Nama Anda',
                    hintText: 'Nama akan terlihat secara publik.',
                    errorText: provKomentar.nama.text.trim().isEmpty && provKomentar.status == 'invalid'? 'Nama wajib diisi' : null,
                    errorBorder: provKomentar.nama.text.trim().isEmpty && provKomentar.status == 'invalid'? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)) : null,
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 10)),
                TextField(
                  controller: provKomentar.komentar,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.line_style_rounded),
                    border: const OutlineInputBorder(),
                    labelText: 'Komentar Anda',
                    hintText: 'Usahakan menulis komentar dengan bahasa yang sopan dan mudah dimengerti ya.',
                    errorText: provKomentar.komentar.text.trim().isEmpty && provKomentar.status == 'invalid'? 'Komentar wajib diisi' : null,
                    errorBorder: provKomentar.komentar.text.trim().isEmpty && provKomentar.status == 'invalid'? const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)) : null,
                    filled: true,
                    fillColor: Colors.white,
                    focusColor: Colors.white
                  ),
                  maxLines: 3,
                ),
                const Padding(padding: EdgeInsets.only(top: 12)),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(onPressed: () {provKomentar.clearInput();} , child: const Padding(padding: EdgeInsets.all(5), child: Text('Batal', style: TextStyle(fontSize: 18),),)),
                      const Padding(padding: EdgeInsets.all(5)),
                      ElevatedButton(
                        onPressed: () {
                          provKomentar.addComment = {
                            'kode_produk' : widget.product,
                            'nama' : provKomentar.nama.text.trim(),
                            'komentar' : provKomentar.komentar.text.trim(),
                            'tgl' : DateFormat('dd-MM-yyy HH:mm').format(DateTime.now())
                          };
                          provKomentar.scrollCtrl.animateTo(
                            provKomentar.scrollCtrl.position.maxScrollExtent,
                            duration: const Duration(milliseconds: 150),
                            curve: Curves.easeOut,
                          );
                        } , 
                        child: const Padding(padding: EdgeInsets.all(4), child: Text('Kirim', style: TextStyle(fontSize: 18),),)
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}