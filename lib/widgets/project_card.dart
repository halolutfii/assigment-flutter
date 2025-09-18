import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final List<String> tech;
  final String imagePath;
  final String projectLink;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    required this.tech,
    required this.imagePath,
    required this.projectLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: imagePath.isNotEmpty
                ? Image.network(
                    imagePath,
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (ctx, error, stackTrace) => Container(
                      width: 80,
                      height: 80,
                      color: Colors.grey[300],
                      child: const Icon(Icons.broken_image, size: 40),
                    ),
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
                // Project Title
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E3A59),
                  ),
                ),
                const SizedBox(height: 8),
                // Project Description
                Text(
                  description,
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                // Tech Chips + Share Button
                Row(
                  children: [
                    // Tech Chips
                    Wrap(
                      spacing: 6,
                      runSpacing: 4,
                      children: tech
                          .map((t) => Chip(
                                label: Text(
                                  t,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                backgroundColor: const Color(0xFF2E3A59),
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                              ))
                          .toList(),
                    ),
                    const SizedBox(width: 12),
                    // Share Button with Icon
                    IconButton(
                      icon: const Icon(
                        Icons.share,
                        color: Color(0xFF2E3A59),
                      ),
                      onPressed: () {
                        // Create the share message
                        String message = 'Check out my project: $title\nGitHub Link: $projectLink';
                        
                        // Trigger the share dialog
                        Share.share(message);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}