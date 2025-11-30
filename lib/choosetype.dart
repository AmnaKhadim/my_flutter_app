import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLoginTypeScreen extends StatelessWidget {
  const ChooseLoginTypeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo
                Icon(
                  Icons.restaurant_menu_rounded,
                  size: 80,
                  color: Colors.orange.shade700,
                ),
                const SizedBox(height: 20),

                Text(
                  "City Sizzle",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Choose how you want to continue",
                  style: TextStyle(fontSize: 16, color: Colors.orange.shade700),
                ),

                const SizedBox(height: 60),

                // Customer Button — chhoti width
                SizedBox(
                  width: 260, // ← ab chhota aur sundar
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      final isFirst = prefs.getBool('first_time') ?? true;

                      if (isFirst) {
                        await prefs.setBool('first_time', false);
                        Navigator.pushReplacementNamed(context, '/location');
                      } else {
                        Navigator.pushReplacementNamed(context, '/homeScreen');
                      }
                    },
                    icon: const Icon(Icons.person, size: 20),
                    label: const Text(
                        "Continue as Customer", style: TextStyle(fontSize: 16)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                      elevation: 6,
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                // Admin Button — white background, orange border & text
                SizedBox(
                  width: 260, // same chhoti width
                  child: OutlinedButton.icon(
                    onPressed: () {
                      _showAdminDialog(context);
                    },
                    icon: const Icon(Icons.admin_panel_settings, size: 20,
                        color: Colors.orange),
                    label: const Text(
                      "Admin Login",
                      style: TextStyle(fontSize: 16,
                          color: Colors.orange,
                          fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white, // ← white background
                      side: const BorderSide(color: Colors.orange, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                Text(
                  "© 2025 City Sizzle",
                  style: TextStyle(color: Colors.orange.shade600, fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showAdminDialog(BuildContext context) {
    {
      final controller = TextEditingController();

      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
              title: const Text("Admin Login"),
              content: TextField(
                controller: controller,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: "Enter password",
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel")),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange),
                  onPressed: () {
                    if (controller.text == "admin123") {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(context, '/adminPanel');
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Wrong password"),
                            backgroundColor: Colors.orange),
                      );
                    }
                  },
                  child: const Text(
                      "Login", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
      );
    }
  }
}