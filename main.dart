import 'package:flutter/material.dart';
import 'package:flutter_application_2/notif_settings.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Vlock'),
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
              height: 160,
              child: DrawerHeader(
                decoration: const BoxDecoration(
                color: Colors.blue,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Vlock', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Color.fromARGB(255, 220, 200, 192)),),
                    SizedBox(height: 20,),
                    Text(
                      'Victoria Beatrice', 
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 3,),
                    Text(
                      'victoriabtre@gmail.com',
                      style: TextStyle(color: Colors.white),
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
              title: const Text('Manage Account'),
              onTap: () {
                
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications_active),
              title: const Text('Notification Settings'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotifSettPage()));
              },
            ),
            // ListTile(
            //   leading: const Icon(Icons.fastfood),
            //   title: const Text('My Creations'),
            //   onTap: () {
            //     Navigator.push(context, MaterialPageRoute(builder: (context) => const MyCreation()));
            //   },
            // ),
            // ListTile(
            //   leading: const Icon(Icons.receipt_long),
            //   title: const Text('My Order'),
            //   onTap: () {
                
            //   },
            // ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                
              },
            ),
            const AboutListTile (
              icon: Icon(Icons.info),
              // applicationIcon: Icon(),
              applicationName: 'Vlock',
              applicationVersion: '1.0.0',
              applicationLegalese: '© 2023 Company',
              aboutBoxChildren: [
                
              ],
              child: Text('About App'),
            )
          ],
        )
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // const Text(
            //   'You have pushed the button this many times:',
            // ),
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headlineMedium,
            // ),
          ],
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
