import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:baloonblooms/providers/feedback_provider.dart';
import 'package:baloonblooms/components/custom_color.dart';

class Feedbacks extends StatefulWidget {
  const Feedbacks({super.key, required this.title});
  final String title;

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {
 
  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<FeedbackProvider>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: ListView(
        children: prov.reviews.map<Widget>((review) {
          return Column(
            children: [
              ListTile(
                tileColor: review['spotlight']? myCustomColor()[100] : null,
                leading: CircleAvatar(
                  backgroundColor: myCustomColor()[600],
                  foregroundColor: Colors.black,
                  child: Text(review['nama'][0]),
                ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width <= 444 ? MediaQuery.of(context).size.width*0.2 : null,
                          child: Text(
                            review['anonim']? 'anonymous' : review['inisial']? review['nama'][0]+'*'*(review['nama'].length-2) : review['nama'],
                            overflow: TextOverflow.ellipsis, 
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text('|'),
                        ),
                        Text(review['kepuasan'], style: const TextStyle(fontSize: 12, color: Colors.black54),)
                      ],
                    ),
                    Text(review['tgl'].split(' ')[0]==DateFormat('dd-MM-yyyy').format(DateTime.now())? review['tgl'].split(' ')[1] : review['tgl'].split(' ')[0], style: const TextStyle(fontSize: 14),)
                  ],
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: review['komentar'].isNotEmpty? Text(review['komentar']) : null,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 2, 0, 5),
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        children: review['tags'].map<Widget>((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            margin: const EdgeInsets.only(right: 5, top: 5),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: myCustomColor()[200]
                            ),
                            child: Text(tag),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                trailing: PopupMenuButton(
                  icon: const Icon(Icons.more_vert),
                  padding: EdgeInsets.zero,
                  splashRadius: 20,
                  constraints: const BoxConstraints(
                    maxWidth: 200
                  ),
                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry> [
                      PopupMenuItem(
                        onTap: () {
                          prov.removeFeedback = prov.reviews.indexOf(review);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Feedback berhasil dilaporkan dan akan segera ditinjau.'),
                              action: SnackBarAction(label: 'OK', textColor: Colors.white, onPressed: () => ScaffoldMessenger.of(context).clearSnackBars()),
                            )
                          );
                        },
                        child: const ListTile(
                          leading: Icon(Icons.report_problem_outlined),
                          title: Text('Report'),
                        )
                      ),
                      const PopupMenuDivider(),
                      PopupMenuItem(
                        onTap: () {
                          prov.removeFeedback = prov.reviews.indexOf(review);
                          prov.sendFeedback = review;
                          prov.spotlight();
                        },
                        child: ListTile(
                          leading: review['spotlight']? const Icon(Icons.light) : const Icon(Icons.light),
                          title: review['spotlight']? const Text('Unspotlight') : const Text('Spotlight'),
                        )
                      ),
                    ];
                  }
                ),
              ),
              const Divider(
                indent: 12,
                endIndent: 12,
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}