import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'SidesDetailScreen.dart';
import 'adonsDetailScreen.dart';
import 'bitedDetailScreen.dart';
import 'customized_item.dart';
import 'drinks_screen.dart';
import 'pizzaDetailScreen.dart';
import 'burgerdetailScreen.dart';
import 'dart:ui';
import 'branches.dart';
import 'signuplogin.dart';
import 'viewprofile.dart';
import 'saved_address.dart';
import 'ratings.dart';
import 'searchitems.dart';
import 'addtocart1.dart';
import 'cart_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> bannerImages = [
    'assets/images/banner1.png',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  final List<Map<String, String>> menuItems = [
    {
      'title': 'Drinks',
      'image': 'assets/images/drinks.jpg',
      'price': '50',
      'category': 'Drinks'
    },
    {
      'title': 'Grilled Bites',
      'image': 'assets/images/tikka.jpg',
      'price': '200',
      'category': 'Bites'
    },
    {
      'title': 'Regular Pizza',
      'image': 'assets/images/fajita.jpg',
      'price': '500',
      'category': 'Pizza'
    },
    {
      'title': 'Burgers',
      'image': 'assets/images/burger.jpg',
      'price': '700',
      'category': 'Burger'
    },
    {
      'title': 'Side Orders',
      'image': 'assets/images/nuggets.jpg',
      'price': '150',
      'category': 'Sides'
    },
    {
      'title': 'Addons',
      'image': 'assets/images/peri_mayo.png',
      'price': '30',
      'category': 'Extras'
    },
  ];

  void navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context);
    Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
  }

  Drawer buildDrawer(String name, String phone) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange, Colors.deepOrangeAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            accountName: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: Text(phone),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.orange),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('View Profile'),
            onTap: () => navigateTo(context, const ViewProfileScreen()),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Customized Items'),
            onTap: () => navigateTo(context, const CustomizeFoodScreen()),
          ),

          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Saved Address'),
            onTap: () => navigateTo(context, const SavedAddress()),
          ),
          ListTile(
            leading: const Icon(Icons.star_rate, color: Colors.amber),
            title: const Text('Ratings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RatingScreen(
                    orderItem: {
                      "title": "Your Food Name",           // ← yahan apna item daal do
                      "image": "assets/images/pizza.jpg",  // ← apni image path daal do
                      "totalPrice": 950.0,                 // ← jo price tha
                      "cheese": 2.0,
                      "olives": 1.0,
                      "spices": 1.5,
                    },
                    onSubmit: (rating, feedback) {
                      // Bas yahan print ya save kar do
                      print("Rating: $rating | Feedback: $feedback");
                    },
                  ),
                ),
              );
            },
          ),

          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (BuildContext context) {
                  return Stack(
                    children: [
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(color: Colors.black.withOpacity(0)),
                      ),
                      AlertDialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        title: const Text("Confirm Logout"),
                        content: const Text("Are you sure you want to logout?"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("Cancel"),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => SignupLoginScreen()),
                              );
                            },
                            child: const Text("Confirm Logout"),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        backgroundColor: Colors.orangeAccent,
        actions: [
          ValueListenableBuilder<List<Map<String, dynamic>>>(
            valueListenable: CartManager.cartItems,
            builder: (context, cart, _) {
              return Stack(
                children: [
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CartScreen(items: cart)),
                      );
                    },
                  ),
                  if (cart.isNotEmpty)
                    Positioned(
                      right: 6,
                      top: 6,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "${cart.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      drawer: buildDrawer("Amna", "0300-1234567"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- Carousel / Banners ---
            CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.9, // Full banner visible
                viewportFraction: 1.0,
                autoPlay: true,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: bannerImages.map((imagePath) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: screenWidth,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.1)
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: screenHeight * 0.02),

            // --- Explore Menu Section ---
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore Menu",
                    style: TextStyle(
                      fontSize: screenWidth * 0.032,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      letterSpacing: 1.1,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    height: 3,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.02),

            // --- Menu Items Grid ---
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02),
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.68,
                crossAxisSpacing: 10,
                mainAxisSpacing: 12,
              ),
              itemBuilder: (context, index) {
                final selectedItem = menuItems[index];
                return GestureDetector(
                  onTap: () {
                    if (selectedItem['category'] == 'Drinks') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              DrinksMenuScreen(item: selectedItem),
                        ),
                      );
                    } else if (selectedItem['category'] == 'Pizza') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              PizzaDetailScreen(item: selectedItem),
                        ),
                      );
                    } else if (selectedItem['category'] == 'Burger') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BurgersDetailScreen(item: selectedItem),
                        ),
                      );
                    } else if (selectedItem['category'] == 'Bites') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              BitesDetailScreen(item: selectedItem),
                        ),
                      );
                    } else if (selectedItem['category'] == 'Sides') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              SidesDetailScreen(item: selectedItem),
                        ),
                      );
                    } else if (selectedItem['category'] == 'Extras') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              ExtrasDetailScreen(item: selectedItem),
                        ),
                      );
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    shadowColor: Colors.black12,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(12)),
                            child: Image.asset(
                              selectedItem['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Text(
                              selectedItem['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: screenWidth * 0.022,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.orange,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchScreen(allItems: menuItems),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => BranchesScreen()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: "Branches"),
        ],
      ),
    );
  }
}
