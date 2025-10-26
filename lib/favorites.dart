import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites"), backgroundColor: Colors.orange),
      body: const Center(
        child: Text("Your favorite items will be shown here."),
      ),
    );
  }
}
