import 'package:flutter/material.dart';
import 'cart_manager.dart';
import 'addtocart1.dart';

class DetailScreen extends StatelessWidget {
  final Map<String, dynamic> item; // ✅ ab category ki jagah item accept karega

  const DetailScreen({super.key, required this.item});

  // 🔹 Dummy Data for Categories (ab rakhne ki zaroorat nahi, par future ke liye rakha hai)
  static final Map<String, List<Map<String, dynamic>>> categoryItems = {
    "Drinks": [
      {"title": "Pepsi", "price": 80, "image": "assets/images/pepsi.png"},
      {"title": "Sprite", "price": 70, "image": "assets/images/sprite.png"},
      {"title": "Fruit Juice", "price": 120, "image": "assets/images/juice.png"},
    ],
    "Snacks": [
      {"title": "Lays", "price": 50, "image": "assets/images/lays.png"},
      {"title": "Popcorn", "price": 100, "image": "assets/images/popcorn.png"},
      {"title": "Chocolate", "price": 150, "image": "assets/images/chocolate.png"},
    ],
    "Fast Food": [
      {"title": "Burger", "price": 250, "image": "assets/images/burger.png"},
      {"title": "Pizza Slice", "price": 300, "image": "assets/images/pizza.png"},
      {"title": "Fries", "price": 150, "image": "assets/images/fries.png"},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(item['title']), // ✅ title from item
        backgroundColor: Colors.orange,
        elevation: 2,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🔹 Image full view
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: Image.asset(
                    item['image'],
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.contain,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Price: Rs ${item['price']}",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (item.containsKey("category")) ...[
                        const SizedBox(height: 6),
                        Text(
                          "Category: ${item['category']}",
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.orange,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const SizedBox(height: 16),

                      // 🔹 Buttons
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                CartManager.addItem({
                                  "title": item["title"],
                                  "price": item["price"],
                                  "image": item["image"],
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("✅ Added to cart"),
                                    backgroundColor: Colors.green,
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text("Add to Cart"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                CartManager.addItem({
                                  "title": item["title"],
                                  "price": item["price"],
                                  "image": item["image"],
                                });
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CartScreen(
                                      items: CartManager.cartItems.value,
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: const Icon(Icons.shopping_bag),
                              label: const Text("Buy Now"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
