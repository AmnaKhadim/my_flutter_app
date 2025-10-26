import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'edit_profile.dart';

class ViewProfileScreen extends StatefulWidget {
  const ViewProfileScreen({super.key});

  @override
  State<ViewProfileScreen> createState() => _ViewProfileScreenState();
}

class _ViewProfileScreenState extends State<ViewProfileScreen> {
  // Default user data
  String name = "Amna khadim";
  String email = "amna@example.com";
  String phone = "+92 300 1234567";
  String address = "Sahiwal, Pakistan";

  // Image variables
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  // Show dialog options
  void _showImageOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profile Picture Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text('Change Image'),
                onTap: () async {
                  final pickedFile =
                  await _picker.pickImage(source: ImageSource.gallery);
                  if (pickedFile != null) {
                    setState(() {
                      _imageFile = File(pickedFile.path);
                    });
                  }
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('Delete Image'),
                onTap: () {
                  setState(() {
                    _imageFile = null;
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _imageFile = null;
                });
                Navigator.pop(context);
              },
              child: const Text('Restore Default'),
            ),
          ],
        );
      },
    );
  }

  // Update data after edit screen
  void _updateProfileData(Map<String, String> updatedData) {
    setState(() {
      name = updatedData['name']!;
      email = updatedData['email']!;
      phone = updatedData['phone']!;
      address = updatedData['address']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
        const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile image
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.orange.shade300,
                  backgroundImage:
                  _imageFile != null ? FileImage(_imageFile!) : null,
                  child: _imageFile == null
                      ? const Icon(Icons.person, size: 60, color: Colors.white)
                      : null,
                ),
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.white, size: 20),
                    onPressed: _showImageOptionsDialog,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // User Info Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    ProfileInfoRow(icon: Icons.person, label: 'Full Name', value: name),
                    const Divider(),
                    ProfileInfoRow(icon: Icons.email, label: 'Email', value: email),
                    const Divider(),
                    ProfileInfoRow(icon: Icons.phone, label: 'Phone', value: phone),
                    const Divider(),
                    ProfileInfoRow(icon: Icons.location_on, label: 'Address', value: address),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Edit Profile Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(
                        name: name,
                        email: email,
                        phone: phone,
                        address: address,
                      ),
                    ),
                  );

                  if (result != null && result is Map<String, String>) {
                    _updateProfileData(result);
                  }
                },
                icon: const Icon(Icons.edit),
                label: const Text('Edit Profile'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  textStyle: const TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable Row widget
class ProfileInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.orange),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 5),
              Text(value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87)),
            ],
          ),
        ),
      ],
    );
  }
}
