import 'package:climatrix/screens/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyAq5r4kNSwsa3SoWPcUbyUUFYzSxSkK6JM",
            appId: "1:949548376536:web:a7f5cdf69027bdfc6b92ad",
            messagingSenderId: "949548376536",
            projectId: "ctsemobileapp"));
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
      debugShowCheckedModeBanner: false,
      title: 'PlanetPulse',
      home: LoginPage(),
    );
  }
}
