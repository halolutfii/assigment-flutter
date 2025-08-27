import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/portofolio_providers.dart';
import '../../widgets/project_card.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    final portfolioProvider = Provider.of<PortofolioProvider>(context);

    if (portfolioProvider.items.isEmpty) {
      return const Center(child: Text("No portfolio yet"));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: portfolioProvider.items.length,
      itemBuilder: (ctx, i) {
        final item = portfolioProvider.items[i];
        return ProjectCard(
          title: item.title,
          description: item.description,
          tech: item.category.isNotEmpty ? [item.category] : [],
          imagePath: item.image,
        );
      },
    );
  }
}