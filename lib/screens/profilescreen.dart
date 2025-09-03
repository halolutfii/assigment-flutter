import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portofolio_app/routes.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';
import '../providers/user_providers.dart';

import 'editprofilescreen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().loadUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileData = context.watch<UserProvider>().profile;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: profileData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  buildProfileHeader(profileData),
                  const SizedBox(height: 20),
                  buildContactInfo(profileData),
                  const SizedBox(height: 20),
                  buildShortBioInfo(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget buildProfileHeader(User profile) {
    return Container(
      width: 370,
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: profile.image.isNotEmpty
                ? NetworkImage(profile.image)
                : const AssetImage('assets/images/lutfi.jpeg') as ImageProvider,
          ),
          const SizedBox(height: 8),
          Text(
            profile.name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            profile.department,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          Text(
            profile.position,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E3A59),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              textStyle: const TextStyle(fontSize: 14),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            },
            child: const Text("Edit Profile"),
          )
        ],
      ),
    );
  }

  Widget buildContactInfo(User profile) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Information',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow(icon: Icons.email_outlined, label: 'Email', value: profile.email),
          const SizedBox(height: 12),
          _buildInfoRow(icon: Icons.phone_outlined, label: 'Phone', value: profile.phone),
          const SizedBox(height: 12),
          _buildInfoRow(icon: Icons.location_on_outlined, label: 'Office Location', value: profile.location),
        ],
      ),
    );
  }

  Widget buildShortBioInfo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bio',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E3A59),
            ),
          ),
          SizedBox(height: 16),
          Text(
            'I’m a certified fullstack web developer with over 1 year of experience as an HRIS Technical Support (Programmer). I work on developing individual features in internal HCM systems end-to-end. My skill set includes Laravel, SQL Server, PostgreSQL, and other modern web technologies.',
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF4E5D7B),
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({required IconData icon, required String label, required String value}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF2E3A59).withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: const Color(0xFF2E3A59)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Color(0xFF6B7280))),
              const SizedBox(height: 2),
              Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1F2937))),
            ],
          ),
        ),
      ],
    );
  }
}