import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/appbar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isSaving = false;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      Provider.of<UserProvider>(context, listen: false)
          .setSelectedImage(File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<UserProvider>(context);
    final user = provider.user;

    return Scaffold(
      appBar: CustomAppBar(
        title: "Update Profile",
        onBack: () => Navigator.pop(context),
        showDrawer: false,
      ),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: provider.formKey,
          child: Column(
            children: [
              // Avatar
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[200],
                    backgroundImage: provider.selectedImage != null
                        ? FileImage(provider.selectedImage!)
                        : (user?.photo != null && user!.photo!.isNotEmpty
                            ? NetworkImage(user.photo!)
                            : null) as ImageProvider<Object>?,
                    child: provider.selectedImage == null &&
                            (user?.photo == null || user!.photo!.isEmpty)
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: GestureDetector(
                      onTap: () => _pickImage(context),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF2E3A59),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Full Name
              TextFormField(
                controller: provider.nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Full Name required";
                  if (val.length < 3) return "Min 3 characters";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Profession
              TextFormField(
                controller: provider.professionController,
                decoration: const InputDecoration(labelText: "Profession"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Profession required" : null,
              ),
              const SizedBox(height: 12),

              // Phone
              TextFormField(
                controller: provider.phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.isEmpty ? "Phone required" : null,
              ),
              const SizedBox(height: 12),

              // Address
              TextFormField(
                controller: provider.addressController,
                decoration: const InputDecoration(labelText: "Address"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Address required";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // LinkedIn
              TextFormField(
                controller: provider.linkedinController,
                decoration: const InputDecoration(labelText: "LinkedIn"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "LinkedIn required";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Github
              TextFormField(
                controller: provider.githubController,
                decoration: const InputDecoration(labelText: "Github"),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Github required";
                  return null;
                },
              ),
              const SizedBox(height: 12),

              // Bio
              TextFormField(
                controller: provider.bioController,
                decoration: const InputDecoration(labelText: "Bio"),
                maxLines: 3,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Bio required";
                  return null;
                },
              ),
              const SizedBox(height: 20),
              
              isSaving || provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF2E3A59),
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () async {
                            if (provider.formKey.currentState!.validate()) {
                              setState(() => isSaving = true);

                              await provider.updateProfile();

                              setState(() => isSaving = false);

                              if (context.mounted) {
                                Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Row(
                                        children: const [
                                          Icon(Icons.check_circle, color: Colors.white),
                                          SizedBox(width: 8),
                                          Text("Update profile successfully!"),
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
                                }
                            }
                          },
                          child: const Text(
                            "Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                title: const Text("Cancel"),
                                content: const Text("Are you sure you want to cancel?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx),
                                    child: const Text("No"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(ctx);
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              ),
                            );
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}