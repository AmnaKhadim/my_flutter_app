import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:fyp/menu.dart';
import 'package:fyp/saved_address.dart';
import 'viewprofile.dart';
import 'ratings.dart';
import 'logout.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<String> bannerImages = [
    'assets/images/banner1.jpg',
    'assets/images/banner2.jpg',
    'assets/images/banner3.jpg',
  ];

  final List<Map<String, String>> menuItems = [
    {'title': 'Soft Drinks', 'image': 'assets/images/drinks.jpg'},
    {'title': 'Grilled Bites', 'image': 'assets/images/grilledbites.jpg'},
    {'title': 'Regular Pizza', 'image': 'assets/images/regularpizza.jpg'},
    {'title': 'Special Pizza', 'image': 'assets/images/crowncrust.jpg'},
    {'title': 'Side Orders', 'image': 'assets/images/nuggets.jpg'},
    {'title': 'Addons', 'image': 'assets/images/mayodip.jpg'},
  ];

  void navigateTo(BuildContext context, Widget screen) {
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
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Explore Menu'),
            onTap: () => navigateTo(context, ExploreMenuScreen()),
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
            onTap: () => navigateTo(context, const Logout()),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.orange,
      ),
      drawer: buildDrawer("Amna Khadim", "0300-1234567"), // <- Pass user data here
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔹 Carousel Slider
            CarouselSlider(
              options: CarouselOptions(
                height: 200,
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
                    return Image.asset(
                      imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    );
                  },
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // 🔹 Menu Items Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: menuItems.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
              ),
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(menuItems[index]['image']!,
                          height: 80, fit: BoxFit.cover),
                      const SizedBox(height: 5),
                      Text(
                        menuItems[index]['title']!,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
