import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/feedback_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';

class AddFeedback extends StatefulWidget {
  const AddFeedback({super.key});

  @override
  State<AddFeedback> createState() => _AddFeedbackState();
}

class _AddFeedbackState extends State<AddFeedback> {
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FeedbackProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Give Your Feedback'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: prov.nama,
                decoration: InputDecoration(
                  hintText: 'Nama Anda',
                  contentPadding: const EdgeInsets.all(8),
                  errorText: prov.nama.text.isEmpty && prov.status=='invalid'? 'Nama wajib diisi' : null
                ),
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text.rich(
                  TextSpan(
                    text: 'Saya setuju nama saya akan terlihat oleh admin ',
                    children: [
                      TextSpan(
                        text: !prov.setuju && prov.status=='invalid'? ' (Wajib dipilih)' : null,
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      )
                    ]
                  )
                ),
                value: prov.setuju, 
                onChanged: (val) {
                  prov.setuju = val;
                }
              ),
              CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: const Text('Sembunyikan nama saya'),
                value: prov.hideNama, 
                onChanged: (val) {
                  prov.hideNama = val;
                }
              ),
              Visibility(
                visible: prov.hideNama,
                child: Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RadioListTile(
                        title: const Text('Hanya inisial nama'),
                        value: 'inisial', 
                        groupValue: prov.namaHidden, 
                        onChanged: (val) {
                          prov.namaHidden = 'inisial';
                        }
                      ),
                      RadioListTile(
                        title: const Text('Anonim'),
                        value: 'anonim', 
                        groupValue: prov.namaHidden, 
                        onChanged: (val) {
                          prov.namaHidden = 'anonim';
                        }
                      )
                    ],
                  ),
                )
              ),
              const SizedBox(height: 10,),
              Text.rich(
                TextSpan(
                  text: 'Berikan tingkat kepuasan Anda terhadap produk kami ',
                  style: const TextStyle(fontSize: 16),
                  children: [
                    TextSpan(
                      text: prov.puasTerpilih.isEmpty && prov.status=='invalid'? ' (Wajib pilih salah satu)' : null,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    )
                  ]
                )
              ),
              const SizedBox(height: 5,),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: MediaQuery.of(context).size.width>525 ? WrapAlignment.start : WrapAlignment.center,
                  children: 
                    prov.tingkatKepuasan.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: ChoiceChip(
                          label: Text(entry.key), 
                          selected: entry.value,
                          selectedColor: myCustomColor()[300],
                          onSelected: (val) {
                            prov.changeKepuasan = [entry.key, val];
                          },
                        ),
                      );
                    }).toList(),
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: prov.komentar,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                  hintText: 'Berikan pendapat Anda...'
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 10,),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Text('Tags', style: TextStyle(fontSize: 16),),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Wrap(
                  alignment: MediaQuery.of(context).size.width>470 ? WrapAlignment.start : WrapAlignment.center,
                  children: 
                    prov.tags.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: FilterChip(
                          label: Text(entry.key), 
                          selected: entry.value,
                          selectedColor: myCustomColor()[300],
                          onSelected: (val) {
                            prov.selectTag = [entry.key, val];
                            prov.addTags = entry.key;
                          },
                        ),
                      );
                    }).toList(),
                ),
              ),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      prov.resetFeedback();
                      Navigator.pop(context);
                    }, 
                    child: const Padding(padding: EdgeInsets.all(5), child: Text('Batal', style: TextStyle(fontSize: 18),),)),
                  const Padding(padding: EdgeInsets.all(5)),
                  ElevatedButton(
                    onPressed: () {
                      if (prov.nama.text.isNotEmpty && prov.setuju && prov.puasTerpilih.isNotEmpty) {
                        prov.sendFeedback = {
                          'nama': prov.nama.text,
                          'anonim': prov.hideNama && prov.namaHidden == 'anonim',
                          'inisial': prov.hideNama && prov.namaHidden == 'inisial',
                          'komentar': prov.komentar.text,
                          'kepuasan': prov.puasTerpilih,
                          'tags': prov.chosenTag,
                          'tgl': DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now()).toString(),
                          'spotlight': false
                        };
                        Navigator.pop(context);
                      }
                      else {
                        prov.status = 'invalid';
                      }
                    } , 
                    child: const Padding(padding: EdgeInsets.all(4), child: Text('Kirim', style: TextStyle(fontSize: 18),),)
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}