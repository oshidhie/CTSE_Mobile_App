import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:practiceblogapp/screens/Home.dart';
import 'package:practiceblogapp/screens/LoginPage.dart';
import 'package:practiceblogapp/screens/LoginRegisterPage.dart';
import 'package:practiceblogapp/screens/Register.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAVwXNCRs1vrKBvUgHURfSPMaScnq5E9gk",
        authDomain: "todolist-c499c.firebaseapp.com",
        projectId: "todolist-c499c",
        storageBucket: "todolist-c499c.appspot.com",
        messagingSenderId: "277196802098",
        appId: "1:277196802098:web:0a3c1f90052b45a14f542b"));
    runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.dark),
      home: const MyApp(),
    ));
  }
}

class MyApp extends StatelessWidget {  
   const MyApp({super.key});
  @override  
  Widget build(BuildContext context) {  
    return MaterialApp(  
      home: MyNavigationBar (), 
    );  
  }  
}  
  
class MyNavigationBar extends StatefulWidget {  
  MyNavigationBar({super.key}) ;
  
  @override  
  _MyNavigationBarState createState() => _MyNavigationBarState();  
}  
  
class _MyNavigationBarState extends State<MyNavigationBar > {  
  int _selectedIndex = 0;  
  static const List<Widget> _widgetOptions = <Widget>[  
   RegisterPage(),
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    Text('Home Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    Text('Search Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
    // Text('Profile Page', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),  
  ];  
  
  void _onItemTapped(int index) {  
    // switch (index) {
    //   case 1:
    //     _selectedIndex 
    //     break;
    //   default:
    // }
    setState(() {  
      _selectedIndex = index;  
    });  
  }  
  
  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      // appBar: AppBar(  
      //   title: const Text('Flutter BottomNavigationBar Example'),  
      //     backgroundColor: Colors.green  
      // ),  
      body: Center(  
        child: _widgetOptions.elementAt(_selectedIndex),  
      ),  
      bottomNavigationBar: BottomNavigationBar(  
        items: const <BottomNavigationBarItem>[  
          BottomNavigationBarItem(  
            icon: Icon(Icons.home),  
            label: 'Home',  
          ), 
          BottomNavigationBarItem(  
            icon: Icon(Icons.search),  
            label: 'Search',
          ),  
          BottomNavigationBarItem(  
            icon: Icon(Icons.person),   
            label: 'Profile', 
          ),  
        ], 
        currentIndex: _selectedIndex,  
        selectedItemColor: Colors.black,  
        iconSize: 40,  
        onTap: _onItemTapped,  
      ),  
    );  
  }  
}  