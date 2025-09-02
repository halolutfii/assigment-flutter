import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/category_model.dart';
import '../providers/category_provider.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final nameController = TextEditingController();
  final descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<CategoryProvider>(context, listen: false).loadCategories());
  }

  void _addCategory() {
    final provider = Provider.of<CategoryProvider>(context, listen: false);
    if (nameController.text.isNotEmpty) {
      final category = CategoryModel(
        name: nameController.text,
        description: descController.text,
      );
      provider.addCategory(category);
      nameController.clear();
      descController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category Manager (SQLite + Provider)")),
      body: Consumer<CategoryProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              TextField(
                  controller: nameController,
                  decoration:
                      const InputDecoration(labelText: "Category Name")),
              TextField(
                  controller: descController,
                  decoration: const InputDecoration(labelText: "Description")),
              ElevatedButton(
                  onPressed: _addCategory, child: const Text("Add Category")),
              Expanded(
                child: ListView.builder(
                  itemCount: provider.categories.length,
                  itemBuilder: (context, index) {
                    final cat = provider.categories[index];
                    return ListTile(
                      title: Text(cat.name),
                      subtitle: Text(cat.description),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => provider.deleteCategory(cat.id!),
                      ),
                    );
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}