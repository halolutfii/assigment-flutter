import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/portofolio_providers.dart';
import '../../widgets/project_card.dart';

class WebTab extends StatelessWidget {
  const WebTab({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortofolioProvider>(context);

    if (portfolioProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final webItems = portfolioProvider.portofolios
        .where((p) => p.category.toLowerCase() == "website app")
        .toList();

    if (webItems.isEmpty) {
      return const Center(child: Text("No web projects yet"));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: webItems.map((item) {
        return ProjectCard(
          title: item.title,
          description: item.description,
          tech: [item.category],
          imagePath: item.image,
          projectLink: item.projectLink,
        );
      }).toList(),
    );
  }
}