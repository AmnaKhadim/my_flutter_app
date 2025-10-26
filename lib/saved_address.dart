import 'package:flutter/material.dart';

class SavedAddress extends StatelessWidget {
  const SavedAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Address"), backgroundColor: Colors.orange),
      body: const Center(
        child: Text("Your saved delivery addresses will appear here."),
      ),
    );
  }
}
