import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

// Data Profil
const String name = "Lutfi Cahya Nugraha";
const String profession = "Junior Software Engineer";
const String email = "lutfi.cahya@solecode.id";
const String phone = "+62 821-1083-3753";
const String address = "Tangerang Selatan, Indonesia";
const String bio =
    "I’m a certified fullstack web developer with over 1 years of experience as an HRIS Technical Support (Programmer). I work on developing individual features in internal HCM systems end-to-end from requirement analysis and development to implementation. My skill set includes Laravel, SQL Server, PostgreSQL, and other modern web technologies.";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Profile"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // UI Only
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildProfileHeader(),
            const SizedBox(height: 20),
            buildProfileInfo(),
            const SizedBox(height: 20),
            buildProfileBio(),
          ],
        ),
      ),
    );
  }
}

// FOTO + NAMA
Widget buildProfileHeader() {
  return Column(
    children: [
      const CircleAvatar(
        radius: 50,
        backgroundImage: AssetImage('assets/images/lutfi.jpeg'), 
      ),
      const SizedBox(height: 10),
      Text(
        name,
        style: GoogleFonts.poppins(
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        profession,
        style: GoogleFonts.poppins(
          fontSize: 16,
          color: Colors.grey[600],
        ),
      ),
    ],
  );
}

// Contact Profile
Widget buildProfileInfo() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      InfoRow(icon: Icons.email, text: email),
      InfoRow(icon: Icons.phone, text: phone),
      InfoRow(icon: Icons.location_on, text: address),
    ],
  );
}

// About Me
Widget buildProfileBio() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: const [
      Text(
        "About Me",
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        bio,
        style: TextStyle(fontSize: 16),
        textAlign: TextAlign.justify,
      ),
    ],
  );
}

// REUSABLE ROW
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const InfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}