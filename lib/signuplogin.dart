import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:fyp/login.dart';
import 'home_screen.dart';


void main() {
  runApp(CitySizzle());
}

class CitySizzle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignupLoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class SignupLoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Skip Button
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () {
                print('Skip tapped');
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),

          // Main Column
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Text(
                  'With up to 30% off,\nChoose What You Want!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/images/thirty.jpg', // Replace with your image path
                height: 180,
              ),
              SizedBox(height: 10),

              // Scrollable Bottom Sheet
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Sign up or log in',
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 5),
                        Text('Sign up to get your discount'),
                        SizedBox(height: 20),

                        // Facebook Button
                        GestureDetector(
                          onTap: () => showFacebookSignInDialog(context),
                          child: socialButton(
                            icon: Icons.facebook,
                            text: 'Continue with Facebook',
                            color: Color(0xFF1877F2),
                            textColor: Colors.white,
                          ),
                        ),

                        SizedBox(height: 12),

                        // Google Button (opens popup)
                        GestureDetector(
                          onTap: () => showGoogleSignInDialog(context),
                          child: socialButton(
                            imageAsset: 'assets/images/google.png',
                            text: 'Continue with Google',
                            color: Colors.white,
                            textColor: Colors.black,
                            border: true,
                          ),
                        ),

                        SizedBox(height: 12),

                        Row(
                          children: [
                            Expanded(child: Divider()),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text("or"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),

                        SizedBox(height: 20),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => LoginScreen()),
                            );
                          },
                          child: socialButton(
                            icon: Icons.email,
                            text: 'Continue with Email',
                            color: Colors.pink,
                            textColor: Colors.white,
                          ),
                        ),

                        SizedBox(height: 30),

                        // Terms & Privacy
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Text.rich(
                              TextSpan(
                                text: 'By signing up you agree to our ',
                                children: [
                                  TextSpan(
                                    text: 'Terms and Conditions',
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                  TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy.',
                                    style: TextStyle(color: Colors.pink),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  /// Google Sign-In Dialog
  void showGoogleSignInDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white.withOpacity(0.9),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '"City Sizzle" wants to use "google.com" to sign in',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'This allows the app and website to share information about you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: (){
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                            },
                            child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                              // Add your Google Sign-In logic here
                            },
                            child: Text('Continue', style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
  void showFacebookSignInDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white.withOpacity(0.9),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '"City Sizzle" wants to use "facebook.com" to sign in',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'This allows the app and website to share information about you.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                            },
                            child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                              // TODO: Add your Facebook login logic here
                            },
                            child: Text('Continue', style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showEmailSignInDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (context) {
        return Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: Colors.white.withOpacity(0.9),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '"City Sizzle" wants to sign you in with Email',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Please proceed to enter your email to continue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Divider(),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                            },
                            child: Text('Cancel', style: TextStyle(color: Colors.blue)),
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Add your email login logic here
                              Navigator.push(context, MaterialPageRoute(builder: (_) => HomeScreen()));
                            },
                            child: Text('Continue', style: TextStyle(color: Colors.blue)),
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  /// Social Button Widget
  Widget socialButton({
    IconData? icon,
    String? imageAsset,
    required String text,
    required Color color,
    required Color textColor,
    bool border = false,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: color,
        border: border ? Border.all(color: Colors.grey.shade300) : null,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, color: textColor),
            SizedBox(width: 10),
          ],
          if (imageAsset != null) ...[
            Image.asset(imageAsset, height: 24),
            SizedBox(width: 10),
          ],
          Text(
            text,
            style: TextStyle(color: textColor, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
