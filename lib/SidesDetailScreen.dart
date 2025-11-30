import 'package:flutter/material.dart';
import 'cart_manager.dart';

class SidesDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const SidesDetailScreen({super.key, required this.item});

  @override
  State<SidesDetailScreen> createState() => _SidesDetailScreenState();
}

class _SidesDetailScreenState extends State<SidesDetailScreen> {
  Map<int, int> selectedPortionIndex = {};

  final List<Map<String, dynamic>> sidesList = [
    {
      "name": "French Fries",
      "image": "assets/images/fries.jpg",
      "portions": [
        {"label": "Small", "price": 100},
        {"label": "Regular", "price": 150},
        {"label": "Large", "price": 200},
      ],
    },
    {
      "name": "Cheese Nuggets",
      "image": "assets/images/nuggets.jpg",
      "portions": [
        {"label": "6 pcs", "price": 180},
        {"label": "12 pcs", "price": 330},
      ],
    },
    {
      "name": "Onion Rings",
      "image": "assets/images/onionrings.jpg",
      "portions": [
        {"label": "6 pcs", "price": 130},
        {"label": "12 pcs", "price": 230},
      ],
    },
    {
      "name": "Garlic Bread",
      "image": "assets/images/garlicbread.jpg",
      "portions": [
        {"label": "2 pcs", "price": 120},
        {"label": "4 pcs", "price": 200},
      ],
    },
    {
      "name": "Cheesy Garlic Bread",
      "image": "assets/images/cheesygarlicbread.jpg",
      "portions": [
        {"label": "2 pcs", "price": 180},
        {"label": "4 pcs", "price": 300},
      ],
    },
    {
      "name": "Mozzarella Sticks",
      "image": "assets/images/mazrellasticks.png",
      "portions": [
        {"label": "4 pcs", "price": 220},
        {"label": "8 pcs", "price": 420},
      ],
    },
    {
      "name": "Loaded Fries",
      "image": "assets/images/fries.jpg",
      "portions": [
        {"label": "Small", "price": 250},
        {"label": "Large", "price": 400},
      ],
    },
  ];

  void addToCart(int index) {
    final side = sidesList[index];

    if (!selectedPortionIndex.containsKey(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select a portion first!")),
      );
      return;
    }

    final portion = side["portions"][selectedPortionIndex[index]!];

    CartManager.addItem({
      "title": "${widget.item['title']} - ${side['name']}",
      "portion": portion["label"],
      "price": portion["price"].toString(),
      "image": side["image"],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Scaffold(
      appBar: AppBar(
        title: Text(item['title']),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: sidesList.length,
        itemBuilder: (context, index) {
          final side = sidesList[index];
          final portions = side["portions"];

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          side["image"],
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Details Section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Name
                            Text(
                              side["name"],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),

                            // Portion Selector Row
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: portions.length,
                                itemBuilder: (context, pIndex) {
                                  final selected = selectedPortionIndex[index] == pIndex;

                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedPortionIndex[index] = pIndex;
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 8),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: selected ? Colors.orange : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(color: Colors.orange),
                                      ),
                                      child: Text(
                                        portions[pIndex]["label"],
                                        style: TextStyle(
                                          color: selected ? Colors.white : Colors.orange,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(height: 6),

                            // Price
                            Text(
                              selectedPortionIndex.containsKey(index)
                                  ? "Price: Rs ${portions[selectedPortionIndex[index]]["price"]}"
                                  : "Select a portion",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),

                            const SizedBox(height: 10),

                            // Add To Cart Button
                            Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                onPressed: () => addToCart(index),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.orange,
                                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                                ),
                                child: const Text("Add"),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Divider
              const Divider(color: Colors.grey, thickness: 1, height: 10),
            ],
          );
        },
      ),
    );
  }
}
