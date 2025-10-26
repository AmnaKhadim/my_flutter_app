import 'package:flutter/material.dart';

class OrderHistory extends StatelessWidget {
  const OrderHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Order History"), backgroundColor: Colors.orange),
      body: const Center(
        child: Text("Your previous orders will be listed here."),
      ),
    );
  }
}
