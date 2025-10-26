import 'package:flutter/material.dart';
import 'package:fyp/choosetype.dart';
import 'package:fyp/splashscreen.dart';
import 'package:fyp/home_screen.dart';
import 'package:fyp/adminpanel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),

      // 👇 Start with splash screen every time
      home: SplashScreen(),

      // 👇 All app routes
      routes: {
        '/splash': (context) =>  SplashScreen(),
        '/chooseLogin': (context) => const ChooseLoginTypeScreen(),
        '/homeScreen': (context) => const HomeScreen(),
        '/adminPanel': (context) => const AdminPanelScreen(),
      },
    );
  }
}
