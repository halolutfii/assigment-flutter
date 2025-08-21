import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/portofolio_providers.dart';

import 'addpotofolioscreen.dart';

class PortofolioScreen extends StatelessWidget {
  const PortofolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortofolioProvider>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: portfolioProvider.items.isEmpty
          ? const Center(child: Text("No portfolio yet"))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: portfolioProvider.items.length,
              itemBuilder: (ctx, i) {
                final item = portfolioProvider.items[i];
                return buildProjectCard(
                  title: item.title,
                  description: item.description,
                  tech: item.category.isNotEmpty
                      ? [item.category]
                      : [], // bisa juga List<String>
                  imagePath: item.image,
                );
              },
            ),

            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color(0xFF2E3A59),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddPortfolioScreen()),
                );
              },
              child: const Icon(Icons.add, color: Colors.white), 
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
            child: imagePath.isNotEmpty
                ? Image.file(
                    File(imagePath),
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  )
                : Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: const Icon(Icons.work, size: 40),
                  ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: tech
                      .map((t) => Chip(
                            label: Text(t),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8),
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