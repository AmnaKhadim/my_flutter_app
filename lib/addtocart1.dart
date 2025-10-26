import 'package:flutter/material.dart';

// 🔹 Global Cart List (sab screens access kar saken)
List<Map<String, String>> cartItems = [];

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CartScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    int total = items.fold(
        0, (sum, item) => sum + int.parse(item['price'] ?? '0'));

    return Scaffold(
      // ✅ Background with orange shading
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: const Text(
                "🛒 My Cart",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18, // ✅ Normal size
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: items.isEmpty
                  ? const Center(
                child: Text(
                  "Your cart is empty 🛍️",
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                ),
              )
                  : Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemCount: items.length,
                      separatorBuilder: (_, __) =>
                      const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2))
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item['image']!,
                                width: 55, // ✅ Normal fixed size
                                height: 55,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item['title']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            subtitle: Text(
                              "Rs. ${item['price']}",
                              style: const TextStyle(
                                color: Colors.green,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Colors.red, size: 22),
                              onPressed: () {
                                cartItems.removeAt(index);
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          CartScreen(items: cartItems)),
                                );
                              },
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // 🔹 Bottom Total & Button
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black12,
                            blurRadius: 8,
                            offset: const Offset(0, -3))
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total: Rs $total",
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      CheckoutScreen(items: items)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(
                            "Proceed to Buy",
                            style: TextStyle(
                                fontSize: 15, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🔹 Checkout Screen
class CheckoutScreen extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const CheckoutScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    int total = items.fold(
        0, (sum, item) => sum + int.parse(item['price'] ?? '0'));

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orange.shade100, Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            AppBar(
              title: const Text(
                "Checkout",
                style: TextStyle(fontSize: 18),
              ),
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("📋 Order Summary",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),

                    // 🔹 Items List
                    Expanded(
                      child: ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const Divider(),
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage:
                              AssetImage(items[index]['image']!),
                              radius: 22, // ✅ Normal size
                            ),
                            title: Text(
                              items[index]['title']!,
                              style: const TextStyle(fontSize: 15),
                            ),
                            subtitle: Text(
                              "Rs. ${items[index]['price']}",
                              style: const TextStyle(
                                  fontSize: 13, color: Colors.black87),
                            ),
                          );
                        },
                      ),
                    ),

                    const Divider(),
                    Text("Total: Rs $total",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),

                    const SizedBox(height: 14),

                    // 🔹 Confirm Order Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                              content: Text(
                                  "✅ Order placed successfully!")));
                          cartItems.clear();
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text(
                          "Confirm Order",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
