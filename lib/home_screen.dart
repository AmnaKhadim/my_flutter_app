import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui';
import 'branches.dart';
import 'signuplogin.dart';
import 'viewprofile.dart';
import 'favorites.dart';
import 'saved_address.dart';
import 'ratings.dart';
import 'orderhistory.dart';
import 'searchitems.dart';
import 'addtocart1.dart';
import 'cart_manager.dart';
import 'itemdetails.dart';

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
      'title': 'Soft Drinks',
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
      'title': 'Special Pizza',
      'image': 'assets/images/crowncrust.jpg',
      'price': '700',
      'category': 'Pizza'
    },
    {
      'title': 'Side Orders',
      'image': 'assets/images/nuggets.jpg',
      'price': '150',
      'category': 'Sides'
    },
    {
      'title': 'Addons',
      'image': 'assets/images/dipsauce.jpg',
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
            decoration: const BoxDecoration(color: Colors.orange),
            accountName: Text(name),
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
            leading: const Icon(Icons.favorite),
            title: const Text('Favorites'),
            onTap: () => navigateTo(context, const Favorites()),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: const Text('Saved Address'),
            onTap: () => navigateTo(context, const SavedAddress()),
          ),
          ListTile(
            leading: const Icon(Icons.star_rate),
            title: const Text('Ratings'),
            onTap: () => navigateTo(context, const Ratings()),
          ),
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Order History'),
            onTap: () => navigateTo(context, const OrderHistory()),
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
                            fontSize: 11, // ✅ Normal neat size
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
            // 🔹 Carousel Slider (90% height)
            CarouselSlider(
              options: CarouselOptions(
                height: screenHeight * 0.90,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1,
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
                      color: Colors.black12,
                      child: Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),

            SizedBox(height: screenHeight * 0.025),

            // 🔹 Explore Menu Heading
            Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Explore Menu",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: screenWidth * 0.030, // normal attractive size
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.01),
                  Container(
                    height: 2,
                    width: 50,
                    color: Colors.orange,
                  ),
                ],
              ),
            ),

            SizedBox(height: screenHeight * 0.01),

            // 🔹 Menu Items Grid (smaller cards)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // 3 per row
                childAspectRatio: 0.68, // smaller card height
              ),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => DetailScreen(item: menuItems[index]),
                      ),
                    );
                  },
                  child: Card(
                    margin: EdgeInsets.all(screenWidth * 0.010),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    elevation: 3,
                    child: Column(
                      children: [
                        Expanded(
                          flex: 3, // card size
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(10),
                            ),
                            child: Image.asset(
                              menuItems[index]['image']!,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1, // image size in card
                          child: Center(
                            child: Text(
                              menuItems[index]['title']!,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:
                                screenWidth * 0.020, // small neat text
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.orange,
        onTap: (index) {
          if (index == 0) {
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => SearchScreen(menuItems: menuItems),
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
