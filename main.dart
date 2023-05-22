import 'dart:io';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/my_creation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'BurgeRush'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;

  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      drawer: Drawer(
        // backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 130,
              child: DrawerHeader(
                decoration: BoxDecoration(
                color: Colors.amber[300],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('BurgeRush', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                    SizedBox(height: 20,),
                    Text(
                      'Victoria Beatrice', 
                      style: TextStyle(fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      'victoriabtre@gmail.com',
                    ),
                  ],
                )
              ),
            ),
            // UserAccountsDrawerHeader(
            //   decoration: const BoxDecoration(color: Colors.amber),
            //   accountName: const Text(
            //     'Victoria Beatrice', 
            //     style: TextStyle(fontWeight: FontWeight.bold,),
            //   ),
            //   accountEmail: const Text(
            //     'victoriabtre@gmail.com', 
            //     style: TextStyle(fontWeight: FontWeight.bold,),
            //   ),
            //   currentAccountPicture: ClipRRect(
            //     borderRadius: BorderRadius.circular(100.0),
            //     child : Image.asset('lib/assets/main-profile.png',),
            //   ),
            // ),
            ListTile(
              leading: const Icon(Icons.manage_accounts),
              title: const Text('Manage Your Account'),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.fastfood_outlined),
              title: const Text('My Creations'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => MyCreation()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long),
              title: const Text('My Order'),
              onTap: () {
                
              },
            ),
            Divider(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                
              },
            ),
            const AboutListTile (
              icon: Icon(Icons.info),
              // applicationIcon: Icon(),
              applicationName: 'BurgeRush',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2023 Company',
              aboutBoxChildren: [
                
              ],
              child: Text('About App'),
            )
          ],
        )
      ),
      body: SingleChildScrollView(
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text('Top Creation of the Week', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22.0), textAlign: TextAlign.left,),
                SizedBox(height: 5.0,),
                Container(
                  decoration: BoxDecoration(color: Colors.amber[200]),
                  width: MediaQuery.of(context).size.width*0.95,
                  height: MediaQuery.of(context).size.height*0.2,
                  child: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8.0),
                        width: MediaQuery.of(context).size.width*0.4,
                        height: MediaQuery.of(context).size.height*0.18,
                        child: Image.asset('lib/assets/american-burger.jpg', fit: BoxFit.cover,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Rose Bites', style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold), ),
                            Text('by Rosette'),
                            SizedBox(height: 6.0,),
                            Text('Likes : 18', style: TextStyle(fontSize: 17.0),),
                            Text('Price : Rp 25,000.-', style: TextStyle(fontSize: 17.0),),
                            SizedBox(height: 5.0,),
                            ElevatedButton(onPressed: (){}, child: Text('View Detail')),
                            SizedBox(height: 4.0,)
                          ],
                        ),
                      )
                    ],
                  ),
                )
                // // Carousel
                //   Container(
                //     padding: const EdgeInsets.all(0.0),
                //     child: CarouselSlider(
                //       options: CarouselOptions(
                //         height: 200.0,
                //         enlargeCenterPage: false,
                //         autoPlay: true,
                //         aspectRatio: 16/9,
                //         // autoPlayCurve: Curves.fastOutSlowIn,
                //         enableInfiniteScroll: true,
                //         autoPlayAnimationDuration: const Duration(milliseconds: 300),
                //         viewportFraction: 1.0,
                //       ),
                //       items: [
                //         // 1st Image of Slider
                //         Container(
                //           margin: const EdgeInsets.all(0.0),
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('lib/assets/home.c1.png'),
                //               fit: BoxFit.cover,
                //             )
                //           ),
                //         ),
                //         // 2nd Image of Slider
                //         Container(
                //           margin: const EdgeInsets.all(0.0),
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('lib/assets/home.c2.1.png'),
                //               fit: BoxFit.cover,
                //             )
                //           ),
                //         ),
                //         // 3rd Image of Slider
                //         Container(
                //           margin: const EdgeInsets.all(0.0),
                //           decoration: const BoxDecoration(
                //             image: DecorationImage(
                //               image: AssetImage('lib/assets/home.c3.png'),
                //               fit: BoxFit.cover,
                //             )
                //           ),
                //         ),
                //     ],)
                //   ),
              ],
            ),
          ),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
