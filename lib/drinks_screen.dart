import 'package:flutter/material.dart';
import 'cart_manager.dart';

class DrinksMenuScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const DrinksMenuScreen({super.key, required this.item});

  @override
  State<DrinksMenuScreen> createState() => _DrinksMenuScreenState();
}

class _DrinksMenuScreenState extends State<DrinksMenuScreen> {
  Map<int, int> selectedSizeIndex = {};

  final List<Map<String, dynamic>> drinksList = [
    {
      "title": "Pepsi",
      "image": "assets/images/pepsi.jpg",
      "options": [
        {"name": "250ml", "price": 60},
        {"name": "500ml", "price": 100},
        {"name": "1 Liter", "price": 180},
        {"name": "1.5 Liter", "price": 250},
        {"name": "2.25 Liter", "price": 320},
      ]
    },
    {
      "title": "Coke",
      "image": "assets/images/coke.jpg",
      "options": [
        {"name": "250ml", "price": 60},
        {"name": "500ml", "price": 100},
        {"name": "1 Liter", "price": 180},
        {"name": "2 Liter", "price": 300},
      ]
    },
    {
      "title": "Sprite",
      "image": "assets/images/sprite.png",
      "options": [
        {"name": "250ml", "price": 60},
        {"name": "1 Liter", "price": 180},
        {"name": "1.5 Liter", "price": 250},
      ]
    },
    {
      "title": "Cold Coffee",
      "image": "assets/images/coldcoffee.jpg",
      "options": [
        {"name": "Regular", "price": 180},
        {"name": "Large", "price": 280},
        {"name": "Double Chocolate", "price": 380},
      ]
    },
    {
      "title": "Mint Margarita",
      "image": "assets/images/mintmargrinda.jpg",
      "options": [
        {"name": "Regular Glass", "price": 200},
        {"name": "Large Glass", "price": 550},
      ]
    },
    {
      "title": "Mineral Water",
      "image": "assets/images/water.jpg",
      "options": [
        {"name": "500ml", "price": 60},
        {"name": "1.5 Liter", "price": 120},
      ]
    },
    {
      "title": "Fruit Juice",
      "image": "assets/images/drinks.jpg",
      "options": [
        {"name": "Regular Glass", "price": 150},
        {"name": "1L Pack", "price": 280},
        {"name": "2L Pack", "price": 650},
      ]
    },
    {
      "title": "Lemonade",
      "image": "assets/images/lemonade.jpg",
      "options": [
        {"name": "Regular", "price": 160},
        {"name": "Mint Lemonade", "price": 200},
        {"name": "Large Pitcher", "price": 580},
      ]
    },
  ];

  void addToCart(int index) {
    final drink = drinksList[index];
    if (!selectedSizeIndex.containsKey(index)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select a size first!")),
      );
      return;
    }

    final selected = drink["options"][selectedSizeIndex[index]!];

    CartManager.addItem({
      "title": drink["title"],
      "size": selected["name"],
      "price": selected["price"].toString(),
      "image": drink["image"],
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.item['title'] ?? 'Drinks'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: drinksList.length,
        itemBuilder: (context, index) {
          final drink = drinksList[index];
          final options = drink["options"];

          return Column(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
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
                          drink["image"],
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
                              drink["title"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Horizontal size selector
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: options.length,
                                itemBuilder: (context, oIndex) {
                                  final selected = selectedSizeIndex[index] == oIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSizeIndex[index] = oIndex;
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
                                        options[oIndex]["name"],
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
                              selectedSizeIndex.containsKey(index)
                                  ? "Price: Rs ${options[selectedSizeIndex[index]]["price"]}"
                                  : "Select a size",
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
