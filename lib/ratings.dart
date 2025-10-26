import 'package:flutter/material.dart';

class Ratings extends StatelessWidget {
  const Ratings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ratings"), backgroundColor: Colors.orange),
      body: const Center(
        child: Text("Rate your orders here."),
      ),
    );
  }
}
