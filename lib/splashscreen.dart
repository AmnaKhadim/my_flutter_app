import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'location.dart';       // Agar aap Location screen use karna chahti ho
import 'home_screen.dart';   // Home screen import
import 'choosetype.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    await Future.delayed(const Duration(seconds: 4)); // splash delay

    if (isFirstTime) {
      // ✅ Pehli dafa app open
      await prefs.setBool('isFirstTime', false);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseLoginTypeScreen()),
      );
    } else {
      // ✅ Next time direct HomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ChooseLoginTypeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;   // ✅ screen ka width
    final screenHeight = MediaQuery.of(context).size.height; // ✅ screen ka height

    return Scaffold(
      backgroundColor: const Color(0xFFFFDE59),
      body: Center(
        child: SizedBox(
          width: screenWidth * 0.9,   // ✅ image width = 60% of screen width
          height: screenHeight * 0.9, // ✅ image height = 60% of screen height
          child: Image.asset(
            'assets/images/splashscreen.png',
            fit: BoxFit.contain, // ✅ Image stretch na ho, proportion maintain kare
          ),
        ),
      ),
    );
  }
}
