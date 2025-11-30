import 'package:flutter/material.dart';
import 'cart_manager.dart';

class BitesDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const BitesDetailScreen({super.key, required this.item});

  @override
  State<BitesDetailScreen> createState() => _BitesDetailScreenState();
}

class _BitesDetailScreenState extends State<BitesDetailScreen> {
  Map<int, int> selectedPortionIndex = {};

  final List<Map<String, dynamic>> bitesList = [
    {
      "name": "Chicken Tikka",
      "image": "assets/images/tikka.jpg",
      "portions": [
        {"label": "5 Piece", "price": 420},
        {"label": "10 Pieces", "price": 1020},
        {"label": "20 Pieces", "price": 1500},
      ],
    },
    {
      "name": "Malai Boti",
      "image": "assets/images/chicken.jpg",
      "portions": [
        {"label": "5 Piece", "price": 350},
        {"label": "10 Pieces", "price": 900},
        {"label": "20 Pieces", "price": 1250},
      ],
    },
    {
      "name": "BBQ Wings",
      "image": "assets/images/grilledbites.jpg",
      "portions": [
        {"label": "5 Pieces", "price": 300},
        {"label": "10 Pieces", "price": 650},
        {"label": "20 Pieces", "price": 1000},
      ],
    },
    {
      "name": "Paneer Tikka",
      "image": "assets/images/paneertikka.jpg",
      "portions": [
        {"label": "1 Seekh", "price": 200},
        {"label": "3 Seekh", "price": 550},
        {"label": "5 Seekh", "price": 850},
      ],
    },
    {
      "name": "Seekh Kebab",
      "image": "assets/images/seekhkabab.jpg",
      "portions": [
        {"label": "1 Stick", "price": 120},
        {"label": "3 Sticks", "price": 620},
        {"label": "5 Sticks", "price": 1000},
      ],
    },
  ];

  void addToCart(int index) {
    final bite = bitesList[index];
    if (!selectedPortionIndex.containsKey(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select a portion first!")),
      );
      return;
    }

    final selected = bite["portions"][selectedPortionIndex[index]!];

    CartManager.addItem({
      "title": "${widget.item['title']} - ${bite['name']}",
      "portion": selected["label"],
      "price": selected["price"].toString(),
      "image": bite["image"],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title']),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bitesList.length,
        itemBuilder: (context, index) {
          final bite = bitesList[index];
          final portions = bite["portions"];

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
                          bite["image"],
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bite["name"],
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 6),

                            // Horizontal portion selector
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

                            // Price display
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

                            // Add button
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

              const Divider(color: Colors.grey, thickness: 1, height: 10),
            ],
          );
        },
      ),
    );
  }
}
