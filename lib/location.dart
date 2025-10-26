import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'signuplogin.dart'; // Make sure this path is correct

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  bool _showLocationCard = false;

  @override
  void initState() {
    super.initState();
    _checkFirstTime();
  }

  // 🔹 Check if it's the first time user opened the app
  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isFirstTime = prefs.getBool('first_time');

    if (isFirstTime == null || isFirstTime == true) {
      setState(() {
        _showLocationCard = true;
      });
      await prefs.setBool('first_time', false);
    }
  }

  void _handleAllow(String type) {
    print('User selected: $type');

    setState(() {
      _showLocationCard = false;
    });

    // Navigate to SignupLoginScreen
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SignupLoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background
          Column(
            children: [
              Container(
                height: screenHeight * 0.5,
                width: double.infinity,
                color: Colors.white,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/deliveryboy.jpg',
                    fit: BoxFit.contain,
                    width: double.infinity,
                    height: screenHeight * 0.5,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Allow location access on the next screen for:',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.delivery_dining, color: Color(0xff872724)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Searching the best restaurants and shops near you',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Row(
                      children: [
                        Icon(Icons.local_cafe, color: Color(0xff872724)),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Receiving more accurate and faster delivery',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // 🔘 Continue Button
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showLocationCard = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff872724),
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),

          // 🔘 Location Card (First Time Only)
          if (_showLocationCard) ...[
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: Container(
                color: Colors.black.withOpacity(0.4),
              ),
            ),
            Center(
              child: Container(
                width: screenWidth * 0.25,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Allow Location Access',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Choose how you want to share your location with the app.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 20),
                    Image.asset(
                      'assets/images/locationpin.jpg',
                      height: 160,
                      width: 200,
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        TextButton(
                          onPressed: () => _handleAllow('Allow Once'),
                          child: Text('Allow Once'),
                        ),
                        TextButton(
                          onPressed: () => _handleAllow('Allow While Using App'),
                          child: Text('Allow While Using App'),
                        ),
                        TextButton(
                          onPressed: () => _handleAllow('Don\'t Allow'),
                          child: Text(
                            'Don\'t Allow',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
