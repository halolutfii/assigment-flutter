import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_providers.dart';
import '../models/profile.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController locationController;

  bool _inited = false; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_inited) {
      final profile = context.read<ProfileProvider>().profile;
      nameController = TextEditingController(text: profile.name);
      positionController = TextEditingController(text: profile.position);
      locationController = TextEditingController(text: profile.location);
      _inited = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  void submitForm() {
    final updatedProfile = Profile(
      name: nameController.text,
      position: positionController.text,
      location: locationController.text,
    );

    context.read<ProfileProvider>().updateProfile(updatedProfile);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: const [
            Icon(Icons.check_circle, color: Colors.white),
            SizedBox(width: 8),
            Text("Profile updated successfully!"),
          ],
        ),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        duration: const Duration(seconds: 2),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2E3A59),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: positionController,
                decoration: const InputDecoration(labelText: "Position"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E3A59),
                foregroundColor: Colors.white,
              ),
              onPressed: submitForm,
              child: const Text("Save"),
            )
          ],
        ),
    );
  }
}