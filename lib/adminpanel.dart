import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int selectedIndex = 0;

  final List<String> menuItems = [
    "Dashboard",
    "Manage Menu",
    "Orders",
    "Users",
    "Track Deliveries",
    "Payments",
    "Settings",
    "Logout"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("City Sizzle Admin Panel",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.orange.shade700,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: Colors.white)),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.help_outline, color: Colors.white)),
          IconButton(
              onPressed: () {
                _confirmLogout();
              },
              icon: const Icon(Icons.logout, color: Colors.white)),
        ],
      ),
      body: Row(
        children: [
          // --- Left Sidebar ---
          Container(
            width: 220,
            color: Colors.orange.shade100,
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(
                    _getIconForMenu(menuItems[index]),
                    color: selectedIndex == index
                        ? Colors.orange.shade800
                        : Colors.grey.shade700,
                  ),
                  title: Text(
                    menuItems[index],
                    style: TextStyle(
                      color: selectedIndex == index
                          ? Colors.orange.shade800
                          : Colors.grey.shade800,
                      fontWeight: selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                  tileColor: selectedIndex == index
                      ? Colors.orange.shade200
                      : Colors.transparent,
                  onTap: () {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                );
              },
            ),
          ),

          // --- Main Content Area ---
          Expanded(
            child: Container(
              color: Colors.orange.shade50,
              padding: const EdgeInsets.all(20),
              child: _getSelectedScreen(menuItems[selectedIndex]),
            ),
          ),
        ],
      ),
    );
  }

  // Icons for sidebar
  IconData _getIconForMenu(String title) {
    switch (title) {
      case "Dashboard":
        return Icons.dashboard;
      case "Manage Menu":
        return Icons.restaurant_menu;
      case "Orders":
        return Icons.shopping_bag;
      case "Users":
        return Icons.people;
      case "Track Deliveries":
        return Icons.local_shipping;
      case "Payments":
        return Icons.payment;
      case "Settings":
        return Icons.settings;
      case "Logout":
        return Icons.exit_to_app;
      default:
        return Icons.circle;
    }
  }

  // Screen routing
  Widget _getSelectedScreen(String title) {
    switch (title) {
      case "Dashboard":
        return _buildDashboard();
      case "Manage Menu":
        return _buildManageMenu();
      case "Orders":
        return _buildOrders();
      case "Users":
        return _buildUsers();
      case "Track Deliveries":
        return _buildTrackDeliveries();
      case "Payments":
        return _buildPayments();
      case "Settings":
        return _buildSettings();
      case "Logout":
        return _buildLogout();
      default:
        return const Center(child: Text("Page Not Found"));
    }
  }

  // ---------------- Dashboard ----------------
  Widget _buildDashboard() {
    return GridView.count(
      crossAxisCount: 3,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        _buildDashboardCard(Icons.shopping_bag, "Total Orders", "154"),
        _buildDashboardCard(Icons.people, "Total Customers", "87"),
        _buildDashboardCard(Icons.attach_money, "Total Revenue", "PKR 52,300"),
        _buildDashboardCard(Icons.restaurant_menu, "Menu Items", "42"),
        _buildDashboardCard(Icons.local_shipping, "Active Deliveries", "9"),
        _buildDashboardCard(Icons.reviews, "Pending Reviews", "12"),
      ],
    );
  }

  Widget _buildDashboardCard(IconData icon, String title, String value) {
    return InkWell(
      onTap: () => _showInfoDialog(title, value),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 6)],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.orange.shade700),
            const SizedBox(height: 10),
            Text(value,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade900)),
            const SizedBox(height: 5),
            Text(title, style: const TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  // ---------------- Manage Menu ----------------
  Widget _buildManageMenu() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Manage Menu",
            style: TextStyle(
                fontSize: 22,
                color: Colors.orange.shade900,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: _showAddMenuDialog,
          icon: const Icon(Icons.add),
          label: const Text("Add New Item"),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
        ),
        const SizedBox(height: 15),
        Expanded(
          child: ListView.builder(
            itemCount: 5,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: const Icon(Icons.fastfood, color: Colors.orange),
                title: Text("Item ${index + 1}"),
                subtitle: const Text("Price: PKR 499"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () => _showEditMenuDialog(index),
                        icon: const Icon(Icons.edit, color: Colors.blue)),
                    IconButton(
                        onPressed: () => _confirmDeleteItem(index),
                        icon: const Icon(Icons.delete, color: Colors.red)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showAddMenuDialog() {
    final nameController = TextEditingController();
    final priceController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Menu Item"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: "Item Name")),
            TextField(controller: priceController, decoration: const InputDecoration(labelText: "Price")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                if (nameController.text.isEmpty || priceController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
                } else {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("${nameController.text} added!")));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Save")),
        ],
      ),
    );
  }

  void _showEditMenuDialog(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Item #${index + 1}"),
        content: const Text("Here you can edit the item details."),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Item updated!")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Save")),
        ],
      ),
    );
  }

  void _confirmDeleteItem(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Delete"),
        content: Text("Are you sure you want to delete Item #${index + 1}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("Item #${index + 1} deleted")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Delete")),
        ],
      ),
    );
  }

  // ---------------- Orders ----------------
  Widget _buildOrders() {
    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListTile(
          leading: const Icon(Icons.receipt_long, color: Colors.orange),
          title: Text("Order #00${index + 1}"),
          subtitle: const Text("Status: Pending | Total: PKR 1200"),
          trailing: ElevatedButton(
            onPressed: () => _markDelivered(index),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text("Mark Delivered"),
          ),
        ),
      ),
    );
  }

  void _markDelivered(int index) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Order #00${index + 1} marked as delivered")));
  }

  // ---------------- Users ----------------
  Widget _buildUsers() {
    return ListView.builder(
      itemCount: 4,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.person, color: Colors.orange),
          title: Text("User ${index + 1}"),
          subtitle: const Text("Email: user@example.com"),
          trailing: IconButton(
              onPressed: () => _blockUser(index),
              icon: const Icon(Icons.block, color: Colors.red)),
        ),
      ),
    );
  }

  void _blockUser(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Block User"),
        content: Text("Do you really want to block User ${index + 1}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text("User ${index + 1} blocked")));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Block")),
        ],
      ),
    );
  }

  // ---------------- Deliveries ----------------
  Widget _buildTrackDeliveries() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.local_shipping, color: Colors.orange),
          title: Text("Delivery ID: D00${index + 1}"),
          subtitle: const Text("Status: On the way | ETA: 15 min"),
          trailing: ElevatedButton(
            onPressed: () =>
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Delivery D00${index + 1} completed"))),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Mark Delivered"),
          ),
        ),
      ),
    );
  }

  // ---------------- Payments ----------------
  Widget _buildPayments() {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, index) => Card(
        child: ListTile(
          leading: const Icon(Icons.payment, color: Colors.orange),
          title: Text("Payment #P00${index + 1}"),
          subtitle: const Text("Amount: PKR 2500 | Status: Pending"),
          trailing: ElevatedButton(
            onPressed: () => _approvePayment(index),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            child: const Text("Approve"),
          ),
        ),
      ),
    );
  }

  void _approvePayment(int index) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Payment #P00${index + 1} approved")));
  }

  // ---------------- Settings ----------------
  Widget _buildSettings() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Settings",
            style: TextStyle(
                fontSize: 22,
                color: Colors.orange.shade900,
                fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.lock, color: Colors.orange),
          title: const Text("Change Admin Password"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _changePasswordDialog,
        ),
        ListTile(
          leading: const Icon(Icons.person, color: Colors.orange),
          title: const Text("Edit Profile"),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: _editProfileDialog,
        ),
      ],
    );
  }

  void _changePasswordDialog() {
    final oldCtrl = TextEditingController();
    final newCtrl = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Change Password"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: oldCtrl, decoration: const InputDecoration(labelText: "Old Password")),
            TextField(controller: newCtrl, decoration: const InputDecoration(labelText: "New Password")),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                if (newCtrl.text.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Password updated successfully")));
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
              child: const Text("Save")),
        ],
      ),
    );
  }

  void _editProfileDialog() {
    showDialog(
      context: context,
      builder: (context) => const AlertDialog(
        title: Text("Edit Profile"),
        content: Text("Here you can update your profile information."),
      ),
    );
  }

  // ---------------- Logout ----------------
  Widget _buildLogout() {
    return Center(
      child: ElevatedButton.icon(
        icon: const Icon(Icons.exit_to_app),
        label: const Text("Logout"),
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent, padding: const EdgeInsets.all(16)),
        onPressed: _confirmLogout,
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to logout?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text("Logout")),
        ],
      ),
    );
  }

  // ---------------- Helper Info Dialog ----------------
  void _showInfoDialog(String title, String value) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text("Current count/value: $value"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK")),
        ],
      ),
    );
  }
}
