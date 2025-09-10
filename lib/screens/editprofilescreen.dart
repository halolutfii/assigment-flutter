// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../providers/user_providers.dart';
// import '../models/user.dart';
// import '../services/user_service.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({super.key});

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   late TextEditingController nameController;
//   late TextEditingController positionController;
//   late TextEditingController locationController;

//   bool _inited = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_inited) {
//       final profile = context.read<UserProvider>().profile;
//       nameController = TextEditingController(text: profile?.name ?? '');
//       positionController = TextEditingController(text: profile?.position ?? '');
//       locationController = TextEditingController(text: profile?.location ?? '');
//       _inited = true;
//     }
//   }

//   @override
//   void dispose() {
//     nameController.dispose();
//     positionController.dispose();
//     locationController.dispose();
//     super.dispose();
//   }

//   Future<void> submitForm() async {
//     final userProvider = context.read<UserProvider>();
//     final currentUser = userProvider.profile;
//     if (currentUser == null) return;

//     // buat object baru dengan field yang diperbarui
//     final updatedUser = User(
//       id: currentUser.id,
//       name: nameController.text.trim(),
//       email: currentUser.email,
//       department: currentUser.department,
//       position: positionController.text.trim(),
//       image: currentUser.image,
//       phone: currentUser.phone,
//       location: locationController.text.trim(),
//       role: currentUser.role,
//     );

//     try {
//       await UserService().updateUser(updatedUser); // panggil service untuk update di backend
//       await userProvider.loadUser(); // reload data terbaru

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: const [
//               Icon(Icons.check_circle, color: Colors.white),
//               SizedBox(width: 8),
//               Text("Profile updated successfully!"),
//             ],
//           ),
//           backgroundColor: Colors.green,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           duration: const Duration(seconds: 2),
//         ),
//       );

//       Navigator.pop(context);
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Row(
//             children: const [
//               Icon(Icons.error, color: Colors.white),
//               SizedBox(width: 8),
//               Text("Failed to update profile."),
//             ],
//           ),
//           backgroundColor: Colors.red,
//           behavior: SnackBarBehavior.floating,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//           duration: const Duration(seconds: 2),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           "Edit Profile",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
//         ),
//         centerTitle: true,
//         backgroundColor: const Color(0xFF2E3A59),
//         iconTheme: const IconThemeData(color: Colors.white),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             TextField(
//               controller: nameController,
//               decoration: const InputDecoration(labelText: "Name"),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: positionController,
//               decoration: const InputDecoration(labelText: "Position"),
//             ),
//             const SizedBox(height: 12),
//             TextField(
//               controller: locationController,
//               decoration: const InputDecoration(labelText: "Location"),
//             ),
//             const SizedBox(height: 20),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color(0xFF2E3A59),
//                   foregroundColor: Colors.white,
//                   padding: const EdgeInsets.symmetric(vertical: 14),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 onPressed: submitForm,
//                 child: const Text("Save"),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }