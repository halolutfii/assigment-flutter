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
  final TextEditingController dateController = TextEditingController(); // Tambahkan dateController
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

  // Fungsi untuk memilih tanggal
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

  // Fetch Portofolios from Firestore
  Future<void> fetchPortofolios(String userId) async {
    portofolios = await _service.fetchPortofolios(userId);
    notifyListeners();
  }

  // Save Form - Create Portofolio
  Future<void> saveForm(BuildContext context, String userId) async {
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
      // Upload the image to Supabase Storage
      final imageUrl = await _service.uploadImage(selectedImage!, userId);

      // Create Portofolio object
      final newPortofolio = Portofolio(
        id: '', // Firestore will auto-generate the ID
        userId: userId,
        title: titleController.text,
        description: descriptionController.text,
        image: imageUrl, // Gambar yang di-upload
        category: selectedCategory ?? 'Other',
        projectLink: linkController.text,
      );

      // Create Portofolio in Firestore
      await _service.createPortofolio(newPortofolio);

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

      // Clear form and go back
      clearForm();
      Navigator.pop(context);
      await fetchPortofolios(userId); // reload list
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
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
}