import 'package:flutter/material.dart';
import 'cart_manager.dart'; // Tumhara CartManager same rahega

class CustomizeFoodScreen extends StatefulWidget {
  final Map<String, dynamic>? itemData;

  const CustomizeFoodScreen({super.key, this.itemData});

  @override
  State<CustomizeFoodScreen> createState() => _CustomizeFoodScreenState();
}

class _CustomizeFoodScreenState extends State<CustomizeFoodScreen> {
  // Har item ke liye alag-alag customization store karne ke liye
  final Map<String, Map<String, double>> customizations = {
    "Pizza": {"cheese": 1.0, "olives": 1.0, "spices": 1.0},
    "Burger": {"cheese": 1.0, "olives": 1.0, "spices": 1.0},
    "Fries": {"cheese": 1.0, "olives": 1.0, "spices": 1.0},
  };

  String selectedItem = "Pizza";

  final Map<String, double> basePrices = {
    "Pizza": 800,
    "Burger": 500,
    "Fries": 300,
  };

  // Current item ke values nikalne ke liye shortcuts
  double get cheese => customizations[selectedItem]!["cheese"]!;
  double get olives => customizations[selectedItem]!["olives"]!;
  double get spices => customizations[selectedItem]!["spices"]!;

  // Total price calculate with extras
  double get totalPrice {
    double base = basePrices[selectedItem] ?? 0;
    double extras = (cheese - 1) * 50 + (olives - 1) * 40 + (spices - 1) * 20;
    return base + extras;
  }

  String getImage(String item) {
    if (widget.itemData != null && widget.itemData!['image'] != null) {
      return widget.itemData!['image'] as String;
    }
    switch (item) {
      case "Burger":
        return "assets/images/burger.jpg";
      case "Fries":
        return "assets/images/fries.jpg";
      default:
        return "assets/images/veggiepizza.jpg";
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.itemData != null && widget.itemData!['title'] != null) {
      selectedItem = widget.itemData!['title'] as String;

      // Agar koi naya item aaya ho (jaise future mein Pasta add karo) to uske liye default bana do
      customizations.putIfAbsent(
          selectedItem, () => {"cheese": 1.0, "olives": 1.0, "spices": 1.0});
    }
  }

  void addToCart() {
    final itemToAdd = {
      "id": "${selectedItem}_${DateTime.now().millisecondsSinceEpoch}", // Unique ID
      "title": selectedItem,
      "image": getImage(selectedItem),
      "basePrice": basePrices[selectedItem],
      "cheese": cheese,
      "olives": olives,
      "spices": spices,
      "totalPrice": totalPrice,
      "quantity": 1,
    };

    CartManager.addItem(itemToAdd);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$selectedItem added to cart! • PKR ${totalPrice.toStringAsFixed(0)}"),
        backgroundColor: Colors.green.shade600,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void updateValue(String key, double value) {
    setState(() {
      customizations[selectedItem]![key] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        title: const Text("Customize Your Meal"),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
      ),
      body: isWide ? wideLayout() : mobileLayout(),
    );
  }

  Widget wideLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(flex: 2, child: menuColumn()),
        Expanded(flex: 5, child: customizationColumn()),
        Expanded(flex: 3, child: summaryColumn()),
      ],
    );
  }

  Widget mobileLayout() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _menuDropdown(),
        const SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.asset(
            getImage(selectedItem),
            height: 220,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 20),
        _sliderOption("Extra Cheese", "cheese"),
        _sliderOption("Olives", "olives"),
        _sliderOption("Spices Level", "spices"),
        const SizedBox(height: 30),
        Card(
          elevation: 4,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Text(
                  "Total Amount",
                  style: TextStyle(fontSize: 20, color: Colors.grey[700]),
                ),
                Text(
                  "PKR ${totalPrice.toStringAsFixed(0)}",
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: addToCart,
            icon: const Icon(Icons.shopping_cart_outlined, size: 28),
            label: const Text("Add to Cart", style: TextStyle(fontSize: 18)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ],
    );
  }

  Widget menuColumn() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Menu",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          _menuItem("Pizza"),
          _menuItem("Burger"),
          _menuItem("Fries"),
        ],
      ),
    );
  }

  Widget customizationColumn() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                getImage(selectedItem),
                height: 280,
                width: 280,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              selectedItem,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            Text(
              "Base Price: PKR ${basePrices[selectedItem]?.toStringAsFixed(0)}",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1.5),
            const SizedBox(height: 10),
            const Text(
              "Customize Ingredients",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            _sliderOption("Extra Cheese", "cheese"),
            _sliderOption("Olives", "olives"),
            _sliderOption("Spices", "spices"),
          ],
        ),
      ),
    );
  }

  Widget summaryColumn() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: _cardDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Order Summary",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.orange),
            ),
            const SizedBox(height: 20),
            _summaryRow("Item", selectedItem),
            _summaryRow("Cheese", "${cheese.toStringAsFixed(1)}x"),
            _summaryRow("Olives", "${olives.toStringAsFixed(1)}x"),
            _summaryRow("Spices", "${spices.toStringAsFixed(1)}x"),
            const Divider(height: 40, thickness: 1.5),
            _summaryRow(
              "Total",
              "PKR ${totalPrice.toStringAsFixed(0)}",
              isTotal: true,
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: addToCart,
                icon: const Icon(Icons.add_shopping_cart, size: 28),
                label: const Text("Add to Cart", style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 22 : 18, fontWeight: isTotal ? FontWeight.bold : FontWeight.w500)),
          Text(value, style: TextStyle(fontSize: isTotal ? 26 : 18, fontWeight: isTotal ? FontWeight.bold : FontWeight.w600, color: Colors.orange)),
        ],
      ),
    );
  }

  Widget _menuItem(String title) {
    bool isActive = selectedItem == title;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedItem = title;
          // Optional: Naya item select karne pe customization reset karna chahte ho to ye line uncomment karo
          // customizations[title] = {"cheese": 1.0, "olives": 1.0, "spices": 1.0};
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isActive ? Colors.orange.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isActive ? Colors.orange : Colors.grey.shade300, width: 2),
          boxShadow: isActive
              ? [BoxShadow(color: Colors.orange.withOpacity(0.3), blurRadius: 10)]
              : null,
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: isActive ? Colors.orange.shade700 : Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _sliderOption(String label, String key) {
    double value = customizations[selectedItem]![key]!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$label: ${value.toStringAsFixed(1)}x",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Slider(
          value: value,
          min: 0.0, // Ab zero bhi allowed hai (no extra)
          max: 3.0,
          divisions: 6,
          label: value.toStringAsFixed(1),
          activeColor: Colors.orange,
          inactiveColor: Colors.orange.shade100,
          onChanged: (v) => updateValue(key, v),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _menuDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedItem,
      decoration: InputDecoration(
        labelText: "Choose Item",
        prefixIcon: Icon(Icons.food_bank),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: ["Pizza", "Burger", "Fries"]
          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
          .toList(),
      onChanged: (v) => setState(() => selectedItem = v ?? "Pizza"),
    );
  }

  BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ],
    );
  }
}