import 'package:flutter/foundation.dart';
import '../db/database_helper.dart';
import '../models/category_model.dart';

class CategoryProvider extends ChangeNotifier {
  final dbHelper = DatabaseHelper.instance;
  List<CategoryModel> _categories = [];
  bool _isLoading = false;

  List<CategoryModel> get categories => _categories;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await dbHelper.getCategories();

    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> addCategory(CategoryModel category) async {
    await dbHelper.insertCategory(category);
    await loadCategories();
  }

  Future<void> updateCategory(CategoryModel category) async {
    await dbHelper.updateCategory(category);
    await loadCategories();
  }

  Future<void> deleteCategory(int id) async {
    await dbHelper.deleteCategory(id);
    await loadCategories();
  }
}
