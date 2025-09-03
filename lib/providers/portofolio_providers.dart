import 'dart:io';
import 'package:flutter/material.dart';
import '../models/portofolio.dart';
import '../services/portofolio_service.dart';
import 'package:image_picker/image_picker.dart';

class PortofolioProvider extends ChangeNotifier {
  final PortofolioService _service = PortofolioService();

  // Form controllers
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  String? selectedCategory;
  File? selectedImage;

  List<Portofolio> portofolios = [];
  bool isLoading = false; 

  void setCategory(String category) {
    selectedCategory = category;
    notifyListeners();
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImage = File(image.path);
      notifyListeners();
    }
  }

  Future<void> pickDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formatted = "${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      dateController.text = formatted;
      notifyListeners();
    }
  }

  // Create
  Future<void> fetchPortofolios() async {
    portofolios = await _service.fetchPortofolios();
    notifyListeners();
  }

  Future<void> saveForm(BuildContext context) async {
    if (!formKey.currentState!.validate()) return;
    if (selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.error, color: Colors.white),
              SizedBox(width: 8),
              Text("Please pick an image"),
            ],
          ),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
        ),
      );
      return;
    }

    try {
      // Upload image ke backend
      final imageUrl = await _service.uploadImage(selectedImage!);

      // Buat object Portofolio baru
      final newPortfolio = Portofolio(
        id: '',
        userId: '',
        title: titleController.text,
        description: descriptionController.text,
        image: imageUrl,
        category: selectedCategory ?? 'Other',
        projectLink: linkController.text,
      );

      // Kirim ke backend
      await _service.createPortofolio(newPortfolio);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: const [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text("Portfolio added successfully!"),
            ],
          ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 2),
        ),
      );

      clearForm();
      Navigator.pop(context);
      await fetchPortofolios(); // reload list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> deletePortfolio(String id) async {
    try {
      await _service.deletePortofolio(id);
      portofolios.removeWhere((p) => p.id == id);
      notifyListeners();
      ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
        const SnackBar(content: Text('Portfolio deleted!'), backgroundColor: Colors.green),
      );
    } catch (e) {
      ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  void clearForm() {
    titleController.clear();
    descriptionController.clear();
    dateController.clear();
    linkController.clear();
    selectedCategory = null;
    selectedImage = null;
    notifyListeners();
  }

  
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;
}