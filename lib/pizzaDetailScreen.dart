import 'package:flutter/material.dart';
import 'cart_manager.dart';


class PizzaDetailScreen extends StatefulWidget {
  final Map<String, dynamic> item; // e.g., {"title": "Pizza Menu", "image": "assets/pizza_banner.png"}

  const PizzaDetailScreen({super.key, required this.item});
  @override
  State<PizzaDetailScreen> createState() => _PizzaDetailScreenState();
}

class _PizzaDetailScreenState extends State<PizzaDetailScreen> {
  /// Track which size is selected for each pizza
  Map<int, int> selectedSizeIndex = {};

  /// Complete Pizza List
  final List<Map<String, dynamic>> pizzaList = [
    // Special Pizza
    {
      "name": "Behari Kabab Pizza",
      "image": "assets/images/beharikabab.png",
      "sizes": [
        {"label": "Small", "price": 650},
        {"label": "Medium", "price": 950},
        {"label": "Large", "price": 1350},
        {"label": "XL", "price": 1700},
      ]
    },
    {
      "name": "Malai Boti Pizza",
      "image": "assets/images/malaibotipizza.jpg",
      "sizes": [
        {"label": "Small", "price": 650},
        {"label": "Medium", "price": 950},
        {"label": "Large", "price": 1350},
        {"label": "XL", "price": 1700},
      ]
    },
    {
      "name": "Bone Fire Pizza",
      "image": "assets/images/bonefirepizza.jpg",
      "sizes": [
        {"label": "Small", "price": 650},
        {"label": "Medium", "price": 950},
        {"label": "Large", "price": 1350},
        {"label": "XL", "price": 1700},
      ]
    },
    {
      "name": "Peri Peri Pizza",
      "image": "assets/images/peperoni.jpg",
      "sizes": [
        {"label": "Small", "price": 650},
        {"label": "Medium", "price": 950},
        {"label": "Large", "price": 1350},
        {"label": "XL", "price": 1700},
      ]
    },
    {
      "name": "BBQ Lover",
      "image": "assets/images/bbqpizza.jpg",
      "sizes": [
        {"label": "Small", "price": 650},
        {"label": "Medium", "price": 950},
        {"label": "Large", "price": 1350},
        {"label": "XL", "price": 1700},
      ]
    },

    // Regular Pizza
    {
      "name": "Tandoori Pizza",
      "image": "assets/images/tandooripizza.jpg",
      "sizes": [
        {"label": "Small", "price": 550},
        {"label": "Medium", "price": 850},
        {"label": "Large", "price": 1200},
        {"label": "XL", "price": 1600},
      ]
    },
    {
      "name": "Chicken Fajita Pizza",
      "image": "assets/images/fajita.jpg",
      "sizes": [
        {"label": "Small", "price": 550},
        {"label": "Medium", "price": 850},
        {"label": "Large", "price": 1200},
        {"label": "XL", "price": 1600},
      ]
    },
    {
      "name": "Kabab stuffer Pizza",
      "image": "assets/images/kababstuffer.jpg",
      "sizes": [
        {"label": "Small", "price": 550},
        {"label": "Medium", "price": 900},
        {"label": "Large", "price": 1300},
        {"label": "XL", "price": 1650},
      ]
    },
    {
      "name": "Hot & Spicy Pizza",
      "image": "assets/images/italianstylepizza.jpg",
      "sizes": [
        {"label": "Small", "price": 550},
        {"label": "Medium", "price": 900},
        {"label": "Large", "price": 1300},
        {"label": "XL", "price": 1650},
      ]
    },
    {
      "name": "Cheese Lover Pizza",
      "image": "assets/images/cheeselover.jpg",
      "sizes": [
        {"label": "Small", "price": 550},
        {"label": "Medium", "price": 850},
        {"label": "Large", "price": 1200},
        {"label": "XL", "price": 1600},
      ]
    },
    {
      "name": "Veggie Lover Pizza",
      "image": "assets/images/veggiepizza.jpg",
      "sizes": [
        {"label": "Small", "price": 550},
        {"label": "Medium", "price": 850},
        {"label": "Large", "price": 1200},
        {"label": "XL", "price": 1600},
      ]
    },

    // Crust Pizza

    {
      "name": "Cheese Crust",
      "image": "assets/images/cheeselover.jpg",
      "sizes": [
        {"label": "Small", "price": 1200},
        {"label": "Medium", "price": 1600},
        {"label": "Large", "price": 2000},
        {"label": "XL", "price": 2400},
      ]
    },
    {
      "name": "Crown Crust",
      "image": "assets/images/crowncrust.jpg",
      "sizes": [
        {"label": "Small", "price": 1200},
        {"label": "Medium", "price": 1600},
        {"label": "Large", "price": 2000},
        {"label": "XL", "price": 2400},
      ]
    },

    // Lasagna Pizza
    {
      "name": "Lasagna Pizza",
      "image": "assets/images/lasaniapizza.jpg",
      "sizes": [
        {"label": "Small-7\"", "price": 750},
        {"label": "Medium-11\"", "price": 1300},
        {"label": "Large-14\"", "price": 1850},
        {"label": "XL-17\"", "price": 2500},
      ]
    },
  ];

  void addToCart(int pizzaIndex) {
    final pizza = pizzaList[pizzaIndex];

    if (!selectedSizeIndex.containsKey(pizzaIndex)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Select size first!")),
      );
      return;
    }

    final selected = pizza["sizes"][selectedSizeIndex[pizzaIndex]!];

    CartManager.addItem({
      "title": pizza["name"],
      "size": selected["label"],
      "price": selected["price"].toString(),
      "image": pizza["image"]
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Added to cart!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizza Menu"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: pizzaList.length,
        itemBuilder: (context, index) {
          final pizza = pizzaList[index];
          final sizes = pizza["sizes"];

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
                      // Pizza Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          pizza["image"],
                          width: 90,
                          height: 90,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Right Side
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              pizza["name"],
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),

                            // Sizes selector
                            SizedBox(
                              height: 40,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (context, sIndex) {
                                  final selected = selectedSizeIndex[index] == sIndex;
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSizeIndex[index] = sIndex;
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
                                        sizes[sIndex]["label"],
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
                              selectedSizeIndex.containsKey(index)
                                  ? "Price: Rs ${sizes[selectedSizeIndex[index]]["price"]}"
                                  : "Select a size",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 10),

                            // Add Button
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
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Divider after each pizza
              const Divider(
                color: Colors.grey,
                thickness: 1,
                height: 10,
              ),
            ],
          );
        },
      ),
    );
  }
}
