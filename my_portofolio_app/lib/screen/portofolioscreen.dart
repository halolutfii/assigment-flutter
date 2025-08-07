import 'package:flutter/material.dart';
import 'package:my_portofolio_app/components/footer.dart';

class PortofolioScreen extends StatelessWidget {
  final List<Map<String, dynamic>> projects = [
    {
      'title': 'HRIS Dashboard',
      'description': 'An internal tool for managing employee data.',
      'technologies': ['Laravel', 'PostgreSQL', 'Bootstrap'],
      'image': 'assets/images/erp.png',
    },
    {
      'title': 'ERP Inventory App',
      'description': 'Helps manage warehouse stock and flow.',
      'technologies': ['Flutter', 'Firebase', 'Node.js'],
      'image': 'assets/images/inventory.png',
    },
    {
      'title': 'Company Profile Website',
      'description': 'A responsive web for company branding.',
      'technologies': ['HTML', 'CSS', 'JavaScript'],
      'image': 'assets/images/companyprofile.jpeg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        ...projects.map((project) => buildProjectCard(
              title: project['title'],
              description: project['description'],
              tech: List<String>.from(project['technologies']),
              imagePath: project['image'],
            )),
        const SizedBox(height: 30),
        Footer(),
      ],
    ),
    );
  }

  Widget buildProjectCard({
    required String title,
    required String description,
    required List<String> tech,
    required String imagePath,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 8),
                Text(description,
                    maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: tech
                      .map((t) => Chip(
                            label: Text(t),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}