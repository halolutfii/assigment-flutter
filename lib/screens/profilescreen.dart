import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../providers/user_provider.dart';
import '../routes.dart';

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
      context.read<UserProvider>().loadProfile(
            context.read<UserProvider>().user?.uid ?? "",
          );
    });
  }

  /// Fungsi untuk buka URL
  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<UserProvider>();
    final profile = provider.user;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: profile == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  buildProfileHeader(profile),
                  const SizedBox(height: 20),
                  buildContactInfo(profile),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget buildProfileHeader(profile) {
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
        children: [
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[200],
            backgroundImage: (profile.photo != null && profile.photo!.isNotEmpty)
                ? NetworkImage(profile.photo!)
                : null,
            child: (profile.photo == null || profile.photo!.isEmpty)
                ? const Icon(Icons.person, size: 50, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 8),
          Text(
            profile.name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (profile.profession != null)
            Text(
              profile.profession!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          if (profile.bio != null)
            Text(
              profile.bio!,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E3A59),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            },
            child: const Text("Update Profile"),
          ),
        ],
      ),
    );
  }

  Widget buildContactInfo(profile) {
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
          // Email
          _buildInfoRow(
            Icons.email_outlined,
            'Email',
            profile.email,
            onTap: () => _openUrl("mailto:${profile.email}"),
          ),
          const SizedBox(height: 12),

          // Phone
          if (profile.phone != null) ...[
              _buildInfoRow(
                Icons.phone_outlined,
                'Phone',
                profile.phone!,
                onTap: () => _openUrl("tel:${profile.phone}"),
              ),
            const SizedBox(height: 12),
          ],

          // Address
          if (profile.address != null) ...[
              _buildInfoRow(
                Icons.location_on_outlined,
                'Address',
                profile.address!,
                onTap: () => _openUrl(
                  "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(profile.address!)}",
                ),
              ),
            const SizedBox(height: 12),
          ],

          // LinkedIn
          if (profile.linkedin != null) ... [
              _buildInfoRow(
                FontAwesomeIcons.linkedin,
                'LinkedIn',
                profile.linkedin!,
                onTap: () {
                  final url = profile.linkedin!.startsWith("http")
                      ? profile.linkedin!
                      : "https://${profile.linkedin!}";
                  _openUrl(url);
                },
              ),
            const SizedBox(height: 12),
          ],

          // GitHub
          if (profile.github != null) ...[
            _buildInfoRow(
              FontAwesomeIcons.github,
              'GitHub',
              profile.github!,
              onTap: () {
                final url = profile.github!.startsWith("http")
                    ? profile.github!
                    : "https://${profile.github!}";
                _openUrl(url);
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value, {VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Row(
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
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}