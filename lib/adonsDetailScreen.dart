import 'package:flutter/material.dart';
import 'cart_manager.dart';

class ExtrasDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const ExtrasDetailScreen({super.key, required this.item});

  @override
  State<ExtrasDetailScreen> createState() => _ExtrasDetailScreenState();
}

class _ExtrasDetailScreenState extends State<ExtrasDetailScreen> {
  List<int> selectedIndexes = [];

  final List<Map<String, dynamic>> extrasOptions = [
    {
      "name": "Dip Sauce",
      "price": 50,
      "image": "assets/images/dipsauce.jpg",
      "desc": "Perfect for fries & bites."
    },
    {
      "name": "Cheese Sauce",
      "price": 90,
      "image": "assets/images/cheese_mayo.png",
      "desc": "Creamy melted cheese dip."
    },
    {
      "name": "Chili Flakes",
      "price": 20,
      "image": "assets/images/chilly.jpg",
      "desc": "Adds extra spice to your meals."
    },
    {
      "name": "Garlic Mayo",
      "price": 70,
      "image": "assets/images/garlic_mayo.png",
      "desc": "Creamy garlic mayo blend."
    },
    {
      "name": "Peri Mayo",
      "price": 50,
      "image": "assets/images/peri_mayo.png",
      "desc": "Spicy peri mayo flavor."
    },
  ];

  void toggleSelection(int index) {
    setState(() {
      if (selectedIndexes.contains(index)) {
        selectedIndexes.remove(index);
      } else {
        selectedIndexes.add(index);
      }
    });
  }

  void addSelectedToCart() {
    for (int index in selectedIndexes) {
      final opt = extrasOptions[index];

      CartManager.addItem({
        "title": "${widget.item['title']} - ${opt['name']}",
        "price": opt['price'].toString(),
        "image": opt['image'],
      });
    }

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
        itemCount: extrasOptions.length,
        itemBuilder: (context, index) {
          final extra = extrasOptions[index];
          final selected = selectedIndexes.contains(index);

          return Column(
            children: [
              // CARD
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      // IMAGE
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          extra["image"],
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // DETAILS
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              extra["name"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 4),

                            Text(
                              extra["desc"],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              "Rs ${extra['price']}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // SELECT BUTTON
                      GestureDetector(
                        onTap: () => toggleSelection(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: selected ? Colors.orange : Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.orange),
                          ),
                          child: Text(
                            selected ? "Added" : "Add",
                            style: TextStyle(
                              color: selected ? Colors.white : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              const Divider(height: 20),
            ],
          );
        },
      ),

      // BOTTOM BAR
      bottomNavigationBar: selectedIndexes.isNotEmpty
          ? Container(
        padding: const EdgeInsets.all(14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: addSelectedToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.all(14),
                ),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  addSelectedToCart();
                  Navigator.pushNamed(context, "/cart");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.all(14),
                ),
                child: const Text(
                  "Buy Now",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}
