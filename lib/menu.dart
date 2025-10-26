import 'package:flutter/material.dart';

class ExploreMenuScreen extends StatelessWidget {
  const ExploreMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Explore Menu"), backgroundColor: Colors.orange),
      body: const Center(
        child: Text("Explore all menu categories here."),
      ),
    );
  }
}
