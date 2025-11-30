import 'package:flutter/material.dart';
import 'drinks_screen.dart';
import 'pizzaDetailScreen.dart';
import 'burgerdetailScreen.dart';
import 'bitedDetailScreen.dart';
import 'SidesDetailScreen.dart';
import 'adonsDetailScreen.dart';

class SearchScreen extends StatefulWidget {
  final List<Map<String, String>> allItems; // all items passed from home

  const SearchScreen({super.key, required this.allItems});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> searchResults = [];

  void _searchItems(String query) {
    if (query.isEmpty) {
      setState(() => searchResults = []);
      return;
    }
    final results = widget.allItems
        .where((item) => item['title']!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() => searchResults = results);
  }

  void navigateToDetail(Map<String, String> item) {
    if (item['category'] == 'Drinks') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DrinksMenuScreen(item: item)),
      );
    } else if (item['category'] == 'Pizza') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => PizzaDetailScreen(item: item)),
      );
    } else if (item['category'] == 'Burger') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BurgersDetailScreen(item: item)),
      );
    } else if (item['category'] == 'Bites') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BitesDetailScreen(item: item)),
      );
    } else if (item['category'] == 'Sides') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => SidesDetailScreen(item: item)),
      );
    } else if (item['category'] == 'Extras') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => ExtrasDetailScreen(item: item)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Color(0xFFFFE0B2)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: TextField(
                          controller: searchController,
                          onChanged: _searchItems,
                          decoration: InputDecoration(
                            hintText: "Search food, drinks, pizza...",
                            filled: true,
                            fillColor: Colors.white,
                            prefixIcon: const Icon(Icons.search, color: Colors.orange),
                            contentPadding: const EdgeInsets.all(12),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: searchController.text.isEmpty
                      ? const Center(
                    child: Text(
                      "Start typing to search 🔎",
                      style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Colors.grey),
                    ),
                  )
                      : searchResults.isEmpty
                      ? const Center(
                    child: Text(
                      "❌ No items found",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.redAccent),
                    ),
                  )
                      : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      final item = searchResults[index];
                      return GestureDetector(
                        onTap: () => navigateToDetail(item),
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 3,
                          child: ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item['image']!,
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              item['title']!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            trailing: const Icon(Icons.arrow_forward_ios,
                                color: Colors.orange, size: 18),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
