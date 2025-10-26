import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLoginTypeScreen extends StatelessWidget {
  const ChooseLoginTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08,
                vertical: size.height * 0.05,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * 0.05),

                  Icon(Icons.fastfood_rounded,
                      size: size.width * 0.07, color: Colors.orange.shade600),

                  SizedBox(height: size.height * 0.02),

                  Text(
                    "City Sizzle",
                    style: TextStyle(
                      color: Colors.orange.shade800,
                      fontSize: size.width * 0.04,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  SizedBox(height: size.height * 0.005),

                  Text(
                    "Choose your login type",
                    style: TextStyle(
                      color: Colors.orange.shade700,
                      fontSize: size.width * 0.02,
                    ),
                  ),

                  SizedBox(height: size.height * 0.07),

                  // Customer Login Button
                  _buildLoginButton(
                    context,
                    title: "Customer",
                    icon: Icons.person_outline,
                    color1: Colors.orange.shade200,
                    color2: Colors.orange.shade400,
                    onTap: () async {
                      final prefs = await SharedPreferences.getInstance();
                      bool isFirstTime = prefs.getBool('isFirstTimeCustomer') ?? true;

                      if (isFirstTime) {
                        await prefs.setBool('isFirstTimeCustomer', false);
                        Navigator.pushNamed(context, '/location');
                      } else {
                        Navigator.pushNamed(context, '/homeScreen');
                      }
                    },
                    width: size.width * 0.7,
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Admin Login Button
                  _buildLoginButton(
                    context,
                    title: "Admin",
                    icon: Icons.admin_panel_settings_rounded,
                    color1: Colors.orange.shade300,
                    color2: Colors.deepOrange.shade300,
                    onTap: () {
                      _showAdminLoginDialog(context);
                    },
                    width: size.width * 0.7,
                  ),

                  SizedBox(height: size.height * 0.1),

                  Text(
                    "© 2025 City Sizzle",
                    style: TextStyle(
                      color: Colors.orange.shade600,
                      fontSize: size.width * 0.01,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Reusable Login Button
  Widget _buildLoginButton(
      BuildContext context, {
        required String title,
        required IconData icon,
        required Color color1,
        required Color color2,
        required VoidCallback onTap,
        required double width,
      }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color1, color2],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: color2.withOpacity(0.4),
              blurRadius: 12,
              offset: const Offset(3, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 26, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows a blurred dialog for Admin password entry
void _showAdminLoginDialog(BuildContext context) {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  const String correctPassword = 'admin123'; // Set your admin password here

  showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: "AdminLogin",
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 250),
    pageBuilder: (context, anim1, anim2) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              // Background Blur
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(color: Colors.black.withOpacity(0)),
              ),

              // Dialog Box
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45, // smaller width
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "Admin Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Enter Admin Password',
                              prefixIcon: const Icon(Icons.lock_outline),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return 'Password is required';
                              } else if (v.length < 4) {
                                return 'Password too short';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                              const SizedBox(width: 8),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.deepOrange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    if (_passwordController.text.trim() ==
                                        correctPassword) {
                                      Navigator.of(context).pop();
                                      Navigator.pushNamed(context, '/adminPanel');
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                          content:
                                          Text('Incorrect admin password'),
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 10),
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
