import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/portofolio_providers.dart';
import '../../widgets/project_card.dart';

class MobileTab extends StatelessWidget {
  const MobileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortofolioProvider>(context);

    final mobileItems = portfolioProvider.portofolios
        .where((p) => p.category.toLowerCase() == "mobile app")
        .toList();

    if (mobileItems.isEmpty) {
      return const Center(child: Text("No mobile projects yet"));
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: mobileItems.map((item) {
        return ProjectCard(
          title: item.title,
          description: item.description,
          tech: [item.category],
          imagePath: item.image,
        );
      }).toList(),
    );
  }
}