import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyCreation extends StatefulWidget {
  const MyCreation({super.key});

  @override
  State<MyCreation> createState() => _MyCreationState();
}

class _MyCreationState extends State<MyCreation> {
  @override
  List creationCards = [
      Card(
        shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(3.0)),
        color: Colors.white,
        margin: EdgeInsets.all(3.0),
        elevation: 2,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          height: 200,
          width: 175, // 180.0
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 160,
                child: Image.asset(
                  'lib/assets/cheese_burger.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Text('Cheese Burger', style: TextStyle(fontSize: 16.0),)
            ],
          ),
        ),
      ),
      Card()
    ];

    List<Widget> selectedCard = [];
  @override
  Widget build(BuildContext context) {

    // List<Widget> creationCards = [
    //   Card(
    //     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(3.0)),
    //     color: Colors.white,
    //     margin: EdgeInsets.all(3.0),
    //     elevation: 2,
    //     child: Container(
    //       padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
    //       height: MediaQuery.of(context).size.height*0.35,
    //       width: MediaQuery.of(context).size.width*0.45,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           SizedBox(
    //             height: MediaQuery.of(context).size.height*0.28,
    //             child: Image.asset(
    //               'lib/assets/cheese_burger.jpg',
    //               fit: BoxFit.cover,
    //             ),
    //           ),
    //           Text('Cheese Burger', style: TextStyle(fontSize: 16.0),)
    //         ],
    //       ),
    //     ),
    //   ),
    //   Card()
    // ];

    // List<Widget> selectedCard = [];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(text: 'Creation',),
              Tab(text: 'Favorites',)
            ]
          ),
          title: Text('My Creations'),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.delete,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //     // do something
          //     },
          //   ),
          // ],
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 15.0,
                      children: creationCards
                        .map(
                          (value) => GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                              context: context, 
                              builder: (context) {
                                return Wrap(
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.favorite),
                                      title: Text('Add to Favorites'),
                                      onTap: (){
                                        if(!selectedCard.contains(value)){
                                          selectedCard.add(value);
                                        }
                                      }
                                    ),
                                    ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete My Creation'),
                                      onTap: () {
                                        setState(() {
                                          creationCards.remove(value);
                                        });
                                      },
                                    ),
                                    ListTile(
                                      title: Text('Cancel', textAlign: TextAlign.center,),
                                      textColor: Colors.red,
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                );
                              }
                            );
                          },
                          child: value,
                          // child: Card(
                          //   shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(3.0)),
                          //   color: Colors.white,
                          //   margin: EdgeInsets.all(3.0),
                          //   elevation: 2,
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                          //     height: MediaQuery.of(context).size.height*0.5,
                          //     width: MediaQuery.of(context).size.width*0.45,
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       children: [
                          //         SizedBox(
                          //           height: MediaQuery.of(context).size.height*0.4,
                          //           child: Image.asset(
                          //             'lib/assets/cheese_burger.jpg',
                          //             fit: BoxFit.cover,
                          //           ),
                          //         ),
                          //         Text('Cheese Burger', style: TextStyle(fontSize: 16.0),)
                          //       ],
                          //     ),
                          //   ),
                          // ),
                        )).toList(),
                    )
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Wrap(
                      spacing: 15.0,
                      children: selectedCard,
                    )
                  ],
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}