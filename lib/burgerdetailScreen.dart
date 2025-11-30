import 'package:flutter/material.dart';
import 'cart_manager.dart';

class BurgersDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item;

  const BurgersDetailScreen({super.key, required this.item});

  @override
  State<BurgersDetailScreen> createState() => _BurgersDetailScreenState();
}

class _BurgersDetailScreenState extends State<BurgersDetailScreen> {
  int selectedIndex = -1;

  final List<Map<String, dynamic>> burgerOptions = [
    {
      "name": "Zinger Burger",
      "image": "assets/images/zingerburger.jpg",
      "sizes": [
        {"label": "Regular", "price": 300},
        {"label": "Cheese", "price": 360},
        {"label": "Double Patty", "price": 450},
        {"label": "Meal", "price": 650},
      ]
    },
    {
      "name": "Beef Burger",
      "image": "assets/images/burger.jpg",
      "sizes": [
        {"label": "Regular", "price": 350},
        {"label": "Cheese", "price": 400},
        {"label": "Double Beef", "price": 520},
      ]
    },
    {
      "name": "Crispy Chicken Burger",
      "image": "assets/images/crispychicken.jpg",
      "sizes": [
        {"label": "Regular", "price": 320},
        {"label": "Cheese", "price": 380},
        {"label": "Jumbo Crispy", "price": 510},
      ]
    },
    {
      "name": "Grilled Chicken Burger",
      "image": "assets/images/grilledchickenburger.jpg",
      "sizes": [
        {"label": "Regular", "price": 340},
        {"label": "Double Patty", "price": 480},
      ]
    },
    {
      "name": "Smash Burger",
      "image": "assets/images/smashburger.jpg",
      "sizes": [
        {"label": "Single Smash", "price": 420},
        {"label": "Cheese Smash", "price": 460},
        {"label": "Double Smash", "price": 550},
      ]
    },
    {
      "name": "Chicken Cheese Burger",
      "image": "assets/images/chickencheese.jpg",
      "sizes": [
        {"label": "Regular", "price": 330},
        {"label": "Double Cheese", "price": 430},
      ]
    },
    {
      "name": "Jalapeno Zinger Burger",
      "image": "assets/images/jalapeno.jpg",
      "sizes": [
        {"label": "Regular", "price": 380},
        {"label": "Cheese", "price": 430},
      ]
    },
    {
      "name": "Crispy Tower Burger",
      "image": "assets/images/towerburger.jpg",
      "sizes": [
        {"label": "Regular", "price": 420},
        {"label": "Cheese Tower", "price": 480},
      ]
    },
  ];

  void addToCart() {
    if (selectedIndex == -1) return;

    final selectedBurger = burgerOptions[selectedIndex];
    final size = selectedBurger["selectedSize"];

    CartManager.addItem({
      "title": "${selectedBurger["name"]} - ${size["label"]}",
      "price": size["price"].toString(),
      "image": selectedBurger["image"],
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
        padding: const EdgeInsets.all(14),
        itemCount: burgerOptions.length,
        itemBuilder: (context, index) {
          final burger = burgerOptions[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.85),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.07),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ],
            ),

            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // LEFT SIDE — NAME + SIZES
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        burger["name"],
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),

                      const SizedBox(height: 10),

                      Wrap(
                        spacing: 10,
                        children: List.generate(
                          burger["sizes"].length,
                              (sIndex) {
                            final size = burger["sizes"][sIndex];
                            final isSelected =
                                burger["selectedSize"] == size &&
                                    selectedIndex == index;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  burger["selectedSize"] = size;
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.orange
                                        : Colors.grey.shade300,
                                    width: 2,
                                  ),
                                  color: isSelected
                                      ? Colors.orange.shade50
                                      : Colors.white,
                                ),
                                child: Text(
                                  "${size['label']} — Rs ${size['price']}",
                                  style: const TextStyle(fontSize: 13),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 10),

                // RIGHT SIDE — IMAGE
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    burger["image"],
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
          );
        },
      ),

      bottomNavigationBar:
      (selectedIndex != -1 && burgerOptions[selectedIndex]["selectedSize"] != null)
          ? Container(
        padding: const EdgeInsets.all(14),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: addToCart,
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.all(16)),
          child: const Text(
            "Add to Cart",
            style: TextStyle(fontSize: 18),
          ),
        ),
      )
          : const SizedBox.shrink(),
    );
  }
}
